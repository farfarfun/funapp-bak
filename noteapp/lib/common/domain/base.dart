import 'package:noteapp/common/domain/author.dart';

//
enum ResourceType { video, pic, pics, none }

class ResourceDetail {
  Author author = mockAuthor;
  ResourceType type;
  double height;
  ResourceDetail(this.type, {Author? author, this.height = 300}) {
    this.author = author ?? mockAuthor;
  }
}

class EmptyDetail extends ResourceDetail {
  EmptyDetail() : super(ResourceType.none) {}
}

class VideoDetail extends ResourceDetail {
  String url;
  String title;

  VideoDetail({
    this.url = "",
    this.title = "",
    //height = 300
  }) : super(ResourceType.video) {
    //this.height = height;
  }

  Map<String, List<Map<String, dynamic>>> getVideoList() {
    return {
      "video": [
        {
          "name": "线路资源一",
          "list": [
            {"url": url, "name": "视频名称"},
          ]
        }
      ]
    };
  }
}

class ImageDetail extends ResourceDetail {
  String url;
  String title;
  ImageDetail(this.url, {this.title = ""}) : super(ResourceType.pic) {}

  String getUrls() {
    return url;
  }

  String getTitle() {
    return title;
  }
}

class ImageListDetail extends ResourceDetail {
  List<String> urls;
  String title;
  ImageListDetail(this.urls, {this.title = ""}) : super(ResourceType.pics) {}

  List<String> getUrls() {
    return urls;
  }

  String getTitle() {
    return title;
  }
}
