import 'package:aero_harvest/screens/homepage.dart';
import 'package:aero_harvest/utils/them_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       
      debugShowCheckedModeBanner: false,
      theme: AppThem().AppThemData,
      home: Homepage(),
    );
  }
}
