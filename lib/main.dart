import 'package:flutter/material.dart';

void main() => runApp(LogoApp());

class LogoApp extends StatefulWidget {
  _LogoAppState createState() => _LogoAppState();
}

class _LogoAppState extends State<LogoApp> with TickerProviderStateMixin{

  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: const Duration(seconds:2));
    animation = Tween<double>(begin: 0, end: 300).animate(controller)..addStatusListener((status){
      if(status==AnimationStatus.completed){
        controller.reverse();
      } else if(status ==AnimationStatus.dismissed) {
        controller.forward();
      }
    })..addStatusListener((state){
      print('$state');
    });
    controller.forward();

  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedLogo(animation: animation),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class AnimatedLogo extends AnimatedWidget{
  AnimatedLogo({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

      @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        height: animation.value,
        width: animation.value,
        child: FlutterLogo(),
      );
  }
}