import 'dart:async';

import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

void main() => runApp(AnimApp());

class AnimApp extends StatelessWidget {
  const AnimApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anim Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyAnimPage(),
    );
  }
}

class MyAnimPage extends StatefulWidget {
  const MyAnimPage({super.key});

  @override
  State<MyAnimPage> createState() => _MyAnimPageState();
}

class _MyAnimPageState extends State<MyAnimPage> with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation colorAnimation, progressAnimation;
  late Animation sizeAnimation;
  late double percent = 0.0;
  late String progress = "";
  bool showProgress = false,
      showBadge = false,
      showFlare = false,
      showStar = false,
      showSparkle = false;

  void _onStartPress() {
    showProgress = true;
    controller.forward();
  }

  bool _showBadge() {
    return showBadge;
  }

  bool _showFlare() {
    return showFlare;
  }
  bool _showSparkle(){
    return showSparkle;
  }

  void _onStopPress() {
    showProgress = false;
    showBadge = false;
    showFlare = false;
    controller.reset();
  }

  bool _show() {
    return showProgress;
  }

  double _progress() {
    return percent / 10;
  }

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 7));
    colorAnimation =
        ColorTween(begin: const Color(0xFFF9E9DA), end: const Color(0xFFD4955B))
            .animate(controller);
    sizeAnimation = Tween<double>(begin: 0.0, end: 150.0).animate(controller);
    controller.addListener(() {
      setState(() {
        if (controller.isCompleted) {
          showBadge = true;
          showFlare = true;
          showSparkle = true;
        }
      });
    });
    Timer(const Duration(seconds: 1), () {
      showStar = true;
      controller.forward();
      showProgress = true;
    });
    Timer _timer = Timer.periodic(const Duration(milliseconds: 55), (_timer) {
      setState(() {
        percent++;
        if (percent <= 33) {
          progress = "1/3";
        } else if (percent <= 66) {
          progress = "2/3";
        } else if (percent <= 99) {
          progress = "3/3";
        }

        if (percent >= 100) {
          percent = 0.0;
          _timer.cancel();
        }
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Animation Demo"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Visibility(
                visible: _showFlare(),
                child: Image.asset(
                  "assets/images/star_flare1.png",
                  height: 350,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 0),
                child: Container(
                  height: sizeAnimation.value,
                  width: sizeAnimation.value,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Color(0xFFF9E9DA),Color(0xFFD0A781),Color(
                          0xFFD4955B)],
                        begin:FractionalOffset.topLeft,
                      end: FractionalOffset.bottomRight,
                    ),

                  ),
                ),
              ),

              Visibility(
                visible: showStar,
                child: Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: Image.asset(
                    "assets/images/star1.png",
                    height: 180,
                  ),
                ),
              ),
              Visibility(
                visible: _showBadge(),
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 120.0,),
                  child: Image.asset(
                    "assets/images/badge1.png",
                    height: 200,
                    width: 300,
                  ),
                ),
              ),
              Visibility(
                visible: _showSparkle(),
                child: Padding(padding: const EdgeInsets.only(bottom: 90,right: 12),
              child: Image.asset("assets/images/sparkle.png",height: 80,width: 80,
              ),
              ),
              ),
            ],
          ),
          Visibility(
            visible: _show(),
              child:
              Padding(padding: EdgeInsets.only(top: 50,),child: Align(alignment: Alignment.topCenter,
                child: LinearPercentIndicator(
                  width: MediaQuery.of(context).size.width,
                  lineHeight: 15.0,
                  progressColor: const Color(0xFFD4955B),
                  backgroundColor: const Color(0xFFF9E9DA),
                  animationDuration: 4700,
                  animation: true,
                  barRadius: const Radius.circular(15.0),
                  percent: 100 / 100,
                  center: Text(
                    progress,
                    style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
                  ),
                ),),
          )),

        /*  Visibility(
            visible: _show(),
            child: LinearPercentIndicator(
              width: MediaQuery.of(context).size.width,
              lineHeight: 15.0,
              progressColor: const Color(0xFFE5A468),
              backgroundColor: const Color(0xFFF9E9DA),
              animationDuration: 4700,
              animation: true,
              barRadius: const Radius.circular(15.0),
              percent: 100 / 100,
              center: Text(
                progress,
                style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),*/

          /*const Padding(padding: EdgeInsets.only(top: 30.0)),
        TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.blue,
                padding: const EdgeInsets.all(16.0),
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: _onStartPress, child: const Text("Start")),
        TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.blue,
              padding: const EdgeInsets.all(16.0),
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: _onStopPress, child: const Text("Stop")),*/
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
