import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:clinic_mobile/models/work_hours.dart';
import 'package:http/http.dart' as http;

class HoursProvider extends ChangeNotifier {
  HoursProvider();

  List<WorkHours> _workHours=[];

  List<WorkHours> get workHours => _workHours;

  WorkHours setHours(String startTime, String finishTime, int dayName) {
    _workHours.add(WorkHours(startTime: startTime, finishTime: finishTime, dayName: dayName));
    notifyListeners();
    return workHours.last;
  }

  Future<WorkHours>sendHours(String startTime, String finishTime, String bearerToken, int dayName) async{
    try {
      final response = await http.post(
          Uri.https('murmuring-plains-08350.herokuapp.com', '/working_hours/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': bearerToken
          },
          body: jsonEncode(<String, dynamic>{
            'working_hours': {
                  "day_name":dayName,
                  "start_time":startTime,
                  "finished_time":finishTime
            }
          }
          )
      );
      if (response.statusCode == 200) {
        _workHours[dayName] =  WorkHours(startTime: startTime, finishTime: finishTime);
        notifyListeners();
        return workHours[dayName];
      }
    }catch(e){
      notifyListeners();
    }
  }

  Future<WorkHours>patchHours(String startTime, String finishTime, String bearerToken, int dayName, int id) async{
    try {
      final response = await http.patch(
          Uri.https('murmuring-plains-08350.herokuapp.com', '/working_hours/$id'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': bearerToken
          },
          body: jsonEncode(<String, dynamic>{
            'working_hours': {
              "day_name":dayName,
              "start_time":startTime,
              "finished_time":finishTime
            }
          }
          )
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        _workHours[dayName] =  WorkHours(startTime: startTime, finishTime: finishTime);
        notifyListeners();
        return workHours[dayName];
      }
    }catch(e){
      notifyListeners();
    }
  }

  Future<List<WorkHours>>getHours(String bearerToken, int id) async{
    try {
      final response = await http.get(
        Uri.https('murmuring-plains-08350.herokuapp.com', '/working_hours/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': bearerToken
        },
      );
      if (response.statusCode == 200) {
        List days = jsonDecode(response.body);

        days.forEach((day) =>
            setHours(truncateTime(day['start_time']),
                truncateTime(day['finished_time']),
                dayNameToInt(day['day_name'])));
        notifyListeners();
        return _workHours;
      }
    } catch(e) {
        print(e);
        print('Failed');
      }
  }
  Future<List<WorkHours>>deleteDay(String id, String bearerToken, int userID) async{
    try{
      final response = await http.delete(
        Uri.https('murmuring-plains-08350.herokuapp.com', '/working_hours/$id'),
        headers: <String, String>{
          'Content-Type':'application/json; charset=UTF-8',
          'Authorization':bearerToken
        },
      );
      print(response.statusCode);
      if(response.statusCode==200){
        getHours(bearerToken, userID);
        return workHours;
      }
    }catch(e){
      print(e);
      notifyListeners();
      return null;
    }
  }
}

int dayNameToInt(String day){
  Map<String, int>dayNames = {
    "Monday":0,
    "Tuesday":1,
    "Wednesday":2,
    "Thursday":3,
    "Friday":4,
    "Saturday":5,
    "Sunday":6
  };
  return dayNames[day];
}

String truncateTime(String time){
  return (time.split("T")[1]).split(":")[0]+':'+(time.split("T")[1]).split(":")[1];
}

WorkHours findDay(int dayName, List<WorkHours>workHours){
  for(int i=0; i<workHours.length; i++){
    if(workHours[i].dayName==dayName)
      {
        return workHours[i];
      }
  }
  return null;
}
