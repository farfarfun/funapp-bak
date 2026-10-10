import 'package:flutter/material.dart';
import 'package:funapp/common/domain/author.dart';

/// 展示作者头像和名称的卡片。
///
/// [author] 提供展示数据，[type] 控制紧凑或关注按钮布局。
class AuthorCard extends StatelessWidget {
  /// 要展示的作者信息。
  Author author;

  /// 卡片布局类型。
  int type;

  /// 使用 [author] 创建作者卡片，可选 [type] 默认为 1。
  AuthorCard(this.author, {Key? key, this.type = 1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (type == 1) {
      return SizedBox(
          height: 30,
          child: Stack(children: <Widget>[
            Positioned(
              left: 0,
              child: SizedBox(
                  height: 25,
                  width: 25,
                  child: Image.network(
                    author.logo,
                    fit: BoxFit.cover,
                  )),
            ),
            Positioned(
                left: 30,
                child: Text(author.name,
                    style: const TextStyle(
                      fontSize: 14.0,
                      decoration: TextDecoration.none,
                    ))),
            const Positioned(
              right: 0,
              child: Text(
                "关注",
                style: TextStyle(
                  fontSize: 14.0,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ]));
    } else {
      return Row(
        children: [
          SizedBox(
              height: 25,
              width: 25,
              child: Image.network(
                author.logo,
                fit: BoxFit.cover,
              )),
          Text(author.name,
              style: const TextStyle(
                fontSize: 14.0,
                height: 1.2,
              ))
        ],
      );
    }
  }
}
