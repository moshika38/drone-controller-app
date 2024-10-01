import 'package:shared_preferences/shared_preferences.dart';

class ApppConsistance {
  // save sound
  Future<void> saveSound(bool isSound) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool("isSound", isSound);
  }

  // load sound
  Future<bool> loadSound() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool("isSound") ?? true;
  }
 
 
  // save power On | Off
  Future<void> savePower(int int) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt("power", int);
  }

  // load power On | Off
  Future<int> loadPower() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt("power") ?? 0;
  }
 
  // powerSave
  Future<void> powerSaving(int int) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt("battery", int);
  }

  // powerSaveoad
  Future<int> getPowerSaving() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt("battery") ?? 20;
  }


  // savedSpeed
  Future<void> saveSpeed(double int) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setDouble("speed", int);
  }

  // loadSpeed
  Future<double> getSpeed() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getDouble("speed") ?? 0;
  }



  // savedSpeed
  Future<void> saveIsConncet(bool int) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool("connect", int);
  }

  // loadSpeed
  Future<bool> getIsConnect() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool("connect") ?? false;
  }
}
