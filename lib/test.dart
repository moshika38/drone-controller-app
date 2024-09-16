import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  double _btnOnePosition = 60;
  double bluVal = 100;

  void getValue(val) {
    double speed = 60 - val + 100;
    if (speed < 100) {
      speed = 100;
    }
    if (speed > 220) {
      speed = 220;
    }
    int newSpeed = speed.toInt();

    print(newSpeed); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Outer container (gray)
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey,
                shape: BoxShape.circle,
              ),
            ),
            // Draggable Inner container (black)
            GestureDetector(
              onVerticalDragUpdate: (details) {
                setState(() {
                  // Update vertical position but limit within outer container bounds
                  _btnOnePosition += details.delta.dy;
                  if (_btnOnePosition > -60 || _btnOnePosition < 60) {
                    getValue(_btnOnePosition);
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
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text("${_btnOnePosition.toInt()}"),
            )
          ],
        ),
      ),
    );
  }
}
