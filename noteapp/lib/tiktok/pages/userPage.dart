import 'package:flutter/material.dart';
import 'package:noteapp/tiktok/style/style.dart';
import 'package:noteapp/tiktok/views/appBar.dart';
import 'package:noteapp/tiktok/views/appRow.dart';
import 'package:tapped/tapped.dart';

class UserPage extends StatefulWidget {
  final bool canPop;
  final bool isSelfPage;
  final Function? onPop;
  final Function? onSwitch;

  const UserPage({
    Key? key,
    this.canPop: false,
    this.onPop,
    required this.isSelfPage,
    this.onSwitch,
  }) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    Widget likeButton = Container(
      color: ColorPlate.back1,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Tapped(
            child: _UserRightButton(
              title: widget.isSelfPage ? '钱包' : '关注',
            ),
          ),
        ],
      ),
    );
    Widget avatar = Container(
      height: 120 + MediaQuery.of(context).padding.top,
      padding: const EdgeInsets.only(left: 18),
      alignment: Alignment.bottomLeft,
      child: OverflowBox(
        alignment: Alignment.bottomLeft,
        minHeight: 20,
        maxHeight: 300,
        child: Container(
          height: 74,
          width: 74,
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(44),
            color: Colors.orange,
            border: Border.all(
              color: Colors.white,
              width: 1,
            ),
          ),
          child: ClipOval(
            child: Image.network(
              "https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif",
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
    Widget body = ListView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      children: <Widget>[
        Container(height: 20),
        // 头像与关注
        Stack(
          alignment: Alignment.bottomLeft,
          children: <Widget>[likeButton, avatar],
        ),
        Container(
          color: ColorPlate.back1,
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(left: 18),
                color: ColorPlate.back1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      '@用户名',
                      style: StandardTextStyle.big,
                    ),
                    Container(height: 8),
                    Text(
                      '朴实无华，且枯燥',
                      style: StandardTextStyle.smallWithOpacity.apply(
                        color: Colors.white,
                      ),
                    ),
                    Container(height: 10),
                    Row(
                      children: const <Widget>[
                        _UserTag(tag: '幽默'),
                        _UserTag(tag: '机智'),
                        _UserTag(tag: '枯燥'),
                        _UserTag(tag: '狮子座'),
                      ],
                    ),
                    Container(height: 10),
                  ],
                ),
              ),
              Container(
                color: ColorPlate.back1,
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 2,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const <Widget>[
                    TextGroup('356', '关注'),
                    TextGroup('145万', '粉丝'),
                    TextGroup('1423万', '获赞'),
                  ],
                ),
              ),
              Container(
                height: 10,
                margin: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.white.withOpacity(0.1),
                    ),
                  ),
                ),
              ),
              const _UserVideoTable(),
            ],
          ),
        ),
      ],
    );

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          colors: <Color>[
            Colors.orange,
            Colors.red,
          ],
        ),
      ),
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 400),
            height: double.infinity,
            width: double.infinity,
            color: ColorPlate.back1,
          ),
          body,
          Container(
            margin: const EdgeInsets.only(top: 20),
            height: 62,
            child: TopToolRow(
              canPop: widget.canPop,
              onPop: widget.onPop,
              right: Tapped(
                child: Container(
                  width: 30,
                  height: 30,
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.36),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.more_horiz,
                    size: 24,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => UserDetailPage(),
                  ));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _UserRightButton extends StatelessWidget {
  const _UserRightButton({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 6,
        horizontal: 20,
      ),
      margin: const EdgeInsets.all(8),
      alignment: Alignment.center,
      child: Text(
        title,
        style: const TextStyle(color: ColorPlate.orange),
      ),
      decoration: BoxDecoration(
        border: Border.all(color: ColorPlate.orange),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

class _UserTag extends StatelessWidget {
  final String? tag;
  const _UserTag({
    Key? key,
    this.tag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.symmetric(
        vertical: 2,
        horizontal: 4,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        tag ?? '标签',
        style: StandardTextStyle.smallWithOpacity,
      ),
    );
  }
}

class _UserVideoTable extends StatelessWidget {
  const _UserVideoTable({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          color: ColorPlate.back1,
          padding: const EdgeInsets.symmetric(
            vertical: 12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const <Widget>[
              _PointSelectTextButton(true, '作品'),
              _PointSelectTextButton(false, '关注'),
              _PointSelectTextButton(false, '喜欢'),
            ],
          ),
        ),
        Row(
          children: const <Widget>[
            _SmallVideo(),
            _SmallVideo(),
            _SmallVideo(),
          ],
        ),
        Row(
          children: const <Widget>[
            _SmallVideo(),
            _SmallVideo(),
            _SmallVideo(),
          ],
        ),
        Row(
          children: const <Widget>[
            _SmallVideo(),
            _SmallVideo(),
            _SmallVideo(),
          ],
        ),
        Row(
          children: const <Widget>[
            _SmallVideo(),
            _SmallVideo(),
            _SmallVideo(),
          ],
        ),
        Row(
          children: const <Widget>[
            _SmallVideo(),
            _SmallVideo(),
            _SmallVideo(),
          ],
        ),
        Row(
          children: const <Widget>[
            _SmallVideo(),
            _SmallVideo(),
            _SmallVideo(),
          ],
        ),
        Row(
          children: const <Widget>[
            _SmallVideo(),
            _SmallVideo(),
            _SmallVideo(),
          ],
        ),
        Row(
          children: const <Widget>[
            _SmallVideo(),
            _SmallVideo(),
            _SmallVideo(),
          ],
        ),
      ],
    );
  }
}

class _SmallVideo extends StatelessWidget {
  const _SmallVideo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 3 / 4.0,
        child: Container(
          decoration: BoxDecoration(
            color: ColorPlate.darkGray,
            border: Border.all(color: Colors.black),
          ),
          alignment: Alignment.center,
          child: Text(
            '作品',
            style: TextStyle(
              color: Colors.white.withOpacity(0.1),
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
    );
  }
}

class _PointSelectTextButton extends StatelessWidget {
  final bool isSelect;
  final String title;
  final Function? onTap;
  const _PointSelectTextButton(
    this.isSelect,
    this.title, {
    Key? key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          isSelect
              ? Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: ColorPlate.orange,
                    borderRadius: BorderRadius.circular(3),
                  ),
                )
              : Container(),
          Container(
            padding: const EdgeInsets.only(left: 2),
            child: Text(
              title,
              style: isSelect
                  ? StandardTextStyle.small
                  : StandardTextStyle.smallWithOpacity,
            ),
          )
        ],
      ),
    );
  }
}

