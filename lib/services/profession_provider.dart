import 'package:flutter/material.dart';
import 'package:clinic_mobile/models/user.dart';
import 'package:http/http.dart' as http;

class ProfessionProvider extends ChangeNotifier {
  ProfessionProvider();

  List<User> _specializations=[];

  List<User> get specializations => _specializations;
  String specjalizacja;
  User setSpecializations(int id, String name ) {
    _specializations.add(User(specializations: specjalizacja));
    notifyListeners();
    return specializations.last;
  }

  Future<List<User>>getSpecializations(String bearerToken, int ids) async
  {
    try {
      final response = await http.get(
        Uri.https('murmuring-plains-08350.herokuapp.com', '/specializations/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': bearerToken
        },
      );
      if (response.statusCode == 200) {
        notifyListeners();
        return _specializations;
      }
    } catch(e) {
      print(e);
      print('Failed');
    }
  }
}
