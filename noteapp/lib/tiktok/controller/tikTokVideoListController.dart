import 'dart:async';

import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/common/domain/base.dart';
import 'package:noteapp/common/video/skin/panel.dart';
import 'package:noteapp/common/video/skin/schema.dart';
import 'package:noteapp/common/video/video_panel.dart';

typedef LoadMoreVideo = Future<List<VPVideoController>> Function(
  int index,
  List<VPVideoController> list,
);

/// TikTokVideoListController是一系列视频的控制器，内部管理了视频控制器数组
/// 提供了预加载/释放/加载更多功能
class TikTokVideoListController extends ChangeNotifier {
  TikTokVideoListController({
    this.loadMoreCount = 3,
    this.preloadCount = 5,
    this.disposeCount = 0,
  });

  /// 到第几个触发预加载，例如:1:最后一个，2:倒数第二个
  final int loadMoreCount;

  /// 每次预加载多少个视频
  final int preloadCount;

  /// 超出多少个，就释放视频
  final int disposeCount;

  /// 提供视频的builder
  LoadMoreVideo? _videoProvider;

  loadIndex(int target, {bool reload = false}) {
    if (!reload) {
      if (index.value == target) return;
    }
    // 播放当前的，暂停其他的
    var oldIndex = index.value;
    var newIndex = target;

    // 暂停之前的视频
    if (!(oldIndex == 0 && newIndex == 0)) {
      playerOfIndex(oldIndex)?.pause();
      print('暂停$oldIndex');
    }
    // 开始播放当前的视频
    playerOfIndex(newIndex)?.play();
    print('播放$newIndex');
    // 处理预加载/释放内存
    for (var i = 0; i < playerList.length; i++) {
      // 需要释放[disposeCount]之前的视频
      if (i < newIndex - disposeCount || i > newIndex + disposeCount) {
        print('释放$i');
        playerOfIndex(i)?.dispose();
      } else {
        // 需要预加载
        if (i > newIndex && i < newIndex + preloadCount) {
          print('预加载$i');
          playerOfIndex(i)?.init();
        }
      }
    }

    // 快到最底部，添加更多视频
    if (playerList.length - newIndex <= loadMoreCount + 1) {
      _videoProvider?.call(newIndex, playerList).then(
        (list) async {
          playerList.addAll(list);
          notifyListeners();
        },
      );
    }

    // 完成
    index.value = target;
  }

  /// 获取指定index的player
  VPVideoController? playerOfIndex(int index) {
    if (index < 0 || index > playerList.length - 1) {
      return null;
    }
    return playerList[index];
  }

  /// 视频总数目
  int get videoCount => playerList.length;

  /// 初始化
  init({
    required PageController pageController,
    required List<VPVideoController> initialList,
    required LoadMoreVideo videoProvider,
  }) async {
    playerList.addAll(initialList);
    _videoProvider = videoProvider;
    pageController.addListener(() {
      var p = pageController.page!;
      if (p % 1 == 0) {
        loadIndex(p ~/ 1);
      }
    });
    loadIndex(0, reload: true);
    notifyListeners();
  }

  /// 目前的视频序号
  ValueNotifier<int> index = ValueNotifier<int>(0);

  /// 视频列表
  List<VPVideoController> playerList = [];

  ///
  VPVideoController get currentPlayer => playerList[index.value];

  /// 销毁全部
  void dispose() {
    // 销毁全部
    for (var player in playerList) {
      player.dispose();
    }
    playerList = [];
    super.dispose();
  }
}

typedef ControllerSetter<T> = Future<void> Function(T controller);
typedef ControllerBuilder<T> = T Function();

class VPVideoController {
  VideoDetail videoInfo;
  FijkPlayer player = FijkPlayer();
  Widget? videoWidget;

  VPVideoController({
    required this.videoInfo,
  }) {
    this.videoWidget = this.buildWidget();
  }

  bool get isDispose => _disposeLock != null;

  Completer<void>? _disposeLock;

  /// 异步方法并发锁
  Completer<void>? _syncLock;

  /// 防止异步方法并发
  Future<void> _syncCall(Future Function()? fn) async {
    // 设置同步等待
    var lastCompleter = _syncLock;
    var completer = Completer<void>();
    _syncLock = completer;
    // 等待其他同步任务完成
    await lastCompleter?.future;
    // 主任务
    await fn?.call();
    // 结束
    completer.complete();
  }

  void init() {
    player.prepareAsync();
  }

  void pause() {
    player.pause();
  }

  void play() {
    player.start();
  }

  void dispose() {
    player.dispose();
  }

  Widget buildWidget() {
    ShowConfigAbs vConfig = PlayerShowConfig();
    VideoSourceFormat _videoSourceTabs =
        VideoSourceFormat.fromJson(videoInfo.getVideoList());

    return Column(
      children: [
        FijkView(
          height: 780,
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
              playerTitle: videoInfo.title,

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
