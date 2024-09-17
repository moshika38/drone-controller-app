import 'package:aero_harvest/screens/homepage.dart';
import 'package:aero_harvest/utils/colors.dart';
import 'package:aero_harvest/utils/font_style.dart';
import 'package:flutter/material.dart';

class CoustomAppbar extends StatefulWidget {
  final VoidCallback clickBtnOne;
  final VoidCallback clickBtnTwo;
  final int currentPage;
  const CoustomAppbar({
    super.key,
    required this.clickBtnOne,
    required this.clickBtnTwo,
    required this.currentPage,
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
                    builder: (context) => const Homepage(),
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
                const Icon(
                  Icons.wifi,
                  size: 18,
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
                    widget.clickBtnTwo();
                  },
                  child: Text(
                    "Devices",
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
