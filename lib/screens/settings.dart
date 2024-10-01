import 'dart:async';
import 'package:coustom_flutter_widgets/popup_windwo.dart';
import 'package:aero_harvest/data/consistance.dart';
import 'package:aero_harvest/screens/homepage.dart';
import 'package:aero_harvest/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:aero_harvest/kWidgets/appbar.dart';
import 'package:aero_harvest/kWidgets/row_container.dart';
import 'package:aero_harvest/utils/font_style.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({
    super.key,
  });

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _bluetooth = FlutterBluetoothSerial.instance;
  bool _isConnecting = false;
  BluetoothConnection? _connection;
  List<BluetoothDevice> _devices = [];
  BluetoothDevice? _deviceConnected;

  void _getDevices() async {
    var res = await _bluetooth.getBondedDevices();
    setState(() => _devices = res);
  }

  PageController pageController = PageController();
  int currentPage = 0;

  ApppConsistance consistance = ApppConsistance();
  bool isSound = true;
  bool isLoad = false;
  double saving = 20;

  Future<void> load() async {
    bool soundValue = await consistance.loadSound();
    int battery = await consistance.getPowerSaving();
    bool device = await consistance.getIsConnect();
    setState(() {
      isSound = soundValue;
      saving = battery.toDouble();
      _isConnecting = device;
    });
    print('\x1B[32mReloading data...\x1B[0m');
  }

  Timer? _connectionCheckTimer;

  Future<void> _checkConnectionStatus(BluetoothConnection? connection) async {
    if (connection != null) {
      try {
        bool isConnected = connection.isConnected;
        if (!isConnected) {
          print('\x1B[32mWarning : Disconnect devices\x1B[0m');
          ApppConsistance().saveIsConncet(false);
          ApppConsistance().savePower (0);
          setState(() {
            isConnected = false;
          });
          load();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const SettingsPage()),
          );

          _connectionCheckTimer?.cancel();
        }
      } catch (e) {
        print('Error checking connection: $e');
        _connectionCheckTimer?.cancel();
      }
    }
  }
  // print('\x1B[32mWarning : Disconnect devices\x1B[0m');

  @override
  void initState() {
    super.initState();
    load();
    pageController.addListener(() {
      setState(() {
        currentPage = pageController.page?.round() ?? 0;
      });
    });

    _connectionCheckTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _checkConnectionStatus(_connection);
    });
  }

  Future<void> _disconnectDevice() async {
    if (_connection != null && _connection!.isConnected) {
      try {
        print('Device disconnected by user');
        await _connection!.close();
        setState(() {
          _isConnecting = false;
          _deviceConnected = null;
        });
        ApppConsistance().saveIsConncet(false);
        load();
      } catch (e) {
        print('\x1B[32m Disconnect Error(s) $e \x1B[0m');
      }
    } else {
      print('\x1B[32m Not Disconnect \x1B[0m');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Homepage(
                    connection: _connection,
                  )),
        );
        return false;
      },
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CoustomAppbar(
                  connection: _connection,
                  disconnect: () {
                    _disconnectDevice();
                  },
                  isConnecting: _isConnecting,
                  isLoad: isLoad,
                  scan: () {
                    // call blutooth scan function
                    _getDevices();
                  },
                  currentPage: currentPage,
                  clickBtnOne: () {
                    pageController.animateToPage(
                      0,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                  clickBtnTwo: () {
                    pageController.animateToPage(
                      1,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
                Expanded(
                  child: PageView(
                    controller: pageController,
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            RowContainer(
                              text: "Sound",
                              child: Padding(
                                padding: const EdgeInsets.only(right: 18),
                                child: Switch(
                                  value: isSound,
                                  onChanged: (value) {
                                    ApppConsistance().saveSound(value);
                                    load();
                                  },
                                ),
                              ),
                            ),
                            RowContainer(
                              text: "Power Save",
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      if (saving != 0) {
                                        setState(() {
                                          saving -= 10;
                                          consistance
                                              .powerSaving(saving.toInt());
                                        });
                                      }
                                    },
                                    child: Icon(
                                      Icons.arrow_circle_left_outlined,
                                      color: AppColors().offWhite,
                                    ),
                                  ),
                                  Text(
                                    "${saving.toInt()}%",
                                    style: AppStyle().defualtText1,
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      if (saving != 100) {
                                        setState(() {
                                          saving += 10;
                                          consistance
                                              .powerSaving(saving.toInt());
                                        });
                                      }
                                    },
                                    child: Icon(
                                      Icons.arrow_circle_right_outlined,
                                      color: AppColors().offWhite,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            for (final device in _devices)
                              GestureDetector(
                                onTap: () async {
                                  if (_isConnecting == false) {
                                    setState(() {
                                      isLoad = true;
                                    });
                                    try {
                                      _connection =
                                          await BluetoothConnection.toAddress(
                                              device.address);

                                      if (_connection != null &&
                                          _connection!.isConnected) {
                                        setState(() {
                                          _deviceConnected = device;
                                          _isConnecting = true;
                                          ApppConsistance().saveIsConncet(true);
                                          isLoad = false;
                                        });
                                      }
                                    } catch (e) {
                                      setState(() {
                                        _isConnecting = false;
                                        ApppConsistance().saveIsConncet(false);
                                        isLoad = false;
                                      });
                                    }
                                  } else {
                                    CoustomPopupWindow(
                                      borderRadius: 20,
                                      bgColor: AppColors().controllerBgColor,
                                      title: "⚠ Warning !",
                                      content: Text(
                                        "( Recommended No ) Reconnect ?",
                                        style: AppStyle().defualtText1,
                                      ),
                                      actionButtons: [
                                        TextButton(
                                          onPressed: () async {
                                            Navigator.pop(context);
                                            setState(() {
                                              isLoad = true;
                                            });
                                            try {
                                              _connection =
                                                  await BluetoothConnection
                                                      .toAddress(
                                                          device.address);

                                              if (_connection != null &&
                                                  _connection!.isConnected) {
                                                setState(() {
                                                  _deviceConnected = device;
                                                  _isConnecting = true;
                                                  ApppConsistance()
                                                      .saveIsConncet(true);
                                                  isLoad = false;
                                                });
                                              }
                                            } catch (e) {
                                              setState(() {
                                                _isConnecting = false;
                                                ApppConsistance()
                                                    .saveIsConncet(false);
                                                isLoad = false;
                                              });
                                            }
                                          },
                                          child: Text(
                                            "Yes ",
                                            style: AppStyle().defualtText1,
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "No  ",
                                            style: AppStyle().defualtText1,
                                          ),
                                        ),
                                      ],
                                    ).showPopup(context);
                                  }
                                },
                                child: RowContainer(
                                  text: device.name ?? device.address,
                                  child: const SizedBox(),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
