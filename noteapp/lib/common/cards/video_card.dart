import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/common/domain/base.dart';
import 'package:noteapp/common/video/skin/panel.dart';
import 'package:noteapp/common/video/skin/schema.dart' show VideoSourceFormat;
import 'package:noteapp/common/video/video_panel.dart';

// show 表示只导出 VideoSourceFormat 类
// https://blog.csdn.net/happiness365/article/details/122114145

class VideoDetailView extends StatefulWidget {
  bool onPlay;
  double height;
  VideoDetail videoInfo;
  final FijkPlayer player = FijkPlayer();
  VideoDetailView(this.videoInfo,
      {Key? key, this.onPlay = false, this.height = 240})
      : super(key: key) {}
  @override
  _VideoDetailViewState createState() => _VideoDetailViewState();
}

class _VideoDetailViewState extends State<VideoDetailView>
    with SingleTickerProviderStateMixin {
  _VideoDetailViewState() {
    _videoSourceTabs =
        VideoSourceFormat.fromJson(widget.videoInfo.getVideoList());
    speed = 1.0;
  }
  VideoSourceFormat? _videoSourceTabs;

  ShowConfigAbs vConfig = PlayerShowConfig();

  @override
  void didUpdateWidget(covariant VideoDetailView oldWidget) {
    if (widget.onPlay) {
      widget.player.start();
    } else {
      widget.player.pause();
    }
    super.didUpdateWidget(oldWidget);
  }

  // @override
  // void initState() {
  //   super.initState();
  //   _videoSourceTabs =
  //       VideoSourceFormat.fromJson(widget.videoInfo.getVideoList());

  //   //这句不能省，必须有
  //   speed = 1.0;
  // }

  @override
  void dispose() {
    widget.player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FijkView(
          height: widget.height,
          color: Colors.black,
          fit: FijkFit.cover,
          player: widget.player,
          panelBuilder: (FijkPlayer player, FijkData data, BuildContext context,
              Size viewSize, Rect texturePos) {
            return CustomFijkPanel(
              player: player,
              viewSize: viewSize,
              texturePos: texturePos,
              pageContent: context,

              //标题 当前页面顶部的标题部分
              playerTitle: widget.videoInfo.title,

              //视频显示的配置
              showConfig: vConfig,

              //json格式化后的视频数据
              videoFormat: _videoSourceTabs,

              //当前视频源 资源一 资源二等
              curTabIdx: 0,

              //当前视频 高清 标清 流畅等
              curActiveIdx: 0,
            );
          },
        ),
      ],
    );
  }
}
