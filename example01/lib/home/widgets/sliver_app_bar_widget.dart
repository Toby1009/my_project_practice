import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double maxHeaderExtent;
  final double topHeight;
  final String text;

  MySliverAppBar(
      {required this.maxHeaderExtent, required this.topHeight, required this.text});

  @override
  Widget build(BuildContext context, double shrinkOffset,
      bool overlapsContent) {
    Widget appBar() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: topHeight,),
          Opacity(
            opacity: shrinkOffset > 40 ? shrinkOffset /
                (maxHeaderExtent + topHeight) : 0,
            child: Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Divider(height: 5,color: Colors.grey,)
        ],
      );
    }
    // TODO: implement build
    return SizedBox(
        width: double.maxFinite,
        child: shrinkOffset <= 40
            ? Container(
          color: Colors.white,
        )
            : ClipRect(
              child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                  child: appBar(),
              ),
        )
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => maxHeaderExtent + topHeight;

  @override
  // TODO: implement minExtent
  double get minExtent => maxHeaderExtent + topHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
