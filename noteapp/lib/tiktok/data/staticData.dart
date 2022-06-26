//VideoGenerateFromResource resource

import 'package:noteapp/tiktok/data/data_factory.dart';

final String baseUrl = 'http://47.91.11.122:8446/';

DataGenerate generate = DataGenerate(baseUrl);
VideoGenerateFromResource resource = VideoGenerateFromResource(generate);

Future<void> initDataGenerate() async {
  await resource.cacheData(pageNo: 1, pageSize: 10);
}

VideoGenerateFromResource getResource() {
  return resource;
}
