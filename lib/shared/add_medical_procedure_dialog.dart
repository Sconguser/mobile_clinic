import 'package:clinic_mobile/models/medical_procedure.dart';
import 'package:clinic_mobile/services/authorization.dart';
import 'package:clinic_mobile/services/procedures_provider.dart';
import 'package:clinic_mobile/services/validators.dart';
import 'package:flutter/material.dart';
import 'package:clinic_mobile/shared/constants.dart';

import 'package:provider/provider.dart';

showAddProcedureDialog(BuildContext context) {
  String procedureName = '';
  int duration = 0;
  final _formKey = GlobalKey<FormState>();
  SimpleDialog dialog = SimpleDialog(
    key: _formKey,
    contentPadding: EdgeInsets.all(10),
    title: Text("Add a medical procedure"),
    children: [
      SizedBox(height: 20),
      TextFormField(
        validator: (value) {
          return inputValidator(value, "This field cannot be empty");
        },
        decoration: textSignInInputDecoration.copyWith(hintText: 'Procedure name'),
        onChanged: (value) {
          procedureName = value;
        },
      ),
      SizedBox(height: 5),
      TextFormField(
          validator: (value) {
        return inputValidator(value, "This field cannot be empty");
      },
        decoration: textSignInInputDecoration.copyWith(hintText:'Duration'),
        onChanged: (value){
            duration=int.parse(value);
        },
      ),
      SizedBox(height: 20),
       ElevatedButton(
        onPressed: ()async{
          final auth = Provider.of<AuthorizationProvider>(context, listen:false);
          final MedicalProcedure result = await Provider.of<ProceduresProvider>(context, listen: false).addProcedure(procedureName, duration,auth.user.bearerToken);
          print(result);
          Navigator.pop(context);
        },
       child: Text('Add a proceudre'),
      ),
      SizedBox(height: 5),
      ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Exit'))
    ],
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return dialog;
    },
  );
}
