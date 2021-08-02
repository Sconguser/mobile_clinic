import 'package:clinic_mobile/services/authorization.dart';
import 'package:clinic_mobile/shared/bottom_navigation_bar.dart';
import 'package:clinic_mobile/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:clinic_mobile/shared/divider.dart';
import 'package:clinic_mobile/services/hours_provider.dart';
import 'package:clinic_mobile/shared/change_work_hours_dialog.dart';
import 'package:provider/provider.dart';
import 'package:clinic_mobile/models/work_hours.dart';

class WorkHoursScreen extends StatefulWidget {
  @override
  _WorkHoursScreenState createState() => _WorkHoursScreenState();
}

final List days = [
  "Monday",
  "Tuesday",
  "Wednesday",
  "Thursday",
  "Friday",
  "Saturday",
  "Sunday"
];

class _WorkHoursScreenState extends State<WorkHoursScreen> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthorizationProvider>(context,listen:false);
    final hoursList = Provider.of<HoursProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: Text('Work Hours')),
      bottomNavigationBar: MyBottomNavigationBar(),
      body: Column(
        children: [
          for(final day in days)
            Column(
              children: [
                buildGestureDetector(context, hoursList, day),
                IconButton(onPressed:()async{
                  int id = findDay(dayNameToInt(day), hoursList.workHours).id;
                  await Provider.of<HoursProvider>(context, listen:false).deleteDay(id.toString(),auth.user.bearerToken, auth.user.id);
                },
                    icon: Icon(
                      Icons.delete_forever,
                      color: Colors.red,)),
                MySmallDivider(),
              ],
            )
        ],
      ),
    );
  }

  GestureDetector buildGestureDetector(
      BuildContext context, HoursProvider hoursList, String dayName) {
    WorkHours day = findDay(dayNameToInt(dayName), hoursList.workHours);
    return GestureDetector(
      onTap: () => showChangeWorkHoursDialog(
          context, dayNameToInt(dayName), day == null ? false : true),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: 50,
        child: Row(children: [
          Text(dayName, style: regularFont),
          SizedBox(width: 50),
          Text(day == null ? 'Not set' : day.startTime, style: regularFont),
          SizedBox(width: 50),
          Text(day == null ? 'Not set' : day.finishTime, style: regularFont)
        ]),
      ),
    );
  }
}
