import 'package:flutter/material.dart';
import 'package:clinic_mobile/shared/divider.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  int colorShade = 500;
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: Center(child: Text('Choose an option:')),
          ),
          MyDivider(),
          ListTile(
            tileColor: Colors.purple[colorShade],
            title: Center(child: Text('Components')),
            onTap: () {
              Navigator.pushNamed(context, '/components');
            },
          ),
          MyDivider(),
          ListTile(
            tileColor: Colors.blue[colorShade],
            title: Center(child: Text('Item2')),
            onTap: () {
              setState(() {
                colorShade = 600;
              });
            },
          ),
          MyDivider(),
          ListTile(
            tileColor: Colors.green[colorShade],
            title: Center(child: Text('Item3')),
            onTap: () {
              setState(() {
                colorShade = 700;
              });
            },
          ),
          MyDivider(),
          ListTile(
            tileColor: Colors.yellow[colorShade],
            title: Center(child: Text('Item4')),
            onTap: () {
              setState(() {
                colorShade = 800;
              });
            },
          ),
          MyDivider(),
          ListTile(
            tileColor: Colors.red[colorShade],
            title: Center(child: Text('Item5')),
            onTap: () {
              setState(() {
                colorShade = 900;
              });
            },
          ),
          MyDivider(),
        ],
      ),
    );
  }
}