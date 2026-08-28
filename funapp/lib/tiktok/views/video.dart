import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:funapp/common/domain/author.dart';
import 'package:funapp/tiktok/style/style.dart';

///
/// TikTok风格的一个视频页组件，覆盖在video上，提供以下功能:
/// 播放按钮的遮罩
/// 单击事件
/// 点赞事件回调（每次）
/// 长宽比控制
/// 底部padding（用于适配有沉浸式底部状态栏时）
///
class TikTokVideoPage extends StatelessWidget {
  final Widget? video;
  final double aspectRatio;
  final String? tag;
  final double bottomPadding;

  final Widget? rightButtonColumn;
  final Widget? userInfoWidget;

  const TikTokVideoPage({
    Key? key,
    this.bottomPadding = 16,
    this.tag,
    this.rightButtonColumn,
    this.userInfoWidget,
    this.video,
    this.aspectRatio = 9 / 16.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 右边的按钮列表
    Widget rightButtons = rightButtonColumn ?? Container();
    // 用户信息
    Widget userInfo = userInfoWidget ??
        VideoUserInfo(
          new Author(),
          bottomPadding: bottomPadding,
        );
    // 视频播放页
    Widget videoContainer = Stack(
      children: <Widget>[
        Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.black,
          //alignment: Alignment.center,
          alignment: Alignment.topCenter,
          child: AspectRatio(
            aspectRatio: aspectRatio,
            child: video,
          ),
        )
      ],
    );

    Widget body = Stack(
      children: <Widget>[
        videoContainer,
        Container(
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.bottomRight,
          child: rightButtons,
        ),
        Container(
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.bottomLeft,
          child: userInfo,
        ),
      ],
    );
    return body;
  }
}

class VideoLoadingPlaceHolder extends StatelessWidget {
  const VideoLoadingPlaceHolder({
    Key? key,
    required this.tag,
  }) : super(key: key);

  final String tag;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          colors: <Color>[
            Colors.blue,
            Colors.green,
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SpinKitWave(
            size: 36,
            color: Colors.white.withOpacity(0.3),
          ),
          Container(
            padding: const EdgeInsets.all(50),
            child: Text(
              tag,
              style: StandardTextStyle.normalWithOpacity,
            ),
          ),
        ],
      ),
    );
  }
}

class VideoUserInfo extends StatelessWidget {
  final String? desc;
  final Author author;
  final double bottomPadding;

  VideoUserInfo(this.author, {this.desc, required this.bottomPadding, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 12,
        bottom: bottomPadding,
      ),
      margin: const EdgeInsets.only(right: 80),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '@' + author.name,
            style: StandardTextStyle.big,
          ),
          Container(height: 6),
          Text(
            author.desc,
            style: StandardTextStyle.normal,
          ),
          Container(height: 6),
          Row(
            children: <Widget>[
              Icon(Icons.music_note, size: 14),
              Expanded(
                child: Text(
                  author.name,
                  maxLines: 9,
                  style: StandardTextStyle.normal,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
