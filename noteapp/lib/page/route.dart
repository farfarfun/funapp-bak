import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/common/cards/video_card.dart';
import 'package:noteapp/common/data/mock.dart';
import 'package:noteapp/common/domain/base.dart';
import 'package:noteapp/common/domain/generate.dart';
import 'package:noteapp/common/resource/resource_list.dart';
import 'package:noteapp/tiktok/app.dart';
import 'package:noteapp/tiktok/data/data_factory.dart';
import 'package:noteapp/tiktok/pages/userPage.dart';
import 'package:noteapp/tiktok/pages/videoPage.dart';

ValueNotifier themeMode = ValueNotifier(2);

class RouterManage {
  static const home = '/';
  static const pathVideo = '/video';
  static const pathVideoList = '/video_list';
  static const pathImageList = '/image_list';
  static const pathImagesList = '/images_list';
  static const pathResourceList = '/resource_list';
  static const pathTiktok = '/tiktok';
  static const pathTiktokVideo = '/tiktok_video';
  static const pathTiktokUser = '/tiktok_user';
}

class RouteItem extends StatefulWidget {
  final String title;
  final String route;

  const RouteItem(this.title, this.route, {Key? key}) : super(key: key);

  @override
  State<RouteItem> createState() => _RouteItemState();
}

class _RouteItemState extends State<RouteItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: EdgeInsets.only(top: 30),
      child: CupertinoButton(
        child: Text(widget.title),
        color: Color.fromARGB(255, Random.secure().nextInt(255),
            Random.secure().nextInt(255), Random.secure().nextInt(255)),
        onPressed: () => Navigator.pushNamed(context, widget.route),
      ),
    );
  }
}

class RouteHome extends StatelessWidget {
  const RouteHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('noteapp'),
        actions: [
          IconButton(
              icon: const Icon(Icons.nightlight_round),
              onPressed: () {
                themeMode.value = themeMode.value == 1 ? 2 : 1;
              })
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            RouteItem('播放视频', RouterManage.pathVideo),
            RouteItem('视频列表', RouterManage.pathVideoList),
            RouteItem('图片列表', RouterManage.pathImageList),
            RouteItem('图片集合列表', RouterManage.pathImagesList),
            RouteItem('资源列表', RouterManage.pathResourceList),
            RouteItem('tiktok', RouterManage.pathTiktok),
            RouteItem('tiktok_video', RouterManage.pathTiktokVideo),
            RouteItem('tiktok_user', RouterManage.pathTiktokUser),
          ],
        ),
      ),
    );
  }
}

class RouteDetail extends StatefulWidget {
  const RouteDetail({Key? key}) : super(key: key);

  @override
  State<RouteDetail> createState() => _RouteDetailState();
}

class _RouteDetailState extends State<RouteDetail> {
  @override
  Widget build(BuildContext context) {
    String url = 'http://47.91.11.122:8446/';
    DataGenerate generate = DataGenerate(url);
    ResourceGenerate resGen = VideoGenerateFromResource(generate);

    return ValueListenableBuilder(
      valueListenable: ValueNotifier(2),
      builder: (context, value, g) {
        return MaterialApp(
          initialRoute: '/',
          darkTheme: ThemeData.dark(),
          themeMode: ThemeMode.values.toList()[value as int],
          debugShowCheckedModeBanner: false,
          routes: {
            RouterManage.home: (ctx) => const RouteHome(),
            RouterManage.pathVideo: (ctx) => VideoDetailView(VideoDetail(
                url: "https://media.w3.org/2010/05/sintel/trailer.mp4")),
            RouterManage.pathImageList: (ctx) =>
                ResourceListView(ResourceGenerateMock(type: ResourceType.pic)),
            RouterManage.pathImagesList: (ctx) =>
                ResourceListView(ResourceGenerateMock(type: ResourceType.pics)),
            RouterManage.pathVideoList: (ctx) => ResourceListView(resGen),
            RouterManage.pathResourceList: (ctx) =>
                ResourceListView(ResourceGenerateMock(type: ResourceType.none)),
            RouterManage.pathTiktok: (ctx) => TikTokApp(url),
            RouterManage.pathTiktokVideo: (ctx) => TiktokVideoPage(url),
            RouterManage.pathTiktokUser: (ctx) => TikTokUserPage(),
          },
        );
      },
    );
  }
}

class RouteDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'noteapp',
        //home: RouteHome(),
        routes: WGRouter.routes,
        initialRoute: WGRouter.home, //初始页面路由可代替home
        onGenerateRoute: WGRouter.generateRoute,
        onUnknownRoute: WGRouter.unknownRoute);
  }
}

class WGRouter {
  static const home = '/';
  static const pathVideo = '/video';
  static const pathVideoList = '/video_list';
  static const pathImageList = '/image_list';
  static const pathImagesList = '/images_list';
  static const pathResourceList = '/resource_list';
  static const pathTiktok = '/tiktok';
  static const pathTiktokVideo = '/tiktok_video';
  static const pathTiktokUser = '/tiktok_user';

  static final String url = 'http://47.91.11.122:8446/';

  static final Map<String, WidgetBuilder> routes = {
    RouterManage.home: (ctx) => const RouteHome(),
    RouterManage.pathVideo: (ctx) => VideoDetailView(
        VideoDetail(url: "https://media.w3.org/2010/05/sintel/trailer.mp4")),
    RouterManage.pathImageList: (ctx) =>
        ResourceListView(ResourceGenerateMock(type: ResourceType.pic)),
    RouterManage.pathImagesList: (ctx) =>
        ResourceListView(ResourceGenerateMock(type: ResourceType.pics)),
    RouterManage.pathVideoList: (ctx) =>
        ResourceListView(ResourceGenerateMock(type: ResourceType.video)),
    RouterManage.pathResourceList: (ctx) =>
        ResourceListView(ResourceGenerateMock(type: ResourceType.none)),
    RouterManage.pathTiktok: (ctx) => TikTokApp(url),
    RouterManage.pathTiktokVideo: (ctx) => TiktokVideoPage(url)
  };

  static final RouteFactory generateRoute = (settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (ctx) {
          return RouteHome();
        });
      case pathVideo:
        return MaterialPageRoute(builder: (ctx) {
          return VideoDetailView(VideoDetail(
              url: "https://media.w3.org/2010/05/sintel/trailer.mp4"));
        });
      case pathImageList:
        return MaterialPageRoute(builder: (ctx) {
          return ResourceListView(ResourceGenerateMock(type: ResourceType.pic));
        });
      case pathImagesList:
        return MaterialPageRoute(builder: (ctx) {
          return ResourceListView(
              ResourceGenerateMock(type: ResourceType.pics));
        });
      case pathVideoList:
        return MaterialPageRoute(builder: (ctx) {
          return ResourceListView(
              ResourceGenerateMock(type: ResourceType.video));
        });
      case pathResourceList:
        return MaterialPageRoute(builder: (ctx) {
          return ResourceListView(
              ResourceGenerateMock(type: ResourceType.none));
        });
      case pathTiktok:
        return MaterialPageRoute(builder: (ctx) {
          return TikTokApp(url);
        });
      case pathTiktokVideo:
        return MaterialPageRoute(builder: (ctx) {
          return TiktokVideoPage(url);
        });
      case pathTiktokUser:
        return MaterialPageRoute(builder: (ctx) {
          return TikTokUserPage(
              //userId: settings.arguments,
              );
        });
    }

    return null;
  };

  static final RouteFactory unknownRoute = (settings) {
    return MaterialPageRoute(builder: (ctx) {
      return ResourceListView(ResourceGenerateMock(type: ResourceType.none));
    });
  };
}
