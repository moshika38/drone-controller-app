import 'package:aero_harvest/data/consistance.dart';
import 'package:aero_harvest/kWidgets/info_bar.dart';
import 'package:aero_harvest/utils/colors.dart';
import 'package:aero_harvest/utils/font_style.dart';
import 'package:coustom_flutter_widgets/popup_windwo.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  double _btnOnePosition = 60;
  double _btnTwoVartical = 0;
  double _btnTwoHorizontal = 0;
  double bluVal = 100;
  int power = 0;

  Future<void> checkSpeed() async {
    double savedSpeed = await consistance.getSpeed();
    setState(() {
      _btnOnePosition = savedSpeed;
    });
  }

  int getRow(double val) {
    int row = val.toInt();
    return row;
  }

  int getPich(double val) {
    int pich = val.toInt();
    return pich;
  }

  int getValue(val) {
    double speed = 60 - val + 100;
    if (speed < 100) {
      speed = 100;
    }
    if (speed > 220) {
      speed = 220;
    }
    int newSpeed = speed.toInt();
    ApppConsistance().saveSpeed(val);
    return newSpeed;
  }

  bool isSound = true;
  ApppConsistance consistance = ApppConsistance();

  Future<void> load() async {
    bool soundValue = await consistance.loadSound();
    int battrySave = await consistance.getPowerSaving();
    int pw = await consistance.loadPower();

    print("Battery Saving = $battrySave");
    setState(() {
      isSound = soundValue;
      power = pw;
    });
  }

  @override
  void initState() {
    super.initState();
    load();
    checkSpeed();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            DetailsBar(
              isSound: isSound,
              throt: getValue(_btnOnePosition),
              row: getRow(_btnTwoHorizontal),
              pich: getPich(_btnTwoVartical),
            ),

            //left button

            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Container(
                    width: 150,
                    height: 60,
                    decoration: BoxDecoration(
                      color: AppColors().controllerBgColor,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.wifi_outlined,
                            size: 26,
                          ),
                          const SizedBox(width: 15),
                          IconButton(
                            onPressed: () {
                              // check if device is connect or not
                              // if connect.then trun on motors
                              if (power == 0) {
                                ApppConsistance().savePower(1);
                                load();
                                setState(() {
                                  _btnOnePosition = 60;
                                });
                              } else {
                                CoustomPopupWindow(
                                  borderRadius: 30,
                                  bgColor: AppColors().controllerBgColor,
                                  title: "Warning !",
                                  content: Text(
                                    "Are you sure turn off ?",
                                    style: AppStyle().defualtText1,
                                  ),
                                  actionButtons: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "No ",
                                        style: AppStyle().defualtText1,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        ApppConsistance().savePower(0);
                                        load();
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "Yes ",
                                        style: AppStyle().defualtText1,
                                      ),
                                    ),
                                  ],
                                ).showPopup(context);
                              }
                            },
                            icon: Icon(
                              Icons.offline_bolt,
                              size: 26,
                              color: power == 1
                                  ? AppColors().activeColor
                                  : AppColors().offWhite,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (_btnOnePosition < 60) {
                            setState(() {
                              _btnOnePosition += 1;
                              print(_btnOnePosition);
                            });
                          }
                        },
                        child: FaIcon(
                          FontAwesomeIcons.minus,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_btnOnePosition > -60) {
                            setState(() {
                              _btnOnePosition += -1;
                              print(_btnOnePosition);
                            });
                          }
                        },
                        child: FaIcon(FontAwesomeIcons.add),
                      ),
                    ],
                  )
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 30, bottom: 25),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  width: 220,
                  height: 220,
                  decoration: BoxDecoration(
                    color: AppColors().controllerBgColor,
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
                            color: AppColors().controllerColor,
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
                    color: AppColors().controllerBgColor,
                    shape: BoxShape.circle,
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onVerticalDragUpdate: (details) {
                        setState(() {
                          _btnTwoVartical += details.delta.dy;
                          if (_btnTwoVartical < -60) _btnTwoVartical = -60;
                          if (_btnTwoVartical > 60) _btnTwoVartical = 60;
                        });
                      },
                      onHorizontalDragUpdate: (details) {
                        setState(() {
                          _btnTwoHorizontal += details.delta.dx;
                          if (_btnTwoHorizontal < -60) _btnTwoHorizontal = -60;
                          if (_btnTwoHorizontal > 60) _btnTwoHorizontal = 60;
                        });
                      },
                      onVerticalDragEnd: (details) {
                        setState(() {
                          _btnTwoVartical = 0;
                        });
                      },
                      onHorizontalDragEnd: (details) {
                        setState(() {
                          _btnTwoHorizontal = 0;
                        });
                      },
                      child: Transform.translate(
                        offset: Offset(_btnTwoHorizontal, _btnTwoVartical),
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: AppColors().controllerColor,
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
