import 'package:clinic_mobile/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

enum Status{unitialized, unauthorized, authorized,}

class AuthorizationProvider extends ChangeNotifier{
  AuthorizationProvider();

  User _user;
  User get user =>_user;
  Status _isAuthorized = Status.unitialized;
  Status get isAuthorized => _isAuthorized;


  Future <User> loginUser(String email, String password) async{
    try {
      final response = await http.post(
          Uri.https('murmuring-plains-08350.herokuapp.com', '/users/sign_in.json'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            'user': {
              'email': email,
              'password': password,
            }
          }));
      if (response.statusCode == 200 || response.statusCode==201) {
        _user =  User.fromJson(response.headers, jsonDecode(response.body));
        _isAuthorized = Status.authorized;
        notifyListeners();
        return user;
      }
    }catch(e){
      print(e);
      _isAuthorized = Status.unauthorized;
      notifyListeners();
      return null;
    }
  }

  Future<User> registerUser(String email, String password,
      String passwordConfirmation, String lastName, String name, String accountType, String specializations ) async {
    try {
      final response = await http.post(
          Uri.https('murmuring-plains-08350.herokuapp.com', '/users.json/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            'user': {
              'name':name,
              'lastname':lastName,
              'email': email,
              'password': password,
              'password_confirmation':passwordConfirmation,
              'account_type':accountType,
              'specializations':specializations,
            }
          }));
      if (response.statusCode == 201) {
        _user =  User.fromJsonRegister(response.headers, name,lastName,email,accountType, specializations);
        _isAuthorized = Status.authorized;
        notifyListeners();
        return user;
      }
    } catch (e) {
      _isAuthorized = Status.unauthorized;
      notifyListeners();
      return null;
    }
  }

  Future<User> patchUser(String email, String password, String passwordConfirmation, String currentPassword, String lastName, String name, String accountType,String specialization) async{
    try{
      final response = await http.patch(
        Uri.https('murmuring-plains-08350.herokuapp.com', '/users.json/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': user.bearerToken
        },
          body: jsonEncode(<String, dynamic>{
          'user': {
          'name':name,
          'lastname':lastName,
          'email': email,
          'password': password,
          'password_confirmation':passwordConfirmation,
          'current_password':currentPassword,
            'specialization':specialization,
          }
          }
      )
      );
      if(response.statusCode==204){
        _user = User(bearerToken:_user.bearerToken, name:name,lastName:lastName, email:email, accountType: accountType);
        notifyListeners();
        return user;
      }
    }catch(e){
      print(e);
    }
  }

}