import 'package:clinic_mobile/services/authorization.dart';
import 'package:clinic_mobile/services/hours_provider.dart';
import 'package:clinic_mobile/services/procedures_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyBottomNavigationBar extends StatefulWidget {
  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthorizationProvider>(context, listen:false);
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: '',
            backgroundColor: Colors.lightBlue),
        BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
            backgroundColor: Colors.blueAccent),
        BottomNavigationBarItem(
            icon: Icon(Icons.icecream),
            label: '',
            backgroundColor: Colors.lightBlueAccent),
      ],
      type: BottomNavigationBarType.shifting,
      currentIndex: _selectedIndex,
      onTap: (int index) async{
        if(index==0) await Provider.of<HoursProvider>(context, listen: false).getHours(auth.user.bearerToken, auth.user.id);
        if(index==2) await Provider.of<ProceduresProvider>(context,listen:false).getProcedures(auth.user.bearerToken);
        setState((){
          _selectedIndex = index;
        });
        if (index==0){
          Navigator.pushNamed(context,'/work_hours');
        }
        if (index == 1) {
          Navigator.pushNamed(context, '/edit_profile');
        }
        if (index == 2) {
          Navigator.pushNamed(context,'/procedures');
        }
      },
    );
  }
}
