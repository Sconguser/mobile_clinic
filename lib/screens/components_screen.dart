import 'dart:async';
import 'package:clinic_mobile/shared/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clinic_mobile/shared/constants.dart';
import 'package:clinic_mobile/shared/alert_dialog.dart';
import 'dart:math';

class ComponentsScreen extends StatefulWidget {
  @override
  _ComponentsScreenState createState() => _ComponentsScreenState();
}

class _ComponentsScreenState extends State<ComponentsScreen> {
  @override
  bool isChecked = false;
  int isCheckedRadio = 0;
  String _animal;
  TimeOfDay time;
  String _range = 'No range picked yet';
  String _startDate;
  String _endDate;
  final List colors = [
    Colors.pink,
    Colors.blue,
    Colors.purple,
    Colors.green,
    Colors.yellow,
    Colors.deepPurpleAccent,
    Colors.red,
    Colors.orange,
    Colors.lime,
    Colors.teal,
    Colors.indigo,
    Colors.black,
    Colors.white10,
    Colors.brown,
    Colors.amber,
    Colors.greenAccent
  ];
  Random random = Random();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ComponentsScreen'),
      ),
      bottomNavigationBar: MyBottomNavigationBar(),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(15),
          child: ListView(children: [
            buildTextFormField(),
            ElevatedButton(
              onPressed: null,
              child: Text(
                'You can click me',
                style: bigFont.copyWith(color: Colors.white),
              ),
            ),
            buildCheckboxListTile(),
            buildRadioContainer(),
            const SizedBox(height: 25),
            Text(
              'Select your spirit animal',
              style: TextStyle(
                fontSize: 25,
              ),
            ),
            buildDropdownButton(),
            const SizedBox(height: 25),
            ElevatedButton(
                onPressed: () {setState(() {});},
                child: Text('Change colors of the table')),
            buildAnimatedContainerTable(),
            TextButton(
                onPressed: () {
                  return showAlertDialog(context);
                },
                child: Text('Show alert')),
            const SizedBox(height: 25),
            Text('Selected range: $_range'),
            SfDateRangePicker(
              onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                setState(() {
                  if (args.value is PickerDateRange) {
                   _startDate = DateFormat('dd/MM/yyyy').format(args.value.startDate).toString();
                   _endDate = DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate).toString();
                    _range = '$_startDate - $_endDate';
                  }
                });
              },
              selectionMode: DateRangePickerSelectionMode.range,
              initialSelectedRange: PickerDateRange(
                  DateTime.now().subtract(const Duration(days: 4)),
                  DateTime.now().add(const Duration(days: 3))),
            ),
            const SizedBox(height: 25),
            Text('You can choose time here'),
            ElevatedButton(
                onPressed: () {
                  pickTime(context);
                },
                child: time != null
                    ? Text(
                        '${time.hour.toString().padLeft(2, '0')} : ${time.minute.toString().padLeft(2, '0')}')
                    : Text("Choose time")),
            const SizedBox(height: 25),
            Text('Spinner - for example for loading screens'),
            buildSpinKitCircle(),
            Text('Typography: '),
            Text('tinyFont', style: tinyFont),
            Text(
              'smallFont',
              style: smallFont,
            ),
            Text('regularFont', style: regularFont),
            Text(
              'bigFont',
              style: bigFont,
            ),
            Text(
              'headerFont',
              style: headerFont,
            ),
            Text(
              'enormousFont',
              style: enormousFont,
            )
          ]),
        ),
      ),
    );
  }

  SpinKitCircle buildSpinKitCircle() => SpinKitCircle(color: Colors.pink);

  Table buildAnimatedContainerTable() {
    return Table(
      children: [
        TableRow(children: [
          for (int i = 0; i < 3; i++)
            AnimatedContainer(
              color: colors[Random().nextInt(colors.length)],
              duration: const Duration(seconds: 1),
              width: 40,
              height: 40,
            ),
        ]),
        TableRow(children: [
          for (int i = 0; i < 3; i++)
            AnimatedContainer(
              color: colors[Random().nextInt(colors.length)],
              duration: const Duration(seconds: 1),
              width: 40,
              height: 40,
            ),
        ]),
        TableRow(children: [
          for (int i = 0; i < 3; i++)
            AnimatedContainer(
              color: colors[Random().nextInt(colors.length)],
              duration: const Duration(seconds: 1),
              width: 40,
              height: 40,
            ),
        ])
      ],
    );
  }

  Container buildRadioContainer() {
    return Container(
        padding: EdgeInsets.all(15),
        color: Colors.amber,
        child: Column(children: [
          Text('Here you can check one of several values'),
          ListTile(
            title: Text('This'),
            leading: Radio(
                value: 0,
                groupValue: isCheckedRadio,
                onChanged: (value) {
                  setState(() {
                    isCheckedRadio = value;
                  });
                }),
          ),
          ListTile(
            title: Text('That'),
            leading: Radio(
              value: 3,
              groupValue: isCheckedRadio,
              onChanged: (value) {
                setState(() {
                  isCheckedRadio = value;
                });
              },
            ),
          )
        ]));
  }

  CheckboxListTile buildCheckboxListTile() {
    return CheckboxListTile(
      title: Text('Here you can check and uncheck'),
      secondary: Icon(Icons.icecream),
      controlAffinity: ListTileControlAffinity.leading,
      value: isChecked,
      onChanged: (value) {
        setState(() {
          isChecked = value;
        });
      },
      activeColor: Colors.pink,
      checkColor: Colors.black,
    );
  }

  TextFormField buildTextFormField() {
    return TextFormField(
      decoration: InputDecoration(
          hintText: 'Here you can type something',
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 3.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 3.0),
          )),
    );
  }

  DropdownButton<String> buildDropdownButton() {
    return DropdownButton(
      hint: Text('Select'),
      value: _animal,
      onChanged: (value) {
        setState(() {
          _animal = value;
        });
      },
      items: <String>[
        'zebra',
        'tiger',
        'turtle',
        'tortoise',
        'I do not like animals'
      ].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Future<String> pickTime(BuildContext context) async {
    final initialTime = TimeOfDay(hour: 9, minute: 0);
    final newTime = await showTimePicker(
      context: context,
      initialTime: time ?? initialTime,
    );
    if (newTime == null) return 'Unable to pick time';
    setState(() {
      time = newTime;
    });
  }
}
