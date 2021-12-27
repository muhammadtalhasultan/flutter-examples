import 'package:flutter/material.dart';
import 'package:torch_light/torch_light.dart';

class LightSwitch extends StatefulWidget {
  const LightSwitch({Key? key}) : super(key: key);

  @override
  _LightSwitchState createState() => _LightSwitchState();
}

class _LightSwitchState extends State<LightSwitch>
    with SingleTickerProviderStateMixin {
  bool _isOn = false;
  late double _scale;
  late AnimationController _controller;
  _handleFlashLight() async {
    if (_isOn) {
      _isOn = false;
      await TorchLight.disableTorch();
    } else {
      _isOn = true;
      await TorchLight.enableTorch();
    }
  }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 300,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            bottom: 0,
            right: 0,
            left: 0,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              color: _isOn ? Colors.yellow : Colors.grey.shade700,
            ),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width / 2 - 4,
            right: MediaQuery.of(context).size.width / 2 - 4,
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
          _isOn
              ? Positioned(
                  left: MediaQuery.of(context).size.width / 2 - 75,
                  right: MediaQuery.of(context).size.width / 2 - 75,
                  top: 202,
                  child: Transform.scale(
                    scale: _scale,
                    child: Transform.rotate(
                      angle: 3.15,
                      child: GestureDetector(
                        onTapDown: _tapDown,
                        onTapUp: _tapUp,
                        onTap: () {
                          setState(() {
                            _handleFlashLight();
                          });
                        },
                        child: Image.asset(
                          'assets/flashlight_on.png',
                          width: 150,
                        ),
                      ),
                    ),
                  ),
                )
              : Positioned(
                  left: MediaQuery.of(context).size.width / 2 - 75,
                  right: MediaQuery.of(context).size.width / 2 - 75,
                  top: 202,
                  child: Transform.scale(
                    scale: _scale,
                    child: Transform.rotate(
                      angle: 3.15,
                      child: GestureDetector(
                        onTapDown: _tapDown,
                        onTapUp: _tapUp,
                        onTap: () {
                          setState(() {
                            _handleFlashLight();
                          });
                        },
                        child: Image.asset(
                          'assets/flashlight_off.png',
                          width: 150,
                        ),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  void _tapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _tapUp(TapUpDetails details) {
    _controller.reverse();
  }
}
