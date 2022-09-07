// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todoapp/shared/Cubit/cubit.dart';
import 'package:todoapp/shared/Cubit/states.dart';
import 'package:todoapp/shared/components/components.dart';

class ArchivedTasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<appcubit, appstates>(
      listener: (context, state) {},
      builder: (context, state) {
        var Tasks = appcubit.get(context).archivedTasks;
        return tasksBuilder(
          Tasks: Tasks,
        );
      },
    );
  }
}
