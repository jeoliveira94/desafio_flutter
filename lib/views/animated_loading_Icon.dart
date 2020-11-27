import 'package:flutter/material.dart';

class AnimatedLoadingIcon extends StatefulWidget {
  @override
  _AnimatedLoadingIconState createState() => new _AnimatedLoadingIconState();
}

class _AnimatedLoadingIconState extends State<AnimatedLoadingIcon>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
      vsync: this,
      duration: new Duration(seconds: 1),
    );

    animationController.repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.white,
      child: AnimatedBuilder(
        animation: animationController,
        child: Container(
          child: Image.asset('resources/images/refresh_black_48x48.png'),
        ),
        builder: (BuildContext context, Widget _widget) {
          return Transform.rotate(
            angle: animationController.value * 6,
            child: _widget,
          );
        },
      ),
    );
  }
}
