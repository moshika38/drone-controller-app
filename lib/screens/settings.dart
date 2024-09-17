import 'package:aero_harvest/data/consistance.dart';
import 'package:flutter/material.dart';
import 'package:aero_harvest/kWidgets/appbar.dart';
import 'package:aero_harvest/kWidgets/row_container.dart';
import 'package:aero_harvest/utils/font_style.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  PageController pageController = PageController();
  int currentPage = 0;

  bool isSound = true;
  ApppConsistance consistance = ApppConsistance();

   Future<void> load() async {
    bool soundValue = await consistance.loadSound();

    setState(() {
      isSound = soundValue;
    });
  }

  @override
  void initState() {
    super.initState();
      load();
    pageController.addListener(() {
      setState(() {
        currentPage = pageController.page?.round() ?? 0;
      });
    });
  }

  double saving = 20;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CoustomAppbar(
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
                            text: "Stable Hovering",
                            child: Padding(
                              padding: const EdgeInsets.only(right: 25),
                              child: Text(
                                "58 S",
                                style: AppStyle().defualtText1,
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
                                      });
                                    }
                                  },
                                  child: Icon(Icons.arrow_circle_left_outlined),
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
                                      });
                                    }
                                  },
                                  child:
                                      Icon(Icons.arrow_circle_right_outlined),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SingleChildScrollView(
                      child: Column(
                        children: [
                          RowContainer(
                            text: "HC - 06",
                            child: SizedBox(),
                          ),
                          RowContainer(
                            text: "Samsung a04",
                            child: SizedBox(),
                          ),
                          RowContainer(
                            text: "JBL - 45Sh09",
                            child: SizedBox(),
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
    );
  }
}
