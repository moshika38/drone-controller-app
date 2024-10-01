import 'dart:convert';

import 'package:aero_harvest/data/consistance.dart';
import 'package:aero_harvest/kWidgets/info_bar.dart';
import 'package:aero_harvest/utils/colors.dart';
import 'package:aero_harvest/utils/font_style.dart';
import 'package:coustom_flutter_widgets/popup_windwo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class Homepage extends StatefulWidget {
  final BluetoothConnection? connection;
  const Homepage({super.key, this.connection});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with WidgetsBindingObserver {
  bool _bluetoothState = false;
  final _bluetooth = FlutterBluetoothSerial.instance;

  double _btnOnePosition = 60;
  double _btnTwoVartical = 0;
  double _btnTwoHorizontal = 0;
  double bluVal = 100;
  int isPower = 0;
  bool isConnect = false;

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

  bool _isSendingData = false;

  Future<void> _sendData(String data) async {
    if (isPower == 1) {
      if (widget.connection?.isConnected ?? false) {
        if (!_isSendingData) {
          _isSendingData = true;
          widget.connection?.output.add(ascii.encode('$data\n'));
          print('\x1B[32m Sending data...= $data\x1B[0m');
          await Future.delayed(const Duration(milliseconds: 100));
          _isSendingData = false;
        }
      } else {
        print('\x1B[32m Cannot send ...\x1B[0m');
      }
    } else {
      print('\x1B[32m Power off ...\x1B[0m');
    }
  }

  bool isSound = true;
  ApppConsistance consistance = ApppConsistance();

  Future<void> load() async {
    bool soundValue = await consistance.loadSound();
    int battrySave = await consistance.getPowerSaving();
    int pw = await consistance.loadPower();
    bool connect = await consistance.getIsConnect();

    print("Battery Saving = $battrySave");
    setState(() {
      isSound = soundValue;
      isPower = pw;
      isConnect = connect;
    });
  }

  // get permission
  void _requestPermission() async {
    await Permission.location.request();
    await Permission.bluetooth.request();
    await Permission.bluetoothScan.request();
    await Permission.bluetoothConnect.request();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    _requestPermission();
    load();
    checkSpeed();
    _bluetooth.state.then((state) {
      setState(() => _bluetoothState = state.isEnabled);
    });

    _bluetooth.onStateChanged().listen((state) {
      switch (state) {
        case BluetoothState.STATE_OFF:
          setState(() => _bluetoothState = false);
          break;
        case BluetoothState.STATE_ON:
          setState(() => _bluetoothState = true);
          break;
      }
    });
    print(_bluetoothState);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      ApppConsistance().saveIsConncet(false);
      ApppConsistance().savePower(0);
      print("App is closed or minimized, saving connection status...");
    }
    super.didChangeAppLifecycleState(state);
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
                  const SizedBox(
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
                          Icon(
                            Icons.wifi_outlined,
                            size: 26,
                            color: isConnect
                                ? AppColors().activeColor
                                : AppColors().offWhite,
                          ),
                          const SizedBox(width: 15),
                          IconButton(
                            onPressed: () {
                              // check if device is connect or not
                              // if connect.then trun on motors
                              if (isPower == 0) {
                                ApppConsistance().savePower(1);
                                load();
                                _sendData("T100");
                                setState(() {
                                  _btnOnePosition = 60;
                                });
                              } else {
                                CoustomPopupWindow(
                                  borderRadius: 30,
                                  bgColor: AppColors().controllerBgColor,
                                  title: "📵 Warning !",
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
                              color: isPower == 1
                                  ? AppColors().activeColor
                                  : AppColors().offWhite,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
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
                              _sendData("T${getValue(_btnOnePosition)}");
                            });
                          }
                        },
                        child: const FaIcon(
                          FontAwesomeIcons.minus,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_btnOnePosition > -60) {
                            setState(() {
                              _btnOnePosition += -1;
                              _sendData("T${getValue(_btnOnePosition)}");
                            });
                          }
                        },
                        child: const FaIcon(FontAwesomeIcons.add),
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
                            _sendData("T${getValue(_btnOnePosition)}");
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
                          _sendData("P${getPich(_btnTwoVartical)}");
                          if (_btnTwoVartical < -60) _btnTwoVartical = -60;
                          if (_btnTwoVartical > 60) _btnTwoVartical = 60;
                        });
                      },
                      onHorizontalDragUpdate: (details) {
                        setState(() {
                          _btnTwoHorizontal += details.delta.dx;
                          _sendData("R${getRow(_btnTwoHorizontal)}");
                          if (_btnTwoHorizontal < -60) _btnTwoHorizontal = -60;
                          if (_btnTwoHorizontal > 60) _btnTwoHorizontal = 60;
                        });
                      },
                      onVerticalDragEnd: (details) {
                        _sendData("P0");
                        setState(() {
                          _btnTwoVartical = 0;
                        });
                      },
                      onHorizontalDragEnd: (details) {
                        _sendData("R0");
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
