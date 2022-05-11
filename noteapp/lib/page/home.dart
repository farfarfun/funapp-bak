import 'package:flutter/material.dart';
import 'package:noteapp/common/data/mock.dart';
import 'package:noteapp/common/domain/base.dart';
import 'package:noteapp/common/image/images_slider.dart';
import 'package:noteapp/common/resource/resource_list.dart';
import 'package:noteapp/common/cards/video_card.dart';

//
class DemoHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carousel demo'),
        actions: [
          IconButton(
              icon: Icon(Icons.nightlight_round),
              onPressed: () {
                themeMode.value = themeMode.value == 1 ? 2 : 1;
              })
        ],
      ),
      body: ListView(
        children: <Widget>[
          DemoItem('Keep pageview position demo', '/position'),
          DemoItem('video', '/video'),
          DemoItem('video_list', '/video_list'),
          DemoItem('image_list', '/image_list'),
          DemoItem('images_list', '/images_list'),
          DemoItem('resource_list', '/resource_list'),
        ],
      ),
    );
  }
}

class DemoDetail extends StatelessWidget {
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
            '/': (ctx) => DemoHome(),
            '/position': (ctx) => KeepPageviewPosition(),
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
          },
        );
      },
    );
  }
}

class HomePageDetail extends StatefulWidget {
  int _currentIndex = 0;
  HomePageDetail({Key? key}) : super(key: key);
  _HomePageDetail createState() => _HomePageDetail();
}

class _HomePageDetail extends State<HomePageDetail> {
  final List<Widget> _pageList = [
    DemoDetail(), //页面1
    ResourceListView(ResourceGenerateMock(type: ResourceType.video)), //页面2
    ResourceListView(ResourceGenerateMock(type: ResourceType.pics)), //页面3
  ];

  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home, color: Colors.black54),
      activeIcon: Icon(Icons.home, color: Colors.red),
      label: "首页",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.video_call_rounded, color: Colors.black54),
      activeIcon: Icon(Icons.video_call_rounded, color: Colors.red),
      label: "视频",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.account_circle_rounded, color: Colors.black54),
      activeIcon: Icon(Icons.account_circle_rounded, color: Colors.red),
      label: "我的",
    )
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: _pageList[widget._currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          selectedFontSize: 14,
          unselectedFontSize: 12,
          selectedItemColor: Colors.red,
          currentIndex: widget._currentIndex,
          type: BottomNavigationBarType.fixed,
          items: bottomItems,
          onTap: (int index) {
            if (index != widget._currentIndex) {
              setState(() {
                widget._currentIndex = index;
              });
            }
          },
        ),
      ),
    );
  }
}
