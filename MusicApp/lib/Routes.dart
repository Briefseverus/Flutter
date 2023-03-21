import 'package:flutter/material.dart';
import 'main.dart';
import 'LoginScreen.dart';
import 'RegisterScreen.dart';
import 'main.dart';

final Map<String, WidgetBuilder> routes = {
  '/home': (context) => MyHomePage(),
  '/loginPage': (context) => LoginScreen(),
  '/resgiterPage': (context) => RegisterScreen(),
};