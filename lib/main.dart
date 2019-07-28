import 'package:flutter/material.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> with TickerProviderStateMixin {
  Animation<double> animation;
  AnimationController animationController;

  @override
  void initState() {
    var test = 222;
    animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 4000));
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.bounceOut,
    );

    super.initState();
    animationController.forward(from: 0.0);

    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        animationController.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          color: Colors.cyan[100],
          child: Center(
            child: AnimatedLogo(
              animation: animation,
            ),
          ),
        ),
      ),
    );
  }
}

class AnimatedLogo extends AnimatedWidget {
  final Tween<double> _rotationAnimation = Tween<double>(begin: 2.0, end: 0.0);

  AnimatedLogo({Key key, Animation animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Opacity(
      opacity: animation.value,
      child: Transform.rotate(
        angle: _rotationAnimation.evaluate(animation),
        child: Container(
          width: animation.value * 400,
          height: animation.value * 400,
          child: Image.asset('assets/images/logo.png'),
        ),
      ),
    );
  }
}
