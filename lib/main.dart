// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:bloc/bloc.dart';
import 'package:todoapp/layout/Todo_app/Todo_Layout.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/shared/network/local/bloc_observer.dart';

void main() {
  Bloc.observer = MyBlocObserver();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Homelayout(),
      debugShowCheckedModeBanner: false,
    );
  }
}
