import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiClient {
  static String url = 'https://cyberzagrozenia.herokuapp.com/stolenData';

  static Future<int> sendData(
      {String name,
      String surname,
      String login,
      String password,
      String email,
      String telephone,
      double lat,
      double lon}) async {
    var body = {
      'name': name,
      'surname': surname,
      'login': login,
      'password': password,
      'email': email,
      'telephone': telephone,
      'lat': lat,
      'lon': lon
    };
    body.removeWhere((k, v) {
      return v == null;
    });
    body = body.map((k, v) {
      return new MapEntry(k, v?.toString());
    });
    var jsonToSend = json.encode(body).toString();

    var response = await http.post(url,
        body: jsonToSend,
        headers: {"Content-Type": "application/json"}).then((value) {
      print('Response status: ${value.statusCode}');
      print('Response body: ${value.body}');
      return value.statusCode;
    });
  }
}
