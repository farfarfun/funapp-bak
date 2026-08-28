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

  Future<List<VideoDetail>> getResource(
      {int pageNo = 1, int pageSize = 10}) async {
    Map<String, dynamic> queryParameters = {};
    queryParameters['page_no'] = pageNo;
    queryParameters['page_size'] = pageSize;
    queryParameters['token'] = Settings.getValue<String>(
        'notetiktok-video-secret-key',
        defaultValue: 'funapp_secret');

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
    queryParameters['token'] = Settings.getValue<String>(
        'notetiktok-video-secret-key',
        defaultValue: 'funapp_secret');

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
