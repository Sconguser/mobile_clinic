import 'package:clinic_mobile/screens/components_screen.dart';
import 'package:clinic_mobile/screens/edit_password_screen.dart';
import 'package:clinic_mobile/screens/edit_profile_screen.dart';
import 'package:clinic_mobile/screens/menu_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:clinic_mobile/screens/sign_in_screen.dart';
import 'package:clinic_mobile/screens/sign_up_screen.dart';
import 'package:clinic_mobile/screens/change_work_hours_screen.dart';
import 'package:clinic_mobile/screens/change_medical_procedures.dart';
var myRoutes = <String,WidgetBuilder>{
  '/':(context)=>SignIn(),
  '/menu':(context)=>MenuScreen(),
  '/components':(context)=>ComponentsScreen(),
  '/sign_up':(context)=>SignUp(),
  '/edit_profile':(context)=>EditProfile(),
  '/edit_password':(context)=>EditPassword(),
  '/work_hours':(context)=>WorkHoursScreen(),
  '/procedures':(context)=>ChangeProcedures()
};