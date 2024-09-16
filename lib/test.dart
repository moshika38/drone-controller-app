import 'package:flutter/material.dart';

class TestFlutter extends StatefulWidget {
  const TestFlutter({super.key});

  @override
  State<TestFlutter> createState() => _TestFlutterState();
}

class _TestFlutterState extends State<TestFlutter> {
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    
                    pageController.animateToPage(
                      0,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: const Text("tab 1"),
                ),
                TextButton(
                  onPressed: () {
                    
                    pageController.animateToPage(
                      1,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: const Text("tab 2"),
                ),
              ],
            ),
             
            Expanded(
              child: PageView(
                controller: pageController,
                children: [
                  Container(
                    color: Colors.red,
                    child: const Center(
                      child: Text("Page 1"),
                    ),
                  ),
                  Container(
                    color: Colors.blue,
                    child: const Center(
                      child: Text("Page 2"),
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
