// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, file_names, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, non_constant_identifier_names, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/shared/Cubit/cubit.dart';
import 'package:todoapp/shared/Cubit/states.dart';
import 'package:todoapp/shared/components/components.dart';

class NewTasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<appcubit, appstates>(
      listener: (context, state) {},
      builder: (context, state) {
        var Tasks = appcubit.get(context).newTasks;
        return tasksBuilder(
          Tasks: Tasks,
        );
      },
    );
  }
}
