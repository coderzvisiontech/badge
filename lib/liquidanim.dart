
import 'package:flutter/material.dart';

void main() => runApp(LiquidAnimApp());

class LiquidAnimApp extends StatelessWidget{
  const LiquidAnimApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LiquidAnim Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyLiquidAnimPage(),
    );
  }
} class MyLiquidAnimPage extends StatefulWidget{
  const MyLiquidAnimPage({super.key});

  @override
  State<MyLiquidAnimPage> createState() => _MyLiquidAnimPageState();

}

class _MyLiquidAnimPageState extends State<MyLiquidAnimPage> with TickerProviderStateMixin{
  double topPosition = 10, leftPosition = 10;
  double height = 100;
  late AnimationController _animationController;
  late Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 7));
    _expandAnimation = Tween(begin: 1.0, end: 0.0).animate(_animationController);
    _animationController.forward();
  }

  bool showFlag = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     /* appBar: AppBar(
        title:Text("Liquid Progress Bar"),
        backgroundColor: Colors.redAccent,
      ),
      body: Container(
          padding: EdgeInsets.all(25),
          height:200,
          child:Row(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(right:20),
                  child: SizedBox(
                      height: 150, width:150,
                      child:LiquidCircularProgressIndicator(
                        value: 0.5, // Defaults to 0.5.
                        valueColor: AlwaysStoppedAnimation(Colors.lightBlue), // Defaults to the current Theme's accentColor.
                        backgroundColor: Colors.white, // Defaults to the current Theme's backgroundColor.
                        borderColor: Colors.blueAccent,
                        borderWidth: 5.0,
                        direction: Axis.vertical,
                        // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
                        center: Text("Loading..."), //text inside it
                      )
                  )
              ),

              Expanded( //Expanded() widget expands inner widget to remaining space
                  child: SizedBox(
                      height: 50,
                      child:LiquidLinearProgressIndicator(
                        value: 0.45, // Defaults to 0.5.
                        valueColor: AlwaysStoppedAnimation(Colors.pink), // Defaults to the current Theme's accentColor.
                        backgroundColor: Colors.white, // Defaults to the current Theme's backgroundColor.
                        borderColor: Colors.red, //border color of the bar
                        borderWidth: 5.0, //border width of the bar
                        borderRadius: 12.0,//border radius
                        direction: Axis.horizontal,
                        // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.horizontal.
                        center: Text("50%"), //text inside bar
                      )
                  )
              ),
            ],)
      ),*/
      appBar: AppBar(title: Text('App Bar')),
      body: Container(

        alignment: Alignment.center,
        child: Stack(
          children: [
            Image.asset("assets/images/full_star.png",height: 200,),
              /*Container(
              width: 200,
              height: 200,
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
            ),*/
            SizeTransition(
              axisAlignment: 1,
              axis: Axis.vertical,
              sizeFactor: _expandAnimation,
              child: Container(
                width: 200,
                height: 200,
                color: Colors.blueGrey,
              ),
            ),
            Image.asset("assets/images/empty_star.png",height: 200,),
          ],
        ),
      ),
    );
  }

}