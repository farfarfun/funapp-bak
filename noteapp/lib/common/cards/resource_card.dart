import 'package:flutter/material.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:noteapp/common/cards/author_card.dart';
import 'package:noteapp/common/cards/social_card.dart';
import 'package:noteapp/common/cards/video_card.dart';
import 'package:noteapp/common/domain/base.dart';
import 'package:noteapp/common/image/image.dart';

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

Widget getResourceImage(ImageDetail imageDetail,
    [BuildContext? context, int index = 0]) {
  return imageCard(imageDetail);
}

Widget getResourceImageList(ImageListDetail imageListDetail,
    [BuildContext? context, int index = 0]) {
  return imageListCard(imageListDetail);
}

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

class ResourceCard extends StatefulWidget {
  ResourceDetail resourceDetail;
  Widget resource;
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
