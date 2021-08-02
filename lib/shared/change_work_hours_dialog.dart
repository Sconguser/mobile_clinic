import 'package:clinic_mobile/services/authorization.dart';
import 'package:clinic_mobile/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:clinic_mobile/models/work_hours.dart';
import 'package:provider/provider.dart';
import 'package:clinic_mobile/services/hours_provider.dart';

showChangeWorkHoursDialog(BuildContext context, int dayName, bool wasSetBefore) {
  String finishTime='';
  String startTime='';
  SimpleDialog dialog = SimpleDialog(
    contentPadding: EdgeInsets.all(10),
    title: Text("Select work hours"),
    children: [
      SizedBox(height:20),
      Center(
        child: Text(
            'Start: ',
          style: regularFont,
        ),
      ),
      SizedBox(height:5),
      ElevatedButton(onPressed: ()async{
        TimeOfDay initialTime = TimeOfDay(hour: 9, minute: 0);
        var hour = await showTimePicker(
          context: context,
          initialTime: initialTime,
        );
        String startHour = hour.hour.toString();
        String startMinutes = hour.minute.toString();
        startTime = startHour + ':' + startMinutes;
      }, child:Text(startTime.isEmpty? "Start hour":startTime)),
      Center(
        child: Text(
            'Finish: ',
          style:regularFont
        ),
      ),
      ElevatedButton(onPressed: ()async{
        TimeOfDay initialTime = TimeOfDay(hour: 9, minute: 0);
        var hour = await showTimePicker(
          context: context,
          initialTime: initialTime,
        );
        String finishHour = hour.hour.toString();
        String finishMinute = hour.minute.toString();
        finishTime = finishHour+':'+finishMinute;
      }, child:Text(finishTime.isEmpty? "Finish Hour":finishTime)),
      SizedBox(height: 20),
      ElevatedButton(
        onPressed: ()async{
          final auth = Provider.of<AuthorizationProvider>(context, listen:false);
          if(wasSetBefore==false)final WorkHours result = await Provider.of<HoursProvider>(context, listen: false).sendHours(startTime, finishTime, auth.user.bearerToken, dayName);
          else final WorkHours result = await Provider.of<HoursProvider>(context, listen: false).patchHours(startTime, finishTime, auth.user.bearerToken, dayName, auth.user.id);
          Navigator.pop(context);
        },
        child: Text('Change!'),
      ),
      SizedBox(height:5),
      ElevatedButton(
        onPressed: (){Navigator.pop(context);},
        child:Text('Dismiss')
      )
    ],
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return dialog;
    },
  );
}

