import 'package:flutter/material.dart';
import 'package:noteapp/common/cards/video_card.dart';
import 'package:noteapp/common/data/mock.dart';
import 'package:noteapp/common/domain/base.dart';
import 'package:noteapp/common/resource/resource_list.dart';
import 'package:noteapp/tiktok/app.dart';

ValueNotifier themeMode = ValueNotifier(2);

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
    return ListTile(
      title: Text(widget.title),
      onTap: () {
        Navigator.pushNamed(context, widget.route);
      },
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
      body: ListView(
        children: const <Widget>[
          RouteItem('播放视频', '/video'),
          RouteItem('视频列表', '/video_list'),
          RouteItem('图片列表', '/image_list'),
          RouteItem('图片集合列表', '/images_list'),
          RouteItem('资源列表', '/resource_list'),
          RouteItem('tiktok', '/tiktok'),
        ],
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
    return ValueListenableBuilder(
      valueListenable: ValueNotifier(2),
      builder: (context, value, g) {
        return MaterialApp(
          initialRoute: '/',
          darkTheme: ThemeData.dark(),
          themeMode: ThemeMode.values.toList()[value as int],
          debugShowCheckedModeBanner: false,
          routes: {
            '/': (ctx) => const RouteHome(),
            '/video': (ctx) => VideoDetailView(VideoDetail(
                url: "https://media.w3.org/2010/05/sintel/trailer.mp4")),
            '/image_list': (ctx) =>
                ResourceListView(ResourceGenerateMock(type: ResourceType.pic)),
            '/images_list': (ctx) =>
                ResourceListView(ResourceGenerateMock(type: ResourceType.pics)),
            '/video_list': (ctx) => ResourceListView(
                ResourceGenerateMock(type: ResourceType.video)),
            '/resource_list': (ctx) =>
                ResourceListView(ResourceGenerateMock(type: ResourceType.none)),
            '/tiktok': (ctx) => TikTokApp('http://47.91.11.122:8446/'),
          },
        );
      },
    );
  }
}
