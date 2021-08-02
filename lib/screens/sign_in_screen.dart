import 'package:flutter/material.dart';
import 'package:clinic_mobile/shared/constants.dart';
import 'package:clinic_mobile/models/user.dart';
import 'package:clinic_mobile/shared/spinner.dart';
import 'package:clinic_mobile/services/validators.dart';
import 'package:clinic_mobile/services/authorization.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String _email;
  String _password;
  String error = '';
  bool isVisibleError = false;
  bool isVisibleLoading = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in'),
        actions: [
          TextButton.icon(
              icon: Icon(Icons.how_to_reg, color: Colors.white),
              label: Text('Register', style: TextStyle(color: Colors.white)),
              onPressed: ()=>Navigator.pushNamed(context,'/sign_up'),
          )
        ],
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
                  return inputValidator(value,"Please enter you email");
                },
                onChanged: (value) {
                  setState(() {
                    _email = value;
                  });
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration:
                    textSignInInputDecoration.copyWith(hintText: 'Password'),
                obscureText: true,
                validator: (value) {
                  return passwordValidator(value);
                },
                onChanged: (value) {
                  setState(() {
                    _password = value;
                  });
                },
              ),
              ElevatedButton(
                  onPressed: _signInButton,
                  child: Text('Sign in')),
              Visibility(
                  child: Text(
                    error,
                    style: TextStyle(color: Colors.red),
                  ),
                  visible: isVisibleError),
              Visibility(child: buildSpinKitCircle(), visible: isVisibleLoading)
            ],
          ),
        ),
      ),
    );
  }
  void _signInButton() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        isVisibleLoading = true;
      });
      final User result = await Provider.of<AuthorizationProvider>(context, listen: false).loginUser(_email, _password);
      if (result == null) {
        setState(() {
          error = 'Couldn\'t sign in with those credentials';
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
