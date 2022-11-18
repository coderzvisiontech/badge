import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';



InAppLocalhostServer localhostServer = InAppLocalhostServer();

void main() => runApp(AnimApp(0));

class AnimApp extends StatelessWidget {
  AnimApp(this.progressLevel, {super.key});


  int progressLevel = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anim Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyAnimPage(progressLevel),
    );
  }
}

class MyAnimPage extends StatefulWidget {
  MyAnimPage(this.progressLevel, {super.key});

  int progressLevel = 0;

  @override
  State<MyAnimPage> createState() => _MyAnimPageState(progressLevel);
}

class _MyAnimPageState extends State<MyAnimPage> with TickerProviderStateMixin {
  late AnimationController controller,
      badgeAnimController,
      flareAnimController,
      sparkleAnimController;
  late AnimationController sparkleTimingController,
      badgeTimingController,
      flareTimingController;
  late Animation colorAnimation, progressAnimation;
  late Animation<double> sizeAnimation,
      badgeSizeAnim,
      flareSizeAnim,
      sparkleAnim;
  late double percent = 0.0;
  late String progress = "";
  bool showProgress = false,
      showBadge = false,
      showFlare = false,
      showStar = false,
      showContainer = false,
      showSparkle = false,
      button1State = false,
  button2State = false,
  button3State = false,
  showButtons = false;

  int progressLevel = 0;
  bool initiate = true;
  late Timer timer;
  double progressBarlevel = 0.0;
  double begin = 1.0;
  double animEnd = 0.0;
  _MyAnimPageState(this.progressLevel);

  bool _showBadge() {
    return showBadge;
  }

  bool _showFlare() {
    return showFlare;
  }

  bool _showSparkle() {
    return showSparkle;
  }

  bool _show() {
    return showProgress;
  }

