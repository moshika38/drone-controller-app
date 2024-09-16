import 'package:aero_harvest/utils/colors.dart';
import 'package:aero_harvest/utils/font_style.dart';
import 'package:flutter/material.dart';

class CoustomBottomSheet {
  final BuildContext context;
  final Widget widget;

  CoustomBottomSheet({
    required this.context,
    required this.widget,
  });

  void bottomSheet() {
    Scaffold.of(context).showBottomSheet(
      elevation: 20,
      (context) => Container(
        decoration: const BoxDecoration(
          color: Color(0xFFDDDDDD),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        height: 220,
        width: 400,
        child: Center(
          child: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Save",
                          style: AppStyle().defualtText1.copyWith(
                                color: AppColors().mainBlack,
                              ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Close",
                          style: AppStyle().defualtText1.copyWith(
                                color: AppColors().mainBlack,
                              ),
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
