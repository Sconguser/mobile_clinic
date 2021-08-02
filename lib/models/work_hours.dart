import 'package:clinic_mobile/services/hours_provider.dart';

class WorkHours{
  String startTime;
  String finishTime;
  int dayName;
  int id;
  WorkHours({this.startTime, this.finishTime, this.dayName, this.id});
  factory WorkHours.fromJson( Map<String, dynamic> body)
  {
    return WorkHours(
        id: body['id'],
        startTime: body['start_time'],
        finishTime: body['finished_time'],
        dayName: dayNameToInt(body['day_name'])
    );
  }
}