  _button1onClick(){
    print("coming");
    initiate = false;

      if(progressLevel==3){
        showFlare = false;
        showBadge = false;
        showSparkle = false;
      }
      progressLevel = 1;
      begin = 1.0;
      button1State = false;
      button2State = true;
      _call_initState();

  }
  _button2onClick(){
    print("comingm2");
   /*
    if(progressLevel == 0){
      begin = 1.0;
      progressLevel = 2;

    }else{
    }*/
    begin = 1 - ((progressLevel == 0) ? 1.0 : (progressLevel / 3));
    button2State = false;
    button3State = true;
    progressLevel = progressLevel+1;
    _call_initState();

  }
  _button3onClick(){
    print("coming3");

   /*
    if(progressLevel == 0){
      progressLevel = 3;
      begin = 1.0;
    }
    else{
 }*/
    begin = 1 - ((progressLevel == 0) ? 1.0 : (progressLevel / 3));
    button3State = false;
    progressLevel = progressLevel+1;
    _call_initState();
  }
  _call_initState(){
    setState(() {
      initState();
    });
  }

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 3000));

    badgeTimingController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 4000));
    flareTimingController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 5000));
    sparkleTimingController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 10000));

    animEnd = 1 - ((progressLevel == 0) ? 1.0 : (progressLevel / 3));

    sizeAnimation =
        Tween<double>(begin: (begin), end: (animEnd)).animate(controller);
    controller.addListener(() {
      setState(() {
        if (controller.isCompleted) {}
      });
    });
    badgeTimingController.addListener(() {
      setState(() {
        if (controller.isCompleted) {
          if (progressLevel == 3) {
            showBadge = true;
            badgeAnimController.forward();
          }
        }
      });
    });
    flareTimingController.addListener(() {
      setState(() {
        if (controller.isCompleted) {
          if (progressLevel == 3) {
            showFlare = true;
            flareAnimController.forward();
          }
        }
      });
    });
    sparkleTimingController.addListener(() {
      setState(() {
        if (controller.isCompleted) {
          if (progressLevel == 3) {
            showSparkle = true;
          }
        }
      });
    });

    badgeAnimController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    badgeSizeAnim = CurvedAnimation(
        parent: badgeAnimController, curve: Curves.fastLinearToSlowEaseIn);

    flareAnimController = AnimationController(
        vsync: this, duration: const Duration(seconds: 5000));
    sparkleAnimController = AnimationController(
        vsync: this, duration: const Duration(seconds: 5000));

    flareSizeAnim = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(
        CurvedAnimation(parent: flareAnimController, curve: Curves.easeInCirc));

    sparkleAnim = Tween<double>(
      begin: 1.0,
      end: 350.0,
    ).animate(CurvedAnimation(
        parent: sparkleAnimController, curve: Curves.slowMiddle));

    if(initiate){
      Timer(const Duration(seconds: 1), () {
        showStar = true;
        showContainer = true;
        showProgress = true;
        button1State = true;
        showButtons = true;
        badgeTimingController.forward();
        flareTimingController.forward();
        sparkleTimingController.forward();
      });
    }else{
      controller.forward();

      progressBarlevel = progressLevel / 3;
      badgeTimingController.forward();
      flareTimingController.forward();
      sparkleTimingController.forward();

      /*if(progressLevel == 3){
        button1State = true;
        button2State = false;
        button3State = false;

      }*/
    }


      timer = Timer.periodic(const Duration(milliseconds: 55), (timer) {
        setState(() {

          percent++;
          if (percent >1 && percent <= 33) {
            progress = "1/3";
          } else if (percent > 34 && percent <= 66) {
            progress = "2/3";
          } else if (percent > 68 && percent <= 99) {
            progress = "3/3";
          }

          if (percent >= (progressLevel / 3) * 100) {
            percent = (progressLevel / 3) * 100;
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
                  axis: Axis.horizontal,
                  axisAlignment: 1,
                  child: Container(
                    child: Image.asset(
                      "assets/images/star_flare1.png",
                      height: 350,
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: showContainer,
                child: SizedBox(
                  height: 180,
                  child: Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Image.asset(
                          "assets/images/full_star.png",
                          height: 180,
                        ),
                        Positioned(
                          top: 27,
                          left: 35,
                          child: SizeTransition(
                            axis: Axis.vertical,
                            sizeFactor: sizeAnimation,
                            axisAlignment: 1,
                            child: Container(
                              width: 112,
                              height: 120,
                              color: const Color(0XBF808080),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: showStar,
                child: Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: Image.asset(
                    "assets/images/empty_star.png",
                    height: 180,
                  ),
                ),
              ),
              Visibility(
                visible: _showBadge(),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 130.0,
                  ),
                  child: SizeTransition(
                    sizeFactor: badgeSizeAnim,
                    axis: Axis.horizontal,
                    axisAlignment: 1,
                    child: Image.asset(
                      "assets/images/badge1.png",
                      height: 200,
                      width: 300,
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: _showSparkle(),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 90, right: 12),
                  child: SizeTransition(
                    sizeFactor: badgeSizeAnim,
                    axis: Axis.horizontal,
                    axisAlignment: 1,
                    child: Image.asset(
                      "assets/images/sparkle.png",
                      height: 80,
                      width: 80,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Visibility(
              visible: _show(),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 50,
                ),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: LinearPercentIndicator(
                    width: MediaQuery.of(context).size.width,
                    lineHeight: 18.0,
                    progressColor: const Color(0xFFD4955B),
                    backgroundColor: const Color(0xFFF9E9DA),
                    animationDuration: 3000,
                    animateFromLastPercent: true,
                    animation: true,
                    barRadius: const Radius.circular(15.0),
                    percent: progressBarlevel,
                    center: Text(
                      progress,
                      style: const TextStyle(
                          fontSize: 12.0, fontWeight: FontWeight.bold,color: Colors.white),
                    ),
                  ),
                ),
              )),

          Visibility(
            visible: showButtons,
              child: Padding(padding: EdgeInsets.only(top: 20),
            child: Column(
              children: <Widget>[
                Padding(padding: EdgeInsets.all(2),child: ButtonBar(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      onPressed:button1State ? _button1onClick : null,
                      style: ElevatedButton.styleFrom(shape: StadiumBorder(), backgroundColor: Color(0xFFD4955B),disabledBackgroundColor: Color(0XA6808080)),
                      child: Text('1',style: TextStyle(color: Colors.white),),
                    ),
                    ElevatedButton(
                      onPressed: button2State ? _button2onClick : null,
                      style: ElevatedButton.styleFrom(shape: StadiumBorder(), backgroundColor: Color(0xFFD4955B),disabledBackgroundColor: Color(0XA6808080)),
                      child: Text('2',style: TextStyle(color: Colors.white),),
                    ),
                    ElevatedButton(
                      onPressed: button3State ?_button3onClick : null,
                      style: ElevatedButton.styleFrom(shape: StadiumBorder(), backgroundColor: Color(0xFFD4955B),disabledBackgroundColor: Color(0XA6808080),),
                      child: Text('3',style: TextStyle(color: Colors.white,),),
                    )
                  ],
                ),)

              ],
            ),))




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
