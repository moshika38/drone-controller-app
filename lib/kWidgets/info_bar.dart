import 'package:aero_harvest/data/consistance.dart';
import 'package:aero_harvest/screens/settings.dart';
import 'package:aero_harvest/utils/font_style.dart';
import 'package:coustom_flutter_widgets/page_animation.dart';
import 'package:flutter/material.dart';

class DetailsBar extends StatefulWidget {
  final int throt;
  final int row;
  final int pich;
  final bool isSound;
  const DetailsBar({
    super.key,
    required this.throt,
    required this.row,
    required this.pich,
    required this.isSound,
  });

  @override
  State<DetailsBar> createState() => _DetailsBarState();
}

class _DetailsBarState extends State<DetailsBar> {
  ApppConsistance consistance = ApppConsistance();
  int power = 0;

  Future<void> load() async {
    int soundValue = await consistance.loadPower();
    setState(() {
      power = soundValue;
    });
  }

  @override
  void initState() {
    super.initState();
    load();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              child: Row(
                children: [
                  // Text(
                  //   "Yow : 0",
                  //   style: AppStyle().defualtText1,
                  // ),
                  const SizedBox(width: 22),
                  Text(
                    "Throt : ${widget.throt}",
                    style: AppStyle().defualtText1,
                  ),
                  const SizedBox(width: 22),
                  Text(
                    "Row : ${widget.row}",
                    style: AppStyle().defualtText1,
                  ),
                  const SizedBox(width: 22),
                  Text(
                    "Pich : ${widget.pich}",
                    style: AppStyle().defualtText1,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.55,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    child: Row(
                      children: [
                        // Container(
                        //   width: 150,
                        //   decoration: BoxDecoration(
                        //     color: AppColors().controllerBgColor,
                        //     borderRadius: BorderRadius.circular(100),
                        //   ),
                        //   child: Center(
                        //     child: Row(
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       children: [
                        //         const Icon(
                        //           Icons.wifi_outlined,
                        //           size: 26,
                        //         ),
                        //         const SizedBox(width: 15),
                        //         IconButton(
                        //           onPressed: () {
                        //             if (power == 0) {
                        //               ApppConsistance().savePower(1);
                        //               load();
                        //             } else {
                        //               CoustomPopupWindow(
                        //                 bgColor: AppColors().controllerBgColor,
                        //                 content: Text(
                        //                   "Are you sure ?",
                        //                   style: AppStyle().defualtText1,
                        //                 ),
                        //                 actionButtons: [
                        //                   TextButton(
                        //                     onPressed: () {
                        //                       Navigator.pop(context);
                        //                     },
                        //                     child: Text(
                        //                       "No ",
                        //                       style: AppStyle().defualtText1,
                        //                     ),
                        //                   ),
                        //                   TextButton(
                        //                     onPressed: () {
                        //                       ApppConsistance().savePower(0);
                        //                       load();
                        //                       Navigator.pop(context);
                        //                     },
                        //                     child: Text(
                        //                       "Yes ",
                        //                       style: AppStyle().defualtText1,
                        //                     ),
                        //                   ),
                        //                 ],
                        //               ).showPopup(context);
                        //             }
                        //           },
                        //           icon: Icon(
                        //             Icons.offline_bolt,
                        //             size: 26,
                        //             color: power == 1
                        //                 ? AppColors().activeColor
                        //                 : AppColors().offWhite,
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  SizedBox(
                    child: Row(
                      children: [
                        Text(
                          "100%",
                          style: AppStyle().defualtText1,
                        ),
                        const Icon(
                          Icons.battery_charging_full,
                          size: 25,
                        ),
                        const SizedBox(width: 15),
                        Icon(
                          widget.isSound
                              ? Icons.volume_up_rounded
                              : Icons.volume_off,
                          size: 27,
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              CoustomAnimation.pageAnimation(
                                const SettingsPage(),
                                const Offset(1.0, 0.0),
                                Offset.zero,
                                Curves.easeInOut,
                                500,
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.menu_open_sharp,
                            size: 30,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
