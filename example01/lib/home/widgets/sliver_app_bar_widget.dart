import 'dart:ui';

import 'package:flutter/cupertino.dart';

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double maxHeaderExtent;
  final double topHeight;
  final String text;
  MySliverAppBar({required this.maxHeaderExtent,required this.topHeight,required this.text});
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    return SizedBox(
        width: double.maxFinite,
        child: ClipRect(
          child:BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 50,sigmaY: 50),
            child: Column(
              children: [
                SizedBox(height: topHeight,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:  [
                    Opacity(
                      opacity: shrinkOffset/(maxHeaderExtent+topHeight),
                      child:  Text(
                        text,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => maxHeaderExtent+topHeight;

  @override
  // TODO: implement minExtent
  double get minExtent =>maxHeaderExtent+topHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