class TextGroup extends StatelessWidget {
  final String title, tag;
  final Color? color;

  const TextGroup(
    this.title,
    this.tag, {
    Key? key,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            title,
            style: StandardTextStyle.big.apply(color: color),
          ),
          Container(width: 4),
          Text(
            tag,
            style: StandardTextStyle.smallWithOpacity.apply(
              color: color?.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }
}

class UserDetailPage extends StatefulWidget {
  @override
  _UserDetailPageState createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  @override
  Widget build(BuildContext context) {
    Widget head = const TikTokAppbar(
      title: '用户',
    );
    var userHead = Row(
      children: <Widget>[
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: const Text(
              '个人信息',
              style: StandardTextStyle.smallWithOpacity,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Text(
            '修改',
            style: StandardTextStyle.smallWithOpacity.apply(
              color: ColorPlate.orange,
            ),
          ),
        )
      ],
    );
    Widget body = ListView(
      padding: EdgeInsets.only(
        bottom: 80 + MediaQuery.of(context).padding.bottom,
      ),
      children: <Widget>[
        userHead,
        _UserInfoRow(
          title: '昵称',
          rightIcon: const Text(
            '朱二蛋的枯燥生活',
            style: StandardTextStyle.small,
          ),
        ),
        _UserInfoRow(
          title: '头像',
          rightIcon: const Text(
            '上传',
            style: StandardTextStyle.small,
          ),
        ),
        _UserInfoRow(
          title: '手机绑定',
          rightIcon: const Text(
            '186****7767',
            style: StandardTextStyle.small,
          ),
        ),
        _UserInfoRow(
          title: '地址',
          rightIcon: const Text(
            '深圳市南山区南海大道',
            style: StandardTextStyle.small,
          ),
        ),
        _UserInfoRow(
          title: '年龄',
          rightIcon: const Text(
            '18',
            style: StandardTextStyle.small,
          ),
        ),
        _UserInfoRow(
          title: '用户性别',
          rightIcon: const Text(
            '男',
            style: StandardTextStyle.small,
          ),
        ),
        _UserInfoRow(
          title: '职业',
          rightIcon: const Text(
            '总裁',
            style: StandardTextStyle.small,
          ),
        ),
      ],
    );
    body = Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: body,
      ),
    );
    return Scaffold(
      body: Container(
        color: ColorPlate.back1,
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: <Widget>[
            head,
            Expanded(child: body),
          ],
        ),
      ),
    );
  }
}

class _UserInfoRow extends StatelessWidget {
  _UserInfoRow({
    this.icon,
    this.title,
    this.rightIcon,
    this.onTap,
  });
  final Widget? icon;
  final Widget? rightIcon;
  final String? title;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    Widget iconImg = Container(
      height: 24,
      width: 24,
      child: icon,
    );

    Widget row = Container(
      height: 48,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.02),
        border: const Border(
          bottom: BorderSide(color: Colors.white12),
        ),
      ),
      child: Row(
        children: <Widget>[
          icon != null ? iconImg : Container(),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 12),
              child: Text(
                title!,
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ),
          Opacity(
            opacity: 0.6,
            child: rightIcon ??
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                ),
          ),
        ],
      ),
    );
    row = Tapped(
      onTap: onTap,
      child: row,
    );

    return row;
  }
}
