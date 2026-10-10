import 'package:flutter_test/flutter_test.dart';
import 'package:funapp/tiktok/data/data_factory.dart';

void main() {
  test('缺失运行时 SecretKey 时在发起请求前失败', () {
    final generate = DataGenerate('http://127.0.0.1/', secretKey: '');

    expect(generate.getResource(), throwsA(isA<StateError>()));
  });
}
