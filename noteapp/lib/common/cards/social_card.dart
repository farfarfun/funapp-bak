import 'package:flutter/material.dart';
import 'package:noteapp/common/domain/base.dart';

class SocialCard extends StatelessWidget {
  ResourceDetail resourceDetail;
  SocialCard(this.resourceDetail, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        alignment: Alignment.center,
        child: Stack(alignment: Alignment.center, children: const <Widget>[
          Align(
              alignment: Alignment(-0.98, -0.8),
              child: Icon(Icons.share, size: 20, color: Colors.black)),
          Align(
              alignment: Alignment(-0.80, -0.8),
              child: Text(
                "分享",
                style: TextStyle(fontSize: 14.0),
              )),
          Align(
              alignment: Alignment(-0.41, -0.8),
              child: Icon(Icons.star_border_rounded,
                  size: 20, color: Colors.black)),
          Align(
              alignment: Alignment(-0.23, -0.8),
              child: Text(
                "收藏",
                style: TextStyle(fontSize: 14.0),
              )),
          Align(
              alignment: Alignment(0.25, -0.8),
              child: Icon(Icons.mode_comment_outlined,
                  size: 20, color: Colors.black)),
          Align(
              alignment: Alignment(0.43, -0.8),
              child: Text(
                "评论",
                style: TextStyle(fontSize: 14.0),
              )),
          Align(
              alignment: Alignment(0.80, -0.8),
              child: Icon(Icons.cloud_download_outlined,
                  size: 20, color: Colors.black)),
          Align(
              alignment: Alignment(0.98, -0.8),
              child: Text(
                "点赞",
                style: TextStyle(fontSize: 14.0),
              ))
        ]));
  }
}
