import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
//
List<Widget> imageSlider(List<String> imgList) {
  List<Widget> resultList = imgList
      .map((item) => Container(
        margin: const EdgeInsets.all(5.0),
        child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            child: Stack(
              children: <Widget>[
                Image.network(item, fit: BoxFit.cover, width: 1000.0),
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(200, 0, 0, 0),
                          Color.fromARGB(0, 0, 0, 0)
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                    child: Text(
                      '${imgList.indexOf(item)}/${imgList.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ))
      .toList();

  return resultList;
}

ValueNotifier themeMode = ValueNotifier(2);

class DemoItem extends StatelessWidget {
  final String title;
  final String route;
   DemoItem(this.title, this.route, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      onTap: () {
        Navigator.pushNamed(context, route);
      },
    );
  }
}

class BasicDemo extends StatelessWidget {
  const BasicDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<int> list = [1, 2, 3, 4, 5];
    return Scaffold(
      appBar: AppBar(title: const Text('Basic demo')),
      body: CarouselSlider(
        options: CarouselOptions(),
        items: list
        .map((item) => Container(
              child: Center(child: Text(item.toString())),
              color: Colors.green,
            ))
        .toList(),
      ),
    );
  }
}

class NoCenterDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<int> list = [1, 2, 3, 4, 5];
    return Scaffold(
      appBar: AppBar(title: const Text('Basic demo')),
      body: CarouselSlider(
        options: CarouselOptions(
      disableCenter: true,
        ),
        items: list
        .map((item) => Container(
              child: Text(item.toString()),
              color: Colors.green,
            ))
        .toList(),
      ),
    );
  }
}

abstract class BaseImageSlider extends StatelessWidget {
  List<String> imgList = [];

  BaseImageSlider({Key? key, this.imgList = const []}) : super(key: key) {
    if (imgList.isEmpty) {
      imgList = [
        'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
        'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
        'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
        'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
        'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
        'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
      ];
    }
  }
}

class ImageSlider extends BaseImageSlider {
  ImageSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Image slider demo')),
      body: CarouselSlider(
        options: CarouselOptions(),
        items: imgList
        .map((item) => Center(
            child:
                Image.network(item, fit: BoxFit.cover, width: 1000)))
        .toList(),
      ),
    );
  }
}

mixin ComplicatedImage implements BaseImageSlider {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Complicated image slider demo')),
      body: CarouselSlider(
        options: CarouselOptions(
          autoPlay: true,
          aspectRatio: 2.0,
          enlargeCenterPage: true,
        ),
        items: imageSlider(imgList),
      ),
    );
  }
}

class EnlargeStrategy extends BaseImageSlider {
  EnlargeStrategy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Complicated image slider demo')),
      body: CarouselSlider(
        options: CarouselOptions(
          autoPlay: true,
          aspectRatio: 2.0,
          enlargeCenterPage: true,
          enlargeStrategy: CenterPageEnlargeStrategy.height,
        ),
        items: imageSlider(imgList),
      ),
    );
  }
}

class NoonLooping extends BaseImageSlider {
  NoonLooping({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Noon-looping carousel demo')),
      body: CarouselSlider(
        options: CarouselOptions(
      aspectRatio: 2.0,
      enlargeCenterPage: true,
      enableInfiniteScroll: false,
      initialPage: 2,
      autoPlay: true,
        ),
        items: imageSlider(imgList),
      ),
    );
  }
}

class VerticalSlider extends BaseImageSlider {
  VerticalSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vertical sliding carousel demo')),
      body: CarouselSlider(
        options: CarouselOptions(
      aspectRatio: 2.0,
      enlargeCenterPage: true,
      scrollDirection: Axis.vertical,
      autoPlay: true,
        ),
        items: imageSlider(imgList),
      ),
    );
  }
}

class FullscreenSlider extends BaseImageSlider {
  FullscreenSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fullscreen sliding carousel demo')),
      body: Builder(
        builder: (context) {
          final double height = MediaQuery.of(context).size.height;
          return CarouselSlider(
            options: CarouselOptions(
              height: height,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              // autoPlay: false,
            ),
            items: imgList
                .map((item) => Center(
                    child: Image.network(
                  item,
                  fit: BoxFit.cover,
                  height: height,
                )))
                .toList(),
          );
        },
      ),
    );
  }
}

class OnDemandCarousel extends BaseImageSlider {
  OnDemandCarousel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('On-demand carousel demo')),
      body: CarouselSlider.builder(
        itemCount: 100,
        options: CarouselOptions(
      aspectRatio: 2.0,
      enlargeCenterPage: true,
      autoPlay: true,
        ),
        itemBuilder: (ctx, index, realIdx) {
      return Text(index.toString());
        },
      ),
    );
  }
}

class KeepPageviewPosition extends BaseImageSlider {
  KeepPageviewPosition({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Keep pageview position demo')),
      body: ListView.builder(itemBuilder: (ctx, index) {
        if (index == 3) {
          return CarouselSlider(
            options: CarouselOptions(
          aspectRatio: 2.0,
          enlargeCenterPage: true,
          pageViewKey: const PageStorageKey<String>('carousel_slider'),
            ),
            items: imageSlider(imgList),
          );
        } else {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            color: Colors.blue,
            height: 200,
            child: const Center(
              child: Text('other content'),
            ),
          );
        }
      }),
    );
  }
}

class MultipleItem extends BaseImageSlider {
  MultipleItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Multiple item in one slide demo')),
      body: CarouselSlider.builder(
        options: CarouselOptions(
      aspectRatio: 2.0,
      enlargeCenterPage: false,
      viewportFraction: 1,
        ),
        itemCount: (imgList.length / 2).round(),
        itemBuilder: (context, index, realIdx) {
      final int first = index * 2;
      final int second = first + 1;
      return Row(
        children: [first, second].map((idx) {
          return Expanded(
            flex: 1,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Image.network(imgList[idx], fit: BoxFit.cover),
            ),
          );
        }).toList(),
      );
        },
      ),
    );
  }
}

KeepPageviewPosition a = KeepPageviewPosition();
