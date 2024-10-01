import 'package:coustom_flutter_widgets/popup_windwo.dart';
import 'package:aero_harvest/screens/homepage.dart';
import 'package:aero_harvest/utils/colors.dart';
import 'package:aero_harvest/utils/font_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:lottie/lottie.dart';

class CoustomAppbar extends StatefulWidget {
  final VoidCallback clickBtnOne;
  final VoidCallback clickBtnTwo;
  final VoidCallback scan;
  final int currentPage;
  final bool isLoad;
  final bool isConnecting;
  final VoidCallback disconnect;
  final BluetoothConnection? connection;
  const CoustomAppbar({
    super.key,
    required this.clickBtnOne,
    required this.clickBtnTwo,
    required this.currentPage,
    required this.scan,
    required this.isLoad,
    required this.isConnecting,
    required this.disconnect,  
      this.connection,
  });

  @override
  State<CoustomAppbar> createState() => _CoustomAppbarState();
}

class _CoustomAppbarState extends State<CoustomAppbar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>   Homepage(connection: widget.connection,),
                  ),
                );
              },
              child: const Icon(
                Icons.arrow_back,
                size: 28,
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.91,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 30,
                  height: 30,
                  child: widget.isLoad
                      ? Lottie.asset('assets/loading.json')
                      : null,
                ),
                const SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () {
                    widget.isConnecting
                        ? CoustomPopupWindow(
                            borderRadius: 20,
                            bgColor: AppColors().controllerBgColor,
                            title: "📵 Conform !",
                            content: Text(
                              "Are you sure disconnect ?",
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
                                  widget.disconnect();
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "Yes ",
                                  style: AppStyle().defualtText1,
                                ),
                              ),
                            ],
                          ).showPopup(context)
                        : null;
                  },
                  child: Icon(
                    Icons.wifi,
                    size: 22,
                    color: widget.isConnecting
                        ? AppColors().activeColor
                        : AppColors().offWhite,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                TextButton(
                  onPressed: () {
                    widget.clickBtnOne();
                  },
                  child: Text(
                    "Controls",
                    style: AppStyle().defualtText1.copyWith(
                          color: widget.currentPage == 0
                              ? AppColors().mainBlue
                              : AppColors().offWhite,
                        ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    widget.currentPage == 1
                        ? widget.scan()
                        : widget.clickBtnTwo();
                  },
                  child: Text(
                    widget.currentPage == 1 ? "Refresh" : "Devices",
                    style: AppStyle().defualtText1.copyWith(
                          color: widget.currentPage == 1
                              ? AppColors().mainBlue
                              : AppColors().offWhite,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
