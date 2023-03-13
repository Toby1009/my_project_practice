import 'dart:async';
import 'dart:ui';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

import '../widgets/sliver_app_bar_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final String text = "Reading Now";
  late AnimationController _textFontSizeController;
  late Animation<double> _textFontSizeAnimation;
  double fontSize = 40;

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
      end: 40,
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
      body: SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Listener(
          child: CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                delegate: MySliverAppBar(
                    maxHeaderExtent: 45.0,
                    topHeight: MediaQuery.of(context).padding.top,
                    text: text),
                pinned: true,
              ),
              SliverToBoxAdapter(
                child: Container(
                    padding: const EdgeInsets.only(left: 35,right: 35),
                    width: double.maxFinite,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white10,
                          Colors.grey,
                        ],
                      )
                    ),
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
                              Icons.account_circle_sharp,
                              size: 50,
                            )
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.grey.shade300,
                                  ),
                                  width: 20,
                                  height: 20,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.white,
                                  ),
                                  width: 13,
                                  height: 13,
                                )
                              ],
                            ),
                            Text(
                                ' Todays\'s Reading ',
                                style: TextStyle(
                                  color: Colors.blue.shade900,
                                ),
                            ),
                            Text(
                              '5 minutes left',
                              style: TextStyle(
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        const Divider(height: 3,color: Colors.grey,),
                        const SizedBox(height: 10,),
                        SizedBox(
                          height: 380,
                          width: double.maxFinite,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                width: MediaQuery.of(context).size.width/2-65,
                                child: Column(
                                  //mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                    children:  [
                                      const Text(
                                        'Current',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 50,),
                                      Image.asset('assets/book_01.jpg'),
                                      const Text(
                                        '哈囉你好',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                ),
                              ),
                              const SizedBox(width: 40,),
                              Container(
                                alignment: Alignment.topLeft,
                                width: MediaQuery.of(context).size.width/2-65,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Recent',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 50,),
                                      Image.asset('assets/book_01.jpg'),
                                      const Text(
                                        '哈囉你好',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                ),
              ),
            ],
          ),
          onPointerMove: (e) {
            if (fontSize >=40 && fontSize <= 45) {
                setState(() {
                  fontSize+=e.delta.dy/100;
                // print(fontSize);
                });
            }
          },
          onPointerUp: (e) {
            _textFontSizeAnimation = Tween<double>(
              begin: fontSize,
              end: 40,
            ).animate(
                CurvedAnimation(
                    parent: _textFontSizeController,
                    curve: Curves.linear)
            );
            _textFontSizeController.forward();
          },
        ),
      ),
    );
  }
}

