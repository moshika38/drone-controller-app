import 'package:aero_harvest/screens/settings.dart';
import 'package:aero_harvest/utils/font_style.dart';
import 'package:coustom_flutter_widgets/page_animation.dart';
import 'package:flutter/material.dart';

class InfoBar extends StatefulWidget {
  const InfoBar({super.key});

  @override
  State<InfoBar> createState() => _InfoBarState();
}

class _InfoBarState extends State<InfoBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.45,
              child: Row(
                children: [
                  Text(
                    "Yow : 0",
                    style: AppStyle().defualtText1,
                  ),
                  const SizedBox(width: 22),
                  Text(
                    "Throt : 9.0",
                    style: AppStyle().defualtText1,
                  ),
                  const SizedBox(width: 22),
                  Text(
                    "Row : 9.0",
                    style: AppStyle().defualtText1,
                  ),
                  const SizedBox(width: 22),
                  Text(
                    "Pich : 9.0",
                    style: AppStyle().defualtText1,
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
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
                  const Icon(
                    Icons.wifi_outlined,
                    size: 25,
                  ),
                  const SizedBox(width: 15),
                  const Icon(
                    Icons.volume_up_rounded,
                    size: 27,
                  ),
                  const SizedBox(width: 15),
                  const Icon(
                    Icons.refresh,
                    size: 28,
                  ),
                  const SizedBox(width: 15),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        CoustomAnimation.pageAnimation(
                          SettingsPage(),
                          Offset(1.0, 0.0),
                          Offset.zero,
                          Curves.easeInOut,
                          500,
                        ),
                      );
                    },
                    icon: Icon(
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
    );
  }
}
