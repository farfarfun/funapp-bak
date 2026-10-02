import 'package:flutter/material.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:funapp/common/cards/author_card.dart';
import 'package:funapp/common/cards/social_card.dart';
import 'package:funapp/common/cards/video_card.dart';
import 'package:funapp/common/domain/base.dart';
import 'package:funapp/common/image/image.dart';

/// 为 [videoDetail] 创建视频资源视图。
///
/// [context] 为可选构建上下文，[index] 用于标识可见性监听项。
Widget getResourceVideo(VideoDetail videoDetail,
    [BuildContext? context, int index = 0]) {
  return Container(
    width: double.infinity,
    height: 300.0,
    alignment: Alignment.center,
    margin: const EdgeInsets.symmetric(vertical: 50.0),
    child: LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return InViewNotifierWidget(
          id: '$index',
          builder: (BuildContext context, bool isInView, Widget? child) {
            return VideoDetailView(
              videoDetail,
              onPlay: isInView,
            );
          },
        );
      },
    ),
  );
}

/// 为 [imageDetail] 创建单图资源视图。
///
/// [context] 与 [index] 保留给统一的资源构建接口使用。
Widget getResourceImage(ImageDetail imageDetail,
    [BuildContext? context, int index = 0]) {
  return imageCard(imageDetail);
}

/// 为 [imageListDetail] 创建多图资源视图。
///
/// [context] 与 [index] 保留给统一的资源构建接口使用。
Widget getResourceImageList(ImageListDetail imageListDetail,
    [BuildContext? context, int index = 0]) {
  return imageListCard(imageListDetail);
}

/// 根据 [resourceInfo] 的类型创建对应资源卡片。
///
/// [context] 为可选构建上下文，[index] 用于标识视频可见性监听项。
Widget getResource(ResourceDetail resourceInfo,
    [BuildContext? context, int index = 0]) {
  Widget resource = getResourceVideo(
    VideoDetail(
        url:
            'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'),
    context,
    index,
  );
  if (resourceInfo.type == ResourceType.video) {
    resource = getResourceVideo(resourceInfo as VideoDetail, context, index);
  } else if (resourceInfo.type == ResourceType.pic) {
    resource = getResourceImage(resourceInfo as ImageDetail, context, index);
  } else if (resourceInfo.type == ResourceType.pics) {
    resource =
        getResourceImageList(resourceInfo as ImageListDetail, context, index);
  }

  return ResourceCard(resourceInfo, resource);
}

/// 展示资源作者、资源内容和社交操作的组合卡片。
class ResourceCard extends StatefulWidget {
  ResourceDetail resourceDetail;
  Widget resource;

  /// 使用 [resourceDetail] 和已构建的 [resource] 内容创建卡片。
  ResourceCard(this.resourceDetail, this.resource, {Key? key})
      : super(key: key);

  @override
  _ResourceCard createState() => _ResourceCard();
}

class _ResourceCard extends State<ResourceCard>
    with SingleTickerProviderStateMixin {
  _ResourceCard();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AuthorCard(widget.resourceDetail.author),
        widget.resource,
        SocialCard(widget.resourceDetail)
      ],
    );
  }
}
