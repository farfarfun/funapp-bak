import 'dart:async';

/// Small helpers for delaying and limiting callbacks.
class CommonUtils {
  /// Default delay in milliseconds for [antiShake] and [throttle].
  static const int defaultDurationTime = 300;
  static Timer? timer;

  /// Runs [doSomething] after input has been idle for [durationTime] ms.
  static void antiShake(void Function()? doSomething,
      {int durationTime = defaultDurationTime}) {
    timer?.cancel();
    timer = Timer(Duration(milliseconds: durationTime), () {
      doSomething?.call();
      timer = null;
    });
  }

  /// Runs [doSomething] at most once per [durationTime] milliseconds.
  static int startTime = 0;

  static void throttle(void Function()? doSomething,
      {int durationTime = defaultDurationTime}) {
    int currentTime = DateTime.now().millisecondsSinceEpoch;
    if (currentTime - startTime > durationTime) {
      doSomething?.call();
      startTime = DateTime.now().millisecondsSinceEpoch;
    }
  }
}
