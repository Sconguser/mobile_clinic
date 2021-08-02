import 'package:clinic_mobile/models/user.dart';
import 'package:clinic_mobile/services/authorization.dart';
import 'package:clinic_mobile/shared/constants.dart';
import 'package:clinic_mobile/shared/spinner.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clinic_mobile/services/validators.dart';

class EditPassword extends StatefulWidget {
  @override
  _EditPasswordState createState() => _EditPasswordState();
}

class _EditPasswordState extends State<EditPassword> {
  String _password = '';
  String _passwordNew = '';
  String _passwordConfirmation = '';
  String error = '';
  bool isVisibleError = false;
  bool isVisibleLoading = false;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthorizationProvider>(context, listen: false);

    return Scaffold(
        appBar: AppBar(
          title: Text('Edit profile'),
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(50, 50, 20, 20),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                      decoration: textSignInInputDecoration.copyWith(
                          hintText: 'Password'),
                      obscureText: true,
                      onChanged: (value) {
                        setState(() {
                          _password = value;
                        });
                      }),
                  SizedBox(height: 10),
                  TextFormField(
                      decoration: textSignInInputDecoration.copyWith(
                          hintText: 'New password'),
                      obscureText: true,
                      validator: (value) {
                        return passwordValidator(value);
                      },
                      onChanged: (value) {
                        setState(() {
                          _passwordNew = value;
                        });
                      }),
                  SizedBox(height: 10),
                  TextFormField(
                      decoration: textSignInInputDecoration.copyWith(
                          hintText: 'New password confirmation'),
                      obscureText: true,
                      validator: (value) {
                        return passwordConfirmation(value, _passwordNew);
                      },
                      onChanged: (value) {
                        setState(() {
                          _passwordConfirmation = value;
                        });
                      }),
                  ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            isVisibleLoading = true;
                          });

                          User result =
                              await Provider.of<AuthorizationProvider>(context,
                                      listen: false)
                                  .patchUser(
                                      auth.user.email,
                                      _passwordNew,
                                      _passwordConfirmation,
                                      _password,
                                      auth.user.lastName,
                                      auth.user.name,
                                      auth.user.accountType,
                              auth.user.specializations);
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
