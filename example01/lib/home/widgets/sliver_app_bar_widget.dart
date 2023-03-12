import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MySliverAppBar extends SliverPersistentHeaderDelegate  {
  final double maxHeaderExtent;
  final double topHeight;
  final String text;

  MySliverAppBar(
      {required this.maxHeaderExtent, required this.topHeight, required this.text});

  @override
  Widget build(BuildContext context, double shrinkOffset,
      bool overlapsContent) {
    // TODO: implement build
    return SizedBox(
        width: double.maxFinite,
        child: shrinkOffset < 45
            ? Container(
          color: Colors.white,
          child: MyAppBar(
              shrinkOffset: shrinkOffset,
              topHeight: topHeight,
              maxHeaderExtent: maxHeaderExtent,
              text: text),
        )
            : ClipRect(
              child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                  child: MyAppBar(
                      shrinkOffset: shrinkOffset,
                      topHeight: topHeight,
                      maxHeaderExtent: maxHeaderExtent,
                      text: text),
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


class MyAppBar extends StatefulWidget {
  const MyAppBar({Key? key,
    required this.shrinkOffset,
    required this.topHeight,
    required this.maxHeaderExtent,
    required this.text,
  }) : super(key: key);
  final double topHeight;
  final double shrinkOffset;
  final double maxHeaderExtent;
  final String text;
  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(height: widget.topHeight,),
        AnimatedOpacity(
          opacity: widget.shrinkOffset>40?1.0:0.0,
          duration: const Duration(milliseconds: 150),
          child: Text(
            widget.text,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        widget.shrinkOffset>=45
        ?const Divider(height: 5,color: Colors.grey,)
            :const SizedBox(height: 5,),
      ],
    );
  }
}
