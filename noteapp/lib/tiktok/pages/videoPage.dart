import 'package:flutter/material.dart';
import 'package:noteapp/common/domain/base.dart';
import 'package:noteapp/page/home.dart';
import 'package:noteapp/tiktok/controller/tikTokVideoListController.dart';
import 'package:noteapp/tiktok/data/data_factory.dart';
import 'package:noteapp/tiktok/other/bottomSheet.dart' as CustomBottomSheet;
import 'package:noteapp/tiktok/pages/followPage.dart';
import 'package:noteapp/tiktok/pages/userPage.dart';
import 'package:noteapp/tiktok/style/physics.dart';
import 'package:noteapp/tiktok/views/appBar.dart';
import 'package:noteapp/tiktok/views/appBottomSheet.dart';
import 'package:noteapp/tiktok/views/video.dart';
import 'package:noteapp/tiktok/views/videoButtonColumn.dart';
import 'package:video_player/video_player.dart';

class TiktokVideoPage extends StatefulWidget {
  late DataGenerate generate;
  TiktokVideoPage(String baseUrl, {Key? key}) : super(key: key) {
    generate = DataGenerate(baseUrl);
  }
  @override
  _TiktokVideoPageState createState() => _TiktokVideoPageState();
}

class _TiktokVideoPageState extends State<TiktokVideoPage>
    with WidgetsBindingObserver {
  TikTokPageTag tabBarType = TikTokPageTag.home;

  final PageController _pageController = PageController();
  final TikTokVideoListController _videoListController =
      TikTokVideoListController();

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state != AppLifecycleState.resumed) {
      _videoListController.currentPlayer.pause();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    _videoListController.currentPlayer.pause();
    super.dispose();
  }

  @override
  void initState() {
    VideoGenerateFromResource generate =
        VideoGenerateFromResource(widget.generate);

    WidgetsBinding.instance!.addObserver(this);
    _videoListController.init(
      pageController: _pageController,
      initialList: generate
          .nextList(2)
          .map(
            (e) => VPVideoController(
              videoInfo: e,
              builder: () => VideoPlayerController.network(e.url),
            ),
          )
          .toList(),
      videoProvider: (int index, List<VPVideoController> list) async {
        return generate
            .nextList(5)
            .map(
              (e) => VPVideoController(
                videoInfo: e,
                builder: () => VideoPlayerController.network(e.url),
              ),
            )
            .toList();
      },
    );
    _videoListController.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget? currentPage;

    switch (tabBarType) {
      case TikTokPageTag.home:
        break;
      case TikTokPageTag.follow:
        currentPage = FollowPage();
        break;
      case TikTokPageTag.me:
        currentPage = const TikTokUserPage(isSelfPage: true);
        break;
    }

    double a = MediaQuery.of(context).size.aspectRatio;
    bool hasBottomPadding = a < 0.55;

    bool hasBackground = hasBottomPadding;
    hasBackground = tabBarType != TikTokPageTag.home;
    if (hasBottomPadding) {
      hasBackground = true;
    }
    Widget tikTokTabBar = TikTokTabBar(
      hasBackground: hasBackground,
      current: tabBarType,
      onTabSwitch: (type) async {
        setState(() {
          tabBarType = type;
          if (type == TikTokPageTag.home) {
            _videoListController.currentPlayer.play();
          } else {
            _videoListController.currentPlayer.pause();
          }
        });
      },
      onAddButton: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) => const HomePageDetail(),
          ),
        );
      },
    );

    // 组合
    return Stack(
      // index: currentPage == null ? 0 : 1,
      children: <Widget>[
        PageView.builder(
          key: const Key('home'),
          physics: const QuickerScrollPhysics(),
          controller: _pageController,
          scrollDirection: Axis.vertical,
          itemCount: _videoListController.videoCount,
          itemBuilder: (context, i) {
            // 拼一个视频组件出来
            bool isF = false;
            var player = _videoListController.playerOfIndex(i)!;
            VideoDetail videoDetail = player.videoInfo!;
            // 右侧按钮列
            Widget buttons = TikTokButtonColumn(
              isFavorite: isF,
              onAvatar: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return TikTokUserPage(
                    author: videoDetail.author,
                  );
                }));
              },
              onFavorite: () {
                setState(() {
                  widget.generate
                      .addFavorite("0", "resourceId", sourceId: "sourceId");
                });
              },
              onComment: () {
                CustomBottomSheet.showModalBottomSheet(
                  backgroundColor: Colors.white.withOpacity(0),
                  context: context,
                  builder: (BuildContext context) =>
                      const TikTokCommentBottomSheet(),
                );
              },
              onShare: () {},
            );
            // video
            Widget currentVideo = Center(
              child: AspectRatio(
                aspectRatio: player.controller.value.aspectRatio,
                child: VideoPlayer(player.controller),
              ),
            );

            currentVideo = TikTokVideoPage(
              // 手势播放与自然播放都会产生暂停按钮状态变化，待处理
              hidePauseIcon: !player.showPauseIcon.value,
              aspectRatio: 9 / 16.0,
              key: Key(videoDetail.url + '$i'),
              tag: videoDetail.url,
              bottomPadding: hasBottomPadding ? 16.0 : 16.0,

              userInfoWidget: VideoUserInfo(
                videoDetail.author,
                desc: videoDetail.desc,
                bottomPadding: hasBottomPadding ? 16.0 : 50.0,
              ),
              onSingleTap: () async {
                if (player.controller.value.isPlaying) {
                  await player.pause();
                } else {
                  await player.play();
                }
                setState(() {});
              },
              onAddFavorite: () {
                setState(() {
                  widget.generate
                      .addFavorite("0", "resourceId", sourceId: "sourceId");
                });
              },
              rightButtonColumn: buttons,
              video: currentVideo,
            );
            return currentVideo;
          },
        ),
        currentPage ?? Container(),
      ],
    );
  }
}
