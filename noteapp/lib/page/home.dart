import 'package:flutter/material.dart';
import 'package:noteapp/common/data/mock.dart';
import 'package:noteapp/common/domain/base.dart';
import 'package:noteapp/common/resource/resource_list.dart';
import 'package:noteapp/page/route.dart';

class HomePageDetail2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'notechats',
      home: RouteDetails(),
    );
  }
}

class HomePageDetail extends StatefulWidget {
  const HomePageDetail({Key? key}) : super(key: key);

  @override
  _HomePageDetail createState() => _HomePageDetail();
}

class _HomePageDetail extends State<HomePageDetail> {
  int _currentIndex = 0;
  final List<Widget> _pageList = [
    //const RouteDetail(), //页面1
    RouteDetails(), //页面1
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
      title: 'notechats',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: _pageList[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          selectedFontSize: 14,
          unselectedFontSize: 12,
          selectedItemColor: Colors.red,
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          items: bottomItems,
          onTap: (int index) {
            if (index != _currentIndex) {
              setState(() {
                _currentIndex = index;
              });
            }
          },
        ),
      ),
    );
  }
}
