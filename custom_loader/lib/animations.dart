
import 'package:flutter/material.dart';
import 'dart:math' as math;

class Bar extends StatelessWidget {
  final double marginLeft;
  final double marginRight;

  const Bar({Key? key, required this.marginLeft, required this.marginRight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 35.0,
      height: 15.0,
      margin: EdgeInsets.only(left: marginLeft, right: marginRight),
      decoration: BoxDecoration(
        color: const Color(0xFFFCC415),
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}

class PivotBar extends AnimatedWidget {
  final Animation<double> controller;
  final FractionalOffset alignment;
  final List<Animation<double>> animations;
  final bool isClockwise;
  final double marginLeft;
  final double marginRight;

  const PivotBar({
    Key? key,
    this.alignment = FractionalOffset.centerRight,
    required this.controller,
    required this.animations,
    required this.isClockwise,
    this.marginLeft = 15.0,
    this.marginRight = 0.0,
  }) : super(key: key, listenable: controller);

  Matrix4 clockwiseHalf(animation) =>
      Matrix4.rotationZ((animation.value * math.pi * 2.0) * .5);
  Matrix4 counterClockwiseHalf(animation) =>
      Matrix4.rotationZ(-(animation.value * math.pi * 2.0) * .5);

  @override
  Widget build(BuildContext context) {
    Matrix4 transformOne;
    Matrix4 transformTwo;
    if (isClockwise) {
      transformOne = clockwiseHalf(animations[0]);
      transformTwo = clockwiseHalf(animations[1]);
    } else {
      transformOne = counterClockwiseHalf(animations[0]);
      transformTwo = counterClockwiseHalf(animations[1]);
    }

    return Transform(
      transform: transformOne,
      alignment: alignment,
      child: Transform(
        transform: transformTwo,
        alignment: alignment,
        child: Bar(marginLeft: marginLeft, marginRight: marginRight),
      ),
    );
  }
}
