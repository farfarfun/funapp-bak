/// 表示单个视频资源条目。
///
/// [url] 为视频地址，[name] 为展示名称。
class VideoSourceFormatVideoList {
/*
{
  "url": "https://n1.szjal.cn/20210428/lsNZ6QAL/index.m3u8",
  "name": "综艺"
}
*/
  /// 视频播放地址。
  String? url;

  /// 视频展示名称。
  String? name;

  /// 使用可选的视频 [url] 和展示 [name] 创建条目。
  VideoSourceFormatVideoList({
    this.url,
    this.name,
  });

  /// 从 [json] 创建视频资源条目。
  VideoSourceFormatVideoList.fromJson(Map<String, dynamic> json) {
    url = json["url"]?.toString();
    name = json["name"]?.toString();
  }

  /// 返回可用于序列化的 JSON 映射。
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["url"] = url;
    data["name"] = name;
    return data;
  }
}

/// 表示一个带名称的视频资源分组。
///
/// [name] 为分组名称，[list] 为分组内的视频条目。
class VideoSourceFormatVideo {
/*
{
  "name": "天空资源",
  "list": [
    {
      "url": "https://n1.szjal.cn/20210428/lsNZ6QAL/index.m3u8",
      "name": "综艺"
    }
  ]
}
*/

  /// 分组展示名称。
  String? name;

  /// 分组包含的视频条目。
  List<VideoSourceFormatVideoList?>? list;

  /// 使用可选分组 [name] 和视频 [list] 创建分组。
  VideoSourceFormatVideo({
    this.name,
    this.list,
  });

  /// 从 [json] 创建视频资源分组。
  VideoSourceFormatVideo.fromJson(Map<String, dynamic> json) {
    name = json["name"]?.toString();
    if (json["list"] != null) {
      final v = json["list"];
      final arr0 = <VideoSourceFormatVideoList>[];
      v.forEach((v) {
        arr0.add(VideoSourceFormatVideoList.fromJson(v));
      });
      list = arr0;
    }
  }

  /// 返回可用于序列化的 JSON 映射。
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["name"] = name;
    if (list != null) {
      final v = list;
      final arr0 = [];
      for (var v in v!) {
        arr0.add(v!.toJson());
      }
      data["list"] = arr0;
    }
    return data;
  }
}

/// 表示完整的视频资源格式。
///
/// [video] 包含全部视频资源分组。
class VideoSourceFormat {
/*
{
  "video": [
    {
      "name": "天空资源",
      "list": [
        {
          "url": "https://n1.szjal.cn/20210428/lsNZ6QAL/index.m3u8",
          "name": "综艺"
        }
      ]
    }
  ]
}
*/

  /// 全部视频资源分组。
  List<VideoSourceFormatVideo?>? video;

  /// 使用可选的视频分组 [video] 创建格式。
  VideoSourceFormat({
    this.video,
  });

  /// 从 [json] 创建视频资源格式。
  VideoSourceFormat.fromJson(Map<String, dynamic> json) {
    if (json["video"] != null) {
      final v = json["video"];
      final arr0 = <VideoSourceFormatVideo>[];
      v.forEach((v) {
        arr0.add(VideoSourceFormatVideo.fromJson(v));
      });
      video = arr0;
    }
  }

  /// 返回可用于序列化的 JSON 映射。
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (video != null) {
      final v = video;
      final arr0 = [];
      for (var v in v!) {
        arr0.add(v!.toJson());
      }
      data["video"] = arr0;
    }
    return data;
  }
}
