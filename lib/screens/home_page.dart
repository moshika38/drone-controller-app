import 'package:aero_harvest/screens/popup_window.dart';
import 'package:coustom_flutter_widgets/input_feild.dart';
import 'package:flutter/material.dart';
import 'package:aero_harvest/kWidgets/appbar.dart';
import 'package:aero_harvest/kWidgets/row_container.dart';
import 'package:aero_harvest/utils/font_style.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController ipEnter = TextEditingController();
  TextEditingController stableVal = TextEditingController();
  TextEditingController powerSave = TextEditingController();
  PageController pageController = PageController();
  bool isSound = true;
  bool isVibrate = true;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();

    pageController.addListener(() {
      setState(() {
        currentPage = pageController.page?.round() ?? 0;
      });
    });
  }

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
                          Builder(
                            builder: (BuildContext context) {
                              return GestureDetector(
                                onTap: () {
                                  CoustomBottomSheet(
                                    context: context,
                                    widget: CoustomInputWidget(
                                      controller: ipEnter,
                                      hintText: "Enter ip address",
                                      width: 300,
                                      borderColor: Color(0xFFDDDDDD),
                                    ),
                                  ).bottomSheet();
                                },
                                child: RowContainer(
                                  text: "IP Address",
                                  child: Text(
                                    "192.166.12.5",
                                    style: AppStyle().defualtText1,
                                  ),
                                ),
                              );
                            },
                          ),
                          RowContainer(
                            text: "Sound",
                            child: Switch(
                              value: isSound,
                              onChanged: (value) {
                                setState(() {
                                  isSound = value;
                                });
                              },
                            ),
                          ),
                          RowContainer(
                            text: "Vibration",
                            child: Switch(
                              value: isVibrate,
                              onChanged: (value) {
                                setState(() {
                                  isVibrate = value;
                                });
                              },
                            ),
                          ),
                          Builder(
                            builder: (context) {
                              return GestureDetector(
                                onTap: (){
                                  CoustomBottomSheet(
                                        context: context,
                                        widget: CoustomInputWidget(
                                          controller: stableVal,
                                          hintText: "Stable hovering ",
                                          width: 300,
                                          borderColor: Color(0xFFDDDDDD),
                                        ),
                                      ).bottomSheet();
                                },
                                child: RowContainer(
                                  text: "Stable Hovering",
                                  child: Text(
                                    "58 S",
                                    style: AppStyle().defualtText1,
                                  ),
                                ),
                              );
                            }
                          ),
                          Builder(
                            builder: (context) {
                              return GestureDetector(
                                onTap: (){
                                  CoustomBottomSheet(
                                        context: context,
                                        widget: CoustomInputWidget(
                                          controller: powerSave,
                                          hintText: "Power save",
                                          width: 300,
                                          borderColor: Color(0xFFDDDDDD),
                                        ),
                                      ).bottomSheet();
                                },
                                child: RowContainer(
                                  text: "Power Save",
                                  child: Text(
                                    "20 %",
                                    style: AppStyle().defualtText1,
                                  ),
                                ),
                              );
                            }
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
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
                    )
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
