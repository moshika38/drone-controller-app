import 'package:shared_preferences/shared_preferences.dart';

class ApppConsistance {
  // save sound

  Future<void> saveSound(bool isSound) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool("isSound", isSound);
    // print("save sound=$isSound");
  }

  // load sound

  Future<bool> loadSound() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // print("load sound");
    return preferences.getBool("isSound") ?? true;
  }
}
