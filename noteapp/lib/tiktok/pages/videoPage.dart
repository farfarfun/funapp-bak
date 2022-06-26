import 'package:flutter/material.dart';
import 'package:noteapp/common/domain/base.dart';
import 'package:noteapp/tiktok/controller/tikTokVideoListController.dart';
import 'package:noteapp/tiktok/data/data_factory.dart';
import 'package:noteapp/tiktok/data/staticData.dart';
import 'package:noteapp/tiktok/other/bottomSheet.dart' as CustomBottomSheet;
import 'package:noteapp/tiktok/pages/userPage.dart';
import 'package:noteapp/tiktok/style/physics.dart';
import 'package:noteapp/tiktok/views/appBottomSheet.dart';
import 'package:noteapp/tiktok/views/video.dart';
import 'package:noteapp/tiktok/views/videoButtonColumn.dart';

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
    // VideoGenerateFromResource generate =
    //     VideoGenerateFromResource(widget.generate);
    VideoGenerateFromResource generate = getResource();

    WidgetsBinding.instance!.addObserver(this);
    _videoListController.init(
      pageController: _pageController,
      initialList: generate
          .nextList(2)
          .map((e) => VPVideoController(videoInfo: e))
          .toList(),
      videoProvider: (int index, List<VPVideoController> list) async {
        return generate
            .nextList(5)
            .map((e) => VPVideoController(videoInfo: e))
            .toList();
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget? currentPage;

    double a = MediaQuery.of(context).size.aspectRatio;
    bool hasBottomPadding = a < 0.55;

    return Scaffold(
      body: Stack(
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
              VideoDetail videoDetail = player.videoInfo;
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
              Widget tiktokVideo = TikTokVideoPage(
                aspectRatio: 9 / 16.0,
                key: Key(videoDetail.url + '$i'),
                tag: videoDetail.url,
                bottomPadding: hasBottomPadding ? 16.0 : 16.0,
                userInfoWidget: VideoUserInfo(
                  videoDetail.author,
                  desc: videoDetail.desc,
                  bottomPadding: hasBottomPadding ? 16.0 : 50.0,
                ),
                rightButtonColumn: buttons,
                video: player.videoDetailView,
              );
              return tiktokVideo;
            },
          ),
          currentPage ?? Container(),
        ],
      ),
    );
  }
}
