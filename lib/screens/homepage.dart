import 'package:aero_harvest/kWidgets/info_bar.dart';
import 'package:aero_harvest/utils/colors.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  double _btnOnePosition = 60;
  double bluVal = 100;

  int getValue(val) {
    double speed = 60 - val + 100;
    if (speed < 100) {
      speed = 100;
    }
    if (speed > 220) {
      speed = 220;
    }
    int newSpeed = speed.toInt();
    return newSpeed;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            DetailsBar(
              throt: getValue(_btnOnePosition),
            ),

            //left button

            Padding(
              padding: const EdgeInsets.only(left: 30, bottom: 25),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  width: 220,
                  height: 220,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: GestureDetector(
                      onVerticalDragUpdate: (details) {
                        setState(() {
                          _btnOnePosition += details.delta.dy;
                          if (_btnOnePosition > -60 || _btnOnePosition < 60) {
                            getValue(_btnOnePosition);
                          }

                          if (_btnOnePosition < -60) {
                            _btnOnePosition = -60;
                          }

                          if (_btnOnePosition > 60) {
                            _btnOnePosition = 60;
                          }
                        });
                      },
                      child: Transform.translate(
                        offset: Offset(0, _btnOnePosition),
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: AppColors().mainBlack,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // right button

            Padding(
              padding: const EdgeInsets.only(right: 30, bottom: 25),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  width: 220,
                  height: 220,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: GestureDetector(
                      onVerticalDragUpdate: (details) {
                        // up down
                      },
                      child: Transform.translate(
                        offset: Offset(0, _btnOnePosition),
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: AppColors().mainBlack,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
