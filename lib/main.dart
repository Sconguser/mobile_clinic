import 'package:clinic_mobile/services/procedures_provider.dart';
import 'package:flutter/material.dart';
import 'package:clinic_mobile/shared/routes.dart';
import 'package:provider/provider.dart';
import 'services/authorization.dart';
import 'services/hours_provider.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthorizationProvider>(
          create: (context)=>AuthorizationProvider()
        ),
        ChangeNotifierProvider<HoursProvider>(
            create: (context)=>HoursProvider()
        ),
        ChangeNotifierProvider<ProceduresProvider>(
            create: (context)=>ProceduresProvider()
        )
      ],
      child: MaterialApp(
        title: 'Virtual Clinic',
        initialRoute: '/',
        routes: myRoutes,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.lightBlue,
          accentColor: Colors.blue[800],
          primaryTextTheme: Theme.of(context).textTheme.apply(
            bodyColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
