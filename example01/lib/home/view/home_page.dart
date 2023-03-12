import 'dart:async';
import 'dart:ui';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final String text = "Reading Now";
  late AnimationController _textFontSizeController;
  late Animation<double> _textFontSizeAnimation;
  double fontSize = 30;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textFontSizeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _textFontSizeAnimation = Tween<double>(
      begin: fontSize,
      end: 30,
    ).animate(
      CurvedAnimation(
          parent: _textFontSizeController,
          curve: Curves.linear)
    )..addStatusListener((status) {
      if(status == AnimationStatus.completed){
        _textFontSizeAnimation = Tween<double>(
          begin: fontSize,
          end: 30,
        ).animate(
            CurvedAnimation(
                parent: _textFontSizeController,
                curve: Curves.linear)
        );
        _textFontSizeController.reset();
      }
    })..addListener(() {
      fontSize = _textFontSizeAnimation.value;
    });

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _textFontSizeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Listener(
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              delegate: MySliverAppBar(
                  maxHeaderExtent: 30.0,
                  topHeight: MediaQuery.of(context).padding.top,
                  text: text),
              pinned: true,
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                  width: double.maxFinite,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AnimatedBuilder(
                            animation: _textFontSizeController,
                            builder: (BuildContext context, Widget? child) {
                              return Text(
                                text,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: fontSize,
                                ),
                              );
                            },
                          ),
                          const Icon(
                            Icons.account_circle_rounded,
                            size: 40,
                          )
                        ],
                      )
                    ],
                  )),
            ),
          ],
        ),
        onPointerMove: (e) {
          if (fontSize >= 30 && fontSize <= 50) {
              setState(() {
                fontSize+=e.delta.dy/50;
              // print(fontSize);
              });
          }
        },
        onPointerUp: (e) {
          _textFontSizeAnimation = Tween<double>(
            begin: fontSize,
            end: 30,
          ).animate(
              CurvedAnimation(
                  parent: _textFontSizeController,
                  curve: Curves.linear)
          );
          _textFontSizeController.forward();
        },
      ),
    );
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double maxHeaderExtent;
  final double topHeight;
  final String text;

  MySliverAppBar(
      {required this.maxHeaderExtent,
      required this.topHeight,
      required this.text});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    return SizedBox(
        width: double.maxFinite,
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
            child: Column(
              children: [
                SizedBox(
                  height: topHeight,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Opacity(
                      opacity: shrinkOffset / (maxHeaderExtent + topHeight),
                      child: Text(
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
        ));
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
