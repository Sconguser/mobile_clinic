import 'dart:typed_data';

import 'package:clinic_mobile/services/authorization.dart';
import 'package:clinic_mobile/shared/add_medical_procedure_dialog.dart';
import 'package:clinic_mobile/shared/bottom_navigation_bar.dart';
import 'package:clinic_mobile/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:clinic_mobile/services/procedures_provider.dart';
import 'package:provider/provider.dart';
import 'package:clinic_mobile/shared/divider.dart';
class ChangeProcedures extends StatefulWidget {
  @override
  _ChangeProceduresState createState() => _ChangeProceduresState();
}

class _ChangeProceduresState extends State<ChangeProcedures> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthorizationProvider>(context,listen:false);
    final procs = Provider.of<ProceduresProvider>(context,listen:false);
    return Scaffold(
      appBar: AppBar(
          title: Text('Medical Procedures'),
      ),
      bottomNavigationBar: MyBottomNavigationBar(),
      body:Column(
        children: [
          for(final procedure in procs.procedures)
            Column(
            children:[
              Text(procedure.name, style:bigFont),
              Text('Duration: ${procedure.duration}'),
              IconButton(onPressed:()async{
                  await Provider.of<ProceduresProvider>(context, listen:false).deleteProcedure(
                      procedure.id.toString(), auth.user.bearerToken);
              },
                  icon: Icon(
                    Icons.delete_forever,
                    color: Colors.red,)),
              MyDivider()
            ]
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>showAddProcedureDialog(context),
        child: Icon(Icons.add),
        backgroundColor: Colors.indigo,
      ),
    );
  }
}
