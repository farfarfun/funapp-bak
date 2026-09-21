import 'package:flutter_test/flutter_test.dart';
import 'package:funapp/util/common_util.dart';

void main() {
  test('throttle invokes the callback on the first call', () {
    var calls = 0;
    CommonUtils.throttle(() => calls++);
    expect(calls, 1);
  });
}
