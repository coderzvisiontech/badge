import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:rive/rive.dart';

InAppLocalhostServer localhostServer = InAppLocalhostServer();

/*void main() {
  runApp(const MyApp());
}*/
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await localhostServer.start();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Badge',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Badge'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late InAppWebViewController webView;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await webView.canGoBack()) {
          webView.goBack();
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Center(
                  child: InAppWebView(
                    initialFile: "assets/index.html",
                    onWebViewCreated: (InAppWebViewController controller) {
                      webView = controller;
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    localhostServer.close();
    super.dispose();
  }
/* double percent = 0.0;
  String value = "1/";

  @override
  void initState() {
    Timer timer;
    timer = Timer.periodic(const Duration(milliseconds:400),(_){
      setState(() {
        percent+=3;
        if(percent >= 10){
          percent=0;

        }

      });
    });
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body:const Center(

        child: RiveAnimation.asset('assets/star_animation.riv',fit: BoxFit.contain,),
        */ /*child: Column(

          children: [

            const Padding(padding: EdgeInsets.only(top: 40.0)),
            Image.asset('assets/anim3.gif',gaplessPlayback: false,height: 200,),
            LinearPercentIndicator(
              width: MediaQuery.of(context).size.width,
              lineHeight: 25,
              percent: percent/10,
              center: Text(  '$percent',style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),),
              animation: true,
              animationDuration: 400,
              barRadius: const Radius.circular(15.0),
              backgroundColor: const Color(0xFFF9E9DA),
              progressColor: const Color(0xFFE5A468),
            ),

          ],
        ),*/ /*

     */ /*  child:
       LinearPercentIndicator(
          width: MediaQuery.of(context).size.width,
          lineHeight: 15,
          percent: 100/100,
          center: const Text("2/3",style: TextStyle(fontSize: 12.0),),
          animation: true,
          animationDuration: 2000,
          barRadius: const Radius.circular(15.0),
        ),*/ /*

     */ /* child: Column(
        children: [
          Container(

          ),

          Container(

            child: LinearPercentIndicator(
              width: MediaQuery.of(context).size.width * 0.8,
              lineHeight: 15,
              percent: 100/100,
              center: const Text("2/3",style: TextStyle(fontSize: 12.0),),
              animation: true,
              animationDuration: 2000,
              barRadius: const Radius.circular(15.0),
            ),
          )
        ],

      ),*/ /*
      ),
    );
  }*/
}
