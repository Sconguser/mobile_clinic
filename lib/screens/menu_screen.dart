import 'package:clinic_mobile/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:clinic_mobile/shared/bottom_navigation_bar.dart';
import 'package:clinic_mobile/shared/drawer.dart';
import 'package:provider/provider.dart';
import 'package:clinic_mobile/services/authorization.dart';
class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthorizationProvider>(context, listen:false);
    return Scaffold(
      appBar: AppBar(
        title: Text('MenuScreen'),
      ),
      bottomNavigationBar: MyBottomNavigationBar(),
      drawer: MyDrawer(),
      body:Padding(
        padding: const EdgeInsets.fromLTRB(0,20,0,0),
        child: Column(
          children: [
            Center(child: CircleAvatar(radius:80,
              //backgroundColor: auth.user.accountType==1? Colors.red : Colors.blue,
              foregroundImage: auth.user.accountType == 1 ? AssetImage('assets/images/patient.jpeg'):AssetImage('assets/images/doctor.jpeg')
            )
            ),
            Center(child: Text(auth.user.name, style:bigFont)),
            Center(child: Text(auth.user.lastName, style:bigFont)),
            Center(child: Text(auth.user.email, style:bigFont))
          ],
        ),
      )
    );
  }
}
