import 'package:flutter_test/flutter_test.dart';
import 'package:funapp/util/common_util.dart';

void main() {
  // CommonUtils 的节流/防抖状态是静态的，每个用例前必须复位，否则用例之间互相污染
  setUp(() {
    CommonUtils.timer?.cancel();
    CommonUtils.timer = null;
    CommonUtils.startTime = 0;
  });

  tearDown(() {
    CommonUtils.timer?.cancel();
    CommonUtils.timer = null;
  });

  group('throttle', () {
    test('首次调用直接放行', () {
      var calls = 0;
      CommonUtils.throttle(() => calls++);
      expect(calls, 1);
      expect(CommonUtils.startTime, greaterThan(0));
    });

    test('时间窗口内的后续调用被丢弃', () {
      var calls = 0;
      CommonUtils.throttle(() => calls++);
      CommonUtils.throttle(() => calls++);
      CommonUtils.throttle(() => calls++);
      expect(calls, 1);
    });

    test('时间窗口过去后重新放行', () async {
      var calls = 0;
      CommonUtils.throttle(() => calls++, durationTime: 20);
      expect(calls, 1);
      await Future<void>.delayed(const Duration(milliseconds: 60));
      CommonUtils.throttle(() => calls++, durationTime: 20);
      expect(calls, 2);
    });

    test('回调为 null 时不抛异常，但仍然刷新时间窗口', () {
      var calls = 0;
      expect(() => CommonUtils.throttle(null), returnsNormally);
      expect(CommonUtils.startTime, greaterThan(0));
      // 窗口已被上一次 null 调用占用，紧接着的真实回调应被丢弃
      CommonUtils.throttle(() => calls++);
      expect(calls, 0);
    });

    test('默认时间窗口为 300ms', () {
      expect(CommonUtils.defaultDurationTime, 300);
    });
  });

  group('antiShake', () {
    test('等待窗口内不执行回调', () async {
      var calls = 0;
      CommonUtils.antiShake(() => calls++, durationTime: 80);
      expect(calls, 0);
      expect(CommonUtils.timer, isNotNull);
      await Future<void>.delayed(const Duration(milliseconds: 20));
      expect(calls, 0);
    });

    test('静默期满后执行一次并清空定时器', () async {
      var calls = 0;
      CommonUtils.antiShake(() => calls++, durationTime: 20);
      await Future<void>.delayed(const Duration(milliseconds: 120));
      expect(calls, 1);
      expect(CommonUtils.timer, isNull);
    });

    test('连续调用只触发最后一次回调', () async {
      final fired = <String>[];
      CommonUtils.antiShake(() => fired.add('first'), durationTime: 40);
      CommonUtils.antiShake(() => fired.add('second'), durationTime: 40);
      CommonUtils.antiShake(() => fired.add('third'), durationTime: 40);
      await Future<void>.delayed(const Duration(milliseconds: 160));
      expect(fired, ['third']);
    });

    test('回调为 null 时不抛异常', () async {
      expect(
          () => CommonUtils.antiShake(null, durationTime: 10), returnsNormally);
      await Future<void>.delayed(const Duration(milliseconds: 80));
      expect(CommonUtils.timer, isNull);
    });
  });
}
