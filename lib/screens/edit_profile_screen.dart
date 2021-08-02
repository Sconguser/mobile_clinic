import 'package:clinic_mobile/models/user.dart';
import 'package:clinic_mobile/services/authorization.dart';
import 'package:clinic_mobile/services/validators.dart';
import 'package:clinic_mobile/shared/bottom_navigation_bar.dart';
import 'package:clinic_mobile/shared/constants.dart';
import 'package:clinic_mobile/shared/spinner.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String _email = '';
  String _password = '';
  String _name = '';
  String _lastName = '';
  String _accountType = '';
  String error = '';
  String _specialization = 'Onkolog';
  bool isVisibleError = false;
  bool isVisibleLoading = false;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthorizationProvider>(context, listen: false);

    return Scaffold(
        appBar: AppBar(
          title: Text('Edit profile'),
          actions: [
            TextButton(
                child: Text('Change password',
                    style: TextStyle(color: Colors.white)),
                onPressed: () {
                  Navigator.pushNamed(context, '/edit_password');
                })
          ],
        ),
        bottomNavigationBar: MyBottomNavigationBar(),
        body: Container(
          padding: EdgeInsets.fromLTRB(50, 50, 20, 20),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                      decoration:
                          textSignInInputDecoration.copyWith(hintText: 'Name'),
                      initialValue: auth.user.name,
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return 'Please enter your name';
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _name = value;
                        });
                      }),
                  SizedBox(height: 10),
                  TextFormField(
                      decoration: textSignInInputDecoration.copyWith(
                          hintText: 'Last name'),
                      initialValue: auth.user.lastName,
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return 'Please enter your last name';
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _lastName = value;
                        });
                      }),
                  SizedBox(height: 10),
                  TextFormField(
                      decoration: textSignInInputDecoration.copyWith(
                          hintText: 'Password'),
                      obscureText: true,
                      validator: (value) {
                        return passwordValidator(value);
                      },
                      onChanged: (value) {
                        setState(() {
                          _password = value;
                        });
                      }),
                  SizedBox(height: 10),
                  ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            if (_name.isEmpty) _name = auth.user.name;
                            if (_lastName.isEmpty)
                              _lastName = auth.user.lastName;
                            _email = auth.user.email;
                            _accountType = auth.user.accountType;

                            isVisibleLoading = true;
                          });
                          User result =
                              await Provider.of<AuthorizationProvider>(context,
                                      listen: false)
                                  .patchUser(
                                      _email,
                                      _password,
                                      _password,
                                      _password,
                                      _lastName,
                                      _name,
                                      _accountType,
                                      _specialization);
                          if (result == null) {
                            setState(() {
                              error =
                                  'Couldn\'t edit account with those credentials';
                              isVisibleError = true;
                              isVisibleLoading = false;
                            });
                          } else {
                            setState(() {
                              isVisibleError = false;
                              isVisibleLoading = false;
                            });
                            Navigator.pushNamed(context, '/menu');
                          }
                        }
                      },
                      child: Text('Edit')),
                  Visibility(
                      child: Text(error, style: TextStyle(color: Colors.red)),
                      visible: isVisibleError),
                  Visibility(
                      child: buildSpinKitCircle(), visible: isVisibleLoading)
                ],
              )),
        ));
  }
}
