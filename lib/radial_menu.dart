import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' show radians, Vector3;


class RadialMenuWidget extends StatelessWidget {
  const RadialMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox.expand(child: RadialMenu())
    );
  }
}


class RadialMenu extends StatefulWidget {
  createState() => _RadialMenuState();
}

class _RadialMenuState extends State<RadialMenu> with SingleTickerProviderStateMixin {

  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: Duration(milliseconds: 900), vsync: this);
    // ..addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return RadialAnimation(controller: controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}


class RadialAnimation extends StatelessWidget {
  RadialAnimation({super.key,  required this.controller }) :

        translation = Tween<double>(
          begin: 0.0,
          end: 100.0,
        ).animate(
          CurvedAnimation(
              parent: controller,
              curve: Curves.elasticOut
          ),
        ),

        scale = Tween<double>(
          begin: 1.5,
          end: 0.0,
        ).animate(
          CurvedAnimation(
              parent: controller,
              curve: Curves.fastOutSlowIn
          ),
        ),

        rotation = Tween<double>(
          begin: 0.0,
          end: 360.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.0, 0.7,
              curve: Curves.decelerate,
            ),
          ),
        );

  final AnimationController controller;
  final Animation<double> rotation;
  final Animation<double> translation;
  final Animation<double> scale;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (context, widget) {
          return Transform.rotate(
              angle: radians(rotation.value),
              child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                     _buildButton(0, color: Colors.red, icon: Icons.abc_sharp),
                    // _buildButton(45, color: Colors.green, icon:Icons.abc_sharp),
                    // _buildButton(90, color: Colors.orange, icon: Icons.abc_sharp),
                    // _buildButton(135, color: Colors.blue, icon:Icons.abc_sharp),
                    _buildButton(180, color: Colors.black, icon:Icons.abc_sharp),
                    _buildButton(225, color: Colors.indigo, icon:Icons.abc_sharp),
                    _buildButton(270, color: Colors.pink, icon: Icons.abc_sharp),
                    _buildButton(315, color: Colors.yellow, icon:Icons.abc_sharp),
                    Transform.scale(
                      scale: scale.value - 1,
                      child: FloatingActionButton(child: Icon(Icons.abc_sharp), onPressed: _close, backgroundColor: Colors.red),
                    ),
                    Transform.scale(
                      scale: scale.value,
                      child: FloatingActionButton(child: Icon(Icons.abc_sharp), onPressed: _open),
                    )

                  ])
          );
        });
  }

  _open() {
    controller.forward();
  }

  _close() {
    controller.reverse();
  }

  _buildButton(double angle, { required Color color, required IconData icon }) {
    final double rad = radians(angle);
    return Transform(
        transform: Matrix4.identity()..translate(
            (translation.value) * cos(rad),
            (translation.value) * sin(rad)
        ),

        child: Container(
          height: 200,
          width: 100,
          color: color,
        ),
    );
  }
}