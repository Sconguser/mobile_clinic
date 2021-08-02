import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clinic_mobile/models/medical_procedure.dart';
import 'package:http/http.dart' as http;

class ProceduresProvider extends ChangeNotifier{
  ProceduresProvider();
  List<MedicalProcedure> _procedures=[];
  List<MedicalProcedure> get procedures=>_procedures;

  Future<List<MedicalProcedure>>getProcedures(String bearerToken) async{
    try{
      final response = await http.get(
        Uri.https('murmuring-plains-08350.herokuapp.com', '/medical_treatments/'),
        headers:<String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization':bearerToken
        }
      );
      if(response.statusCode==200){
        _procedures.clear();
        List temp = jsonDecode(response.body);
        temp.forEach((element) =>
            _procedures.add(
                MedicalProcedure(
                    id:element['id'],
                    name:element['name'],
                    doctorId: element['doctor_id'],
                    duration: element['duration']
                )
            )
        );
        notifyListeners();
        return _procedures;
      }
    }catch(e){
      notifyListeners();
      return null;
    }
  }
  Future<MedicalProcedure>addProcedure(String name,int duration, String bearerToken)async{
    try{

      final response = await http.post(
        Uri.https('murmuring-plains-08350.herokuapp.com', '/medical_treatments/'),
        headers: <String, String>{
          'Content-Type':'application/json; charset=UTF-8',
          'Authorization':bearerToken
        },
        body:jsonEncode(<String,dynamic>{
          'medical_treatment':{
              'name':name,
              'duration':duration
          }
        }
        )
      );
      if(response.statusCode==200){
        getProcedures(bearerToken);
        return _procedures.last;
      }
    }
      catch(e){
        print(e);
        notifyListeners();
        return null;
    }
    }
    Future<MedicalProcedure>deleteProcedure(String id, String bearerToken) async{
      try{
        final response = await http.delete(
          Uri.https('murmuring-plains-08350.herokuapp.com', '/medical_treatments/$id'),
          headers: <String, String>{
            'Content-Type':'application/json; charset=UTF-8',
            'Authorization':bearerToken
          },
        );
        print(response.statusCode);
        if(response.statusCode==200){
          getProcedures(bearerToken);
          return _procedures.last;
        }
      }catch(e){
        print(e);
        notifyListeners();
        return null;
      }
    }
  }