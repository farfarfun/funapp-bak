import 'package:flutter/material.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:noteapp/common/cards/resource_card.dart';
import 'package:noteapp/common/domain/generate.dart';

//
class ResourceListView extends StatefulWidget {
  ResourceGenerate resourceGenerate;

  ResourceListView(this.resourceGenerate);

  @override
  _ResourceListView createState() => _ResourceListView();
}

class _ResourceListView extends State<ResourceListView> {
  int maxSize = 1000;
  _ResourceListView();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        InViewNotifierList(
          scrollDirection: Axis.vertical,
          initialInViewIds: ['0'],
          isInViewPortCondition:
              (double deltaTop, double deltaBottom, double viewPortDimension) {
            return deltaTop < (0.3 * viewPortDimension) &&
                deltaBottom > (0.3 * viewPortDimension);
          },
          itemCount: maxSize,
          builder: (BuildContext context, int index) {
            return getResource(widget.resourceGenerate.next(), context, index);
          },
        ),
      ],
    );
  }
}
