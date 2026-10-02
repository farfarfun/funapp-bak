import 'dart:async';
import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:funapp/common/domain/base.dart';
import 'package:funapp/common/domain/generate.dart';

/// 通过后端接口读取和更新短视频资源数据。
class DataGenerate {
  String baseUrl;

  /// 创建使用 [baseUrl] 作为接口根地址的数据访问对象。
  DataGenerate(this.baseUrl) {}

  /// 向相对路径 [uri] 发起 GET 请求，并附带可选的 [queryParameters]。
  ///
  /// 返回后端的原始响应；网络错误由 Dio 直接抛给调用方。
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

  /// 分页获取视频资源。
  ///
  /// [pageNo] 为页码，[pageSize] 为每页条数。返回解析后的视频列表；请求失败
  /// 时由 Dio 抛出异常，未配置访问 token 时抛出 [StateError]。
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

  /// 将 [url] 指向的视频提交给后端，完成后无返回值。
  ///
  /// 网络错误由 Dio 直接抛给调用方。
  Future<void> addVideo(String url) async {
    Map<String, dynamic> queryParameters = {};
    queryParameters['url'] = url;
    await dioGet('tiktok/resource/add/video', queryParameters: queryParameters);
  }

  /// 分页获取收藏的视频资源。
  ///
  /// [pageNo] 为页码，[pageSize] 为每页条数。返回解析后的视频列表；请求失败
  /// 时由 Dio 抛出异常，未配置访问 token 时抛出 [StateError]。
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

  /// 为 [userId] 添加资源 [resourceId] 到收藏，来源由 [sourceId] 标识。
  ///
  /// 请求完成后无返回值；网络错误由 Dio 直接抛给调用方。
  Future<void> addFavorite(String userId, String resourceId,
      {String sourceId = "0"}) async {
    Map<String, dynamic> queryParameters = {};
    queryParameters['user_id'] = userId;
    queryParameters['resource_id'] = resourceId;
    queryParameters['source_id'] = resourceId;
    await dioGet('tiktok/favorite/add', queryParameters: queryParameters);
  }
}

/// 使用 [DataGenerate] 分页缓存并依次提供视频资源。
class VideoGenerateFromResource extends VideoGenerate {
  Queue<VideoDetail> cacheVideoQueue = Queue();
  DataGenerate generate;
  int cacheSize;
  int index = 0;

  /// 创建视频生成器，并将最大缓存目标设为 [cacheSize]。
  VideoGenerateFromResource(this.generate, {this.cacheSize = 50});

  /// 返回下一个已缓存视频；缓存不足时异步触发补充，没有数据时返回空对象。
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

  /// 连续获取 [size] 个视频并返回列表。
  @override
  List<VideoDetail> nextList(int size) {
    List<VideoDetail> videoList = [];
    for (int i = 0; i < size; i++) {
      videoList.add(next());
    }
    return videoList;
  }

  /// 请求第 [pageNo] 页、每页 [pageSize] 条数据并加入缓存。
  ///
  /// 网络或解析错误会原样抛给调用方。
  Future<void> cacheData({int pageNo = 1, int pageSize = 10}) async {
    List<VideoDetail> videoList = await generate.getResource();
    cacheVideoQueue.addAll(videoList);
  }
}
