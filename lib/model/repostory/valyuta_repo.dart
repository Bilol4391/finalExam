
import 'package:http/http.dart' as http;
import 'package:x_pay/model/valyuta_model.dart';
class Repo {
  Repo._();
  static Future<List<Valyuta>?> getValyut() async {
    try {
      final url =
      Uri.parse(
          "https://nbu.uz/uz/exchange-rates/json/");
      final res = await http.get(url);
      return valyutaFromJson(res.body);
    } catch (e){
      return null;
    }
  }


}