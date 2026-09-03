import 'dart:async';
import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:funapp/common/domain/base.dart';
import 'package:funapp/common/domain/generate.dart';

class DataGenerate {
  String baseUrl;

  DataGenerate(this.baseUrl) {}

  Future<Response> dioGet(String uri,
      {Map<String, dynamic>? queryParameters}) async {
    return Dio().get(baseUrl + uri, queryParameters: queryParameters);
  }

  /// 从设置中读取访问后端接口用的 token。
  ///
  /// 不再提供硬编码默认值：用户必须在「设置」页里自行配置
  /// `notetiktok-video-secret-key`，缺失时直接报错，避免所有安装共用同一个
  /// 内置默认凭据。
  String _requireSecretKey() {
    final token = Settings.getValue<String>('notetiktok-video-secret-key',
        defaultValue: '');
    if (token == null || token.isEmpty) {
      throw StateError(
          '未配置 notetiktok-video-secret-key，请先在「设置」页填写 SecretKey 后再试');
    }
    return token;
  }

  Future<List<VideoDetail>> getResource(
      {int pageNo = 1, int pageSize = 10}) async {
    Map<String, dynamic> queryParameters = {};
    queryParameters['page_no'] = pageNo;
    queryParameters['page_size'] = pageSize;
    queryParameters['token'] = _requireSecretKey();

    final response =
        await dioGet('tiktok/resource/get', queryParameters: queryParameters);

    if (response.statusCode == 200) {
      return response.data.map<VideoDetail>((item) {
        return VideoDetail.fromJson(item);
      }).toList();
    } else {
      return List.empty();
    }
  }

  Future<void> addVideo(String url) async {
    Map<String, dynamic> queryParameters = {};
    queryParameters['url'] = url;
    await dioGet('tiktok/resource/add/video', queryParameters: queryParameters);
  }

  Future<List<VideoDetail>> getFavorite(
      {int pageNo = 1, int pageSize = 10}) async {
    Map<String, dynamic> queryParameters = {};
    queryParameters['page_no'] = pageNo;
    queryParameters['page_size'] = pageSize;
    queryParameters['token'] = _requireSecretKey();

    final response =
        await dioGet('tiktok/resource/get', queryParameters: queryParameters);

    if (response.statusCode == 200) {
      return response.data.map<VideoDetail>((item) {
        return VideoDetail.fromJson(item);
      }).toList();
    } else {
      return List.empty();
    }
  }

  Future<void> addFavorite(String userId, String resourceId,
      {String sourceId = "0"}) async {
    Map<String, dynamic> queryParameters = {};
    queryParameters['user_id'] = userId;
    queryParameters['resource_id'] = resourceId;
    queryParameters['source_id'] = resourceId;
    await dioGet('tiktok/favorite/add', queryParameters: queryParameters);
  }
}

class VideoGenerateFromResource extends VideoGenerate {
  Queue<VideoDetail> cacheVideoQueue = Queue();
  DataGenerate generate;
  int cacheSize;
  int index = 0;

  VideoGenerateFromResource(this.generate, {this.cacheSize = 50});

  @override
  VideoDetail next() {
    if (cacheVideoQueue.length < cacheSize / 2) {
      index += 1;
      cacheData(pageNo: index, pageSize: 10);
    }

    if (cacheVideoQueue.isNotEmpty) {
      return cacheVideoQueue.removeFirst();
    } else {
      return VideoDetail();
    }
  }

  @override
  List<VideoDetail> nextList(int size) {
    List<VideoDetail> videoList = [];
    for (int i = 0; i < size; i++) {
      videoList.add(next());
    }
    return videoList;
  }

  Future<void> cacheData({int pageNo = 1, int pageSize = 10}) async {
    List<VideoDetail> videoList = await generate.getResource();
    cacheVideoQueue.addAll(videoList);
  }
}
