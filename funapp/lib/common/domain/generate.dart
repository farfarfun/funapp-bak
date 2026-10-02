import 'package:funapp/common/domain/base.dart';

//
VideoDetail defaultVideo = VideoDetail();
ImageDetail defaultImage = ImageDetail(
    "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg.jj20.com%2Fup%2Fallimg%2F811%2F091214203241%2F140912203241-2-1200.jpg&refer=http%3A%2F%2Fimg.jj20.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1653893347&t=486c68ebd9c196df4c4dcd4930eca73d");
ImageListDetail defaultImageList = ImageListDetail([
  "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fdesk-fd.zol-img.com.cn%2Ft_s960x600c5%2Fg5%2FM00%2F02%2F05%2FChMkJ1bKyaOIB1YfAAusnvE99Z8AALIQQPgER4AC6y2052.jpg&refer=http%3A%2F%2Fdesk-fd.zol-img.com.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1653893347&t=e81cdb517382b238ab0add7d593d82f9",
  "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fpic1.win4000.com%2Fwallpaper%2F2018-06-15%2F5b236a18acfc0.jpg&refer=http%3A%2F%2Fpic1.win4000.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1653893347&t=e9803366ccc95d31830d7feff2853949",
  "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fpic1.win4000.com%2Fwallpaper%2Fc%2F54376f06e80b6.jpg%3Fdown&refer=http%3A%2F%2Fpic1.win4000.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1653893347&t=73588f90d5cae45689208109ddd08cff"
]);

/// 提供通用资源对象的基础生成器。
class ResourceGenerate {
  /// 创建资源生成器。
  ResourceGenerate();

  /// 返回下一个默认资源对象。
  ResourceDetail next() {
    return defaultImage;
  }
}

/// 提供视频资源的生成器。
class VideoGenerate extends ResourceGenerate {
  /// 创建视频资源生成器。
  VideoGenerate();

  /// 返回下一个视频对象。
  VideoDetail next() {
    return VideoDetail();
  }

  /// 返回包含 [size] 个视频的列表。
  List<VideoDetail> nextList(int size) {
    return List.empty();
  }
}
