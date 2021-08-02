import 'package:clinic_mobile/services/authorization.dart';
import 'package:clinic_mobile/services/validators.dart';
import 'package:flutter/material.dart';
import 'package:clinic_mobile/shared/constants.dart';
import 'package:clinic_mobile/shared/spinner.dart';
import 'package:clinic_mobile/models/user.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String _email = '';
  String _password = '';
  String _passwordConfirmation = '';
  String _name = '';
  String _lastName = '';
  String error = '';
  String _accountType = 'Patient';
  String _specializacja = 'Onkolog';
  List _specializations = [];
  bool isVisibleError = false;
  bool isVisibleLoading = false;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sign Up'),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                      decoration:
                          textSignInInputDecoration.copyWith(hintText: 'Mail'),
                      validator: (value) {
                        return inputValidator(value, "Please enter your email");
                      },
                      onChanged: (value) {
                        setState(() {
                          _email = value;
                        });
                      }),
                  SizedBox(height: 6),
                  TextFormField(
                      decoration:
                          textSignInInputDecoration.copyWith(hintText: 'Name'),
                      validator: (value) {
                        return inputValidator(value, "Please enter your name");
                      },
                      onChanged: (value) {
                        setState(() {
                          _name = value;
                        });
                      }),
                  SizedBox(height: 6),
                  TextFormField(
                      decoration: textSignInInputDecoration.copyWith(
                          hintText: 'Last Name'),
                      validator: (value) {
                        return inputValidator(
                            value, "Please enter your last name");
                      },
                      onChanged: (value) {
                        setState(() {
                          _lastName = value;
                        });
                      }),
                  SizedBox(height: 6),
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
                  SizedBox(height: 6),
                  TextFormField(
                      decoration: textSignInInputDecoration.copyWith(
                          hintText: 'Password Confirmation'),
                      obscureText: true,
                      validator: (value) {
                        return passwordConfirmation(value, _password);
                      },
                      onChanged: (value) {
                        setState(() {
                          _passwordConfirmation = value;
                        });
                      }),
                  SizedBox(height: 6),
                  DropdownButton(
                    hint: Text('Choose account type'),
                    value: _accountType,
                    onChanged: (value) {
                      setState(() {
                        _accountType = value;
                      });
                    },
                    items: <String>[
                      'Patient',
                      'Doctor',
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 6),
                  if(_accountType=='Doctor') (
                      DropdownButton(
                        hint: Text('Choose your profession'),
                        value: _specializacja,
                        onChanged: (value) {
                          setState(() {
                            _specializacja = value;
                          });
                        },
                        items: <String>[
                          'Onkolog',
                          'Kardiolog',
                          'Urolog',
                          'Laryngolog',
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      )
                  ),
                  SizedBox(height: 6),
                  ElevatedButton(
                      onPressed: _signUpButton, child: Text('Sign Up')),
                  Visibility(
                      child: Text(error, style: TextStyle(color: Colors.red)),
                      visible: isVisibleError),
                  Visibility(
                      child: buildSpinKitCircle(), visible: isVisibleLoading)
                ],
              )),
        ));
  }

  void _signUpButton() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        isVisibleLoading = true;
      });

      User result =
          await Provider.of<AuthorizationProvider>(context, listen: false)
              .registerUser(_email, _password, _passwordConfirmation, _lastName,
                  _name, _accountType, _specializacja);
      if (result == null) {
        setState(() {
          error = 'Couldn\'t create account with those credentials';
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
  }
}
