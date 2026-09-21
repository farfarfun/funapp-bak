//VideoGenerateFromResource resource

import 'package:funapp/tiktok/data/data_factory.dart';

/// API endpoint. Override with `--dart-define=FUNAPP_API_URL=...` for a
/// deployment-specific backend.
const String baseUrl = String.fromEnvironment(
  'FUNAPP_API_URL',
  defaultValue: 'http://127.0.0.1:8446/',
);

DataGenerate generate = DataGenerate(baseUrl);
VideoGenerateFromResource resource = VideoGenerateFromResource(generate);

Future<void> initDataGenerate() async {
  await resource.cacheData(pageSize: 20);
  await resource.next();
}

VideoGenerateFromResource getResource() {
  return resource;
}
