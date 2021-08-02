import 'package:flutter/material.dart';

const tinyFont = TextStyle(
  fontSize: 12,
);
const smallFont = TextStyle(
  fontSize: 15,
);

const regularFont = TextStyle(
  fontSize: 20,
);
const bigFont = TextStyle(
  fontSize: 25,
);
const headerFont = TextStyle(
  fontSize: 35,
);
const enormousFont = TextStyle(
  fontSize: 50,
);

const textSignInInputDecoration = InputDecoration(
      contentPadding: EdgeInsets.symmetric(horizontal: 40),

      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black, width: 3.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blue, width: 3.0),
      )
);