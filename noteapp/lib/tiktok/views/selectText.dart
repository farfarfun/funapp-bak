import 'package:flutter/material.dart';
import 'package:noteapp/tiktok/style/style.dart';

class SelectText extends StatelessWidget {
  final bool isSelect;
  final String? title;

  const SelectText({
    this.isSelect = true,
    this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      color: Colors.black.withOpacity(0),
      child: Text(
        title ?? '??',
        textAlign: TextAlign.center,
        style:
            isSelect ? StandardTextStyle.big : StandardTextStyle.bigWithOpacity,
      ),
    );
  }
}
