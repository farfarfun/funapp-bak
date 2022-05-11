import 'package:flutter/material.dart';
import 'package:noteapp/common/common/state.dart';
import 'package:provider/provider.dart';

//
class AppBottomNavigationBar extends StatefulWidget {
  List<BottomNavigationBarItem> items;
  AppBottomNavigationBar(this.items, {Key? key}) : super(key: key);
  @override
  _AppBottomNavigationBarState createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    var state = Provider.of<AppState>(
      context,
    );

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: state.pageIndex,
      items: widget.items,
      showUnselectedLabels: false,
      onTap: (int index) {
        setState(() {
          state.setpageIndex = index;
        });
      },
    );
  }
}
