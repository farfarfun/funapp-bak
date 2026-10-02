import 'dart:async';

/// 回调节流与防抖的通用工具。
class CommonUtils {
  /// [antiShake] 与 [throttle] 的默认时间窗口，单位毫秒。
  static const int defaultDurationTime = 300;

  /// [antiShake] 当前挂起的定时器，暴露出来便于测试与手动取消。
  static Timer? timer;

  /// 上一次 [throttle] 真正放行回调的时间戳（毫秒）。
  static int startTime = 0;

  /// 防抖：输入静默 [durationTime] 毫秒后才执行 [doSomething]。
  ///
  /// 窗口内的新调用会取消上一个挂起的定时器，所以连续调用只会触发最后一次。
  /// [doSomething] 为 null 时只重置定时器，不执行任何回调。
  static void antiShake(void Function()? doSomething,
      {int durationTime = defaultDurationTime}) {
    timer?.cancel();
    timer = Timer(Duration(milliseconds: durationTime), () {
      doSomething?.call();
      timer = null;
    });
  }

  /// 节流：每 [durationTime] 毫秒最多执行 [doSomething] 一次。
  ///
  /// 窗口内的后续调用直接丢弃，不会延后补偿执行。时间窗口记录在静态的
  /// [startTime] 上，整个应用共用同一份节流状态。
  static void throttle(void Function()? doSomething,
      {int durationTime = defaultDurationTime}) {
    int currentTime = DateTime.now().millisecondsSinceEpoch;
    if (currentTime - startTime > durationTime) {
      doSomething?.call();
      startTime = DateTime.now().millisecondsSinceEpoch;
    }
  }
}
