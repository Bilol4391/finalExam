import 'package:shared_preferences/shared_preferences.dart' show SharedPreferences;

class LocaleStore{
  LocaleStore._();


  static setId( String id) async {
   SharedPreferences store=await SharedPreferences.getInstance();
   store.setString("id", id);
  }
  static getId() async {
    SharedPreferences store=await SharedPreferences.getInstance();
    return store.getString("id");
  }

  static setPin(String pin) async {
    SharedPreferences store=await SharedPreferences.getInstance();
    store.setString("pin", pin);
  }
  static getPin() async {
    SharedPreferences store=await SharedPreferences.getInstance();
  return store.getString("pin");
  }
}