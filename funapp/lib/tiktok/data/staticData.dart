//VideoGenerateFromResource resource

import 'package:funapp/tiktok/data/data_factory.dart';

final String baseUrl = 'http://47.91.11.122:8446/';

DataGenerate generate = DataGenerate(baseUrl);
VideoGenerateFromResource resource = VideoGenerateFromResource(generate);

Future<void> initDataGenerate() async {
  await resource.cacheData(pageSize: 20);
  await resource.next();
}

VideoGenerateFromResource getResource() {
  return resource;
}
