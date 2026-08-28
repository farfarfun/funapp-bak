import 'package:flutter/material.dart';
import 'package:funapp/common/domain/author.dart';

class AuthorCard extends StatelessWidget {
  Author author;
  int type;

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
                style: TextStyle(fontSize: 14.0,
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
