import 'dart:async';

import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

void main() => runApp(const AnimApp());

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
  late AnimationController controller,badgeAnimController,flareAnimController;
  late Animation colorAnimation, progressAnimation;
  late Animation<double> sizeAnimation,badgeSizeAnim,flareSizeAnim;
  late double percent = 0.0;
  late String progress = "";
  bool showProgress = false,
      showBadge = false,
      showFlare = false,
      showStar = false,
      showContainer = false,
      showSparkle = false;


 late Timer timer;

  bool _showBadge() {
    return showBadge;
  }

  bool _showFlare() {
    return showFlare;
  }
  bool _showSparkle(){
    return showSparkle;
  }



  bool _show() {
    return showProgress;
  }


  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 6));
    colorAnimation =
        ColorTween(begin: const Color(0xFFF9E9DA), end: const Color(0xFFD4955B))
            .animate(controller);
    sizeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(controller);
    controller.addListener(() {
      setState(() {
        if (controller.isCompleted) {
          showBadge = true;
          showFlare = true;
          showSparkle = true;
          badgeAnimController.forward();
          flareAnimController.forward();

        }
      });
    });
    
    badgeAnimController = AnimationController(vsync: this,duration: const Duration(seconds: 2));
    badgeSizeAnim = CurvedAnimation(parent: badgeAnimController, curve: Curves.fastLinearToSlowEaseIn);

    flareAnimController = AnimationController(vsync: this,duration: const Duration(seconds: 2));
    flareSizeAnim = CurvedAnimation(parent: flareAnimController, curve: Curves.easeInToLinear);

    Timer(const Duration(seconds: 1), () {
      showStar = true;
      showContainer = true;
      controller.forward();
      showProgress = true;

    });

    timer = Timer.periodic(const Duration(milliseconds: 55), (timer) {
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
          timer.cancel();
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
                child: SizeTransition(
                  sizeFactor: flareSizeAnim,
                  axisAlignment: 1,
                  child: Image.asset(
                    "assets/images/star_flare1.png",
                    height: 350,
                  ),
                )
              ),

             Visibility(visible: showContainer,child: Stack(
               children: [
                 Container(
                   width: 130,
                   height: 130,
                   decoration: const BoxDecoration(
                     shape: BoxShape.circle,
                     gradient: LinearGradient(
                       colors: [ Color(0xFFF6D6B7),
                         Color(0xFFD7A06D),
                         Color(0xFFD4955B)],
                       begin:Alignment.topLeft,
                       end: Alignment.bottomRight,
                       stops: [0.5, 0.0, 0.0], //stops for individual color
                     ),
                   ),
                 ),
                 SizeTransition(
                   axis: Axis.horizontal,
                   sizeFactor: sizeAnimation,
                   axisAlignment: 1,

                   child:Padding(padding: const EdgeInsets.all(0),child: Container(
                     width: 120,
                     height: 120,
                     color: Colors.white,
                   ),
                   ),
                 ),
               ],
             ),),




              /*Padding(
                padding: const EdgeInsets.only(top: 0),
                child: Container(
                  height: sizeAnimation.value,
                  width: sizeAnimation.value,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [ Color(0xFFF6D6B7),
                        Color(0xFFD7A06D),
                        Color(0xFFD4955B)],
                        begin:Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0.5, 0.0, 0.0], //stops for individual color

                    ),

                  ),
                ),
              ),*/


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
                child: Padding(padding: const EdgeInsets.only(top: 120.0,),
                  child: SizeTransition(
                  sizeFactor: badgeSizeAnim,
                    axis: Axis.horizontal,
                    axisAlignment: 1,
                    child: Image.asset("assets/images/badge1.png",height: 200,width: 300,),
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
              Padding(padding: const EdgeInsets.only(top: 50,),child: Align(alignment: Alignment.topCenter,
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

        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    badgeAnimController.dispose();
    super.dispose();
  }
}
