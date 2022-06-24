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
  VideoDetail videoInfo;
  VideoDetailView(this.videoInfo, {Key? key, this.onPlay = false})
      : super(key: key);

  @override
  _VideoDetailViewState createState() => _VideoDetailViewState();
}

class _VideoDetailViewState extends State<VideoDetailView>
    with SingleTickerProviderStateMixin {
  final FijkPlayer player = FijkPlayer();

  _VideoDetailViewState();
  VideoSourceFormat? _videoSourceTabs;

  ShowConfigAbs vConfig = PlayerShowConfig();

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _videoSourceTabs =
        VideoSourceFormat.fromJson(widget.videoInfo.getVideoList());

    //这句不能省，必须有
    speed = 1.0;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FijkView(
          height: 260,
          color: Colors.black,
          fit: FijkFit.cover,
          player: player,
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

  @override
  void didUpdateWidget(covariant VideoDetailView oldWidget) {
    if (widget.onPlay) {
      player.start();
    } else {
      player.pause();
    }
    super.didUpdateWidget(oldWidget);
  }
}
