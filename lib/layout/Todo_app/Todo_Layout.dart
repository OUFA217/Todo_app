// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, file_names, avoid_print, use_key_in_widget_constructors, unused_local_variable, prefer_typing_uninitialized_variables, unused_field, dead_code, await_only_futures, body_might_complete_normally_nullable, avoid_types_as_parameter_names, prefer_is_empty, import_of_legacy_library_into_null_safe, must_be_immutable, unused_import

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/shared/Cubit/cubit.dart';
import 'package:todoapp/shared/Cubit/states.dart';
import 'package:todoapp/shared/components/components.dart';

class Homelayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => appcubit()..createDatabase(),
      child: BlocConsumer<appcubit, appstates>(
        listener: (context, state) {
          if (state is appinsertdatabase) {
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, appstates state) {
          appcubit cubit = appcubit.get(context);
          return Scaffold(
            key: cubit.ScaffoldKey,
            appBar: AppBar(
              title: Text(
                cubit.Title[cubit.currentIndex],
              ),
            ),
            body: ConditionalBuilder(
              condition: state is! appgetdatabaseloadingstate,
              builder: (context) => cubit.Screens[cubit.currentIndex],
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
            floatingActionButton: (FloatingActionButton(
              onPressed: () {
                if (cubit.isBottomSheetDown) {
                  if (cubit.FormKey.currentState!.validate()) {
                    cubit.insertDatabase(
                        title: cubit.titlecontroller.text,
                        time: cubit.timecontroller.text,
                        date: cubit.datecontroller.text);
                  }
                } else {
                  cubit.ScaffoldKey.currentState
                      ?.showBottomSheet(
                        (context) => Container(
                          color: Colors.grey[100],
                          padding: EdgeInsets.all(20.0),
                          child: Form(
                            key: cubit.FormKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                defultformfield(
                                  validator: (String? Value) {
                                    if (Value!.isEmpty) {
                                      return 'Title must not be empty';
                                    }
                                    return null;
                                  },
                                  controller: cubit.titlecontroller,
                                  type: TextInputType.text,
                                  label: 'Task Title ',
                                  prefix: Icons.title,
                                ),
                                SizedBox(
                                  height: 15.00,
                                ),
                                defultformfield(
                                  validator: (String? Value) {
                                    if (Value!.isEmpty) {
                                      return 'Timee must not be empty';
                                    }
                                    return null;
                                  },
                                  controller: cubit.timecontroller,
                                  onTap: () {
                                    showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now())
                                        .then((value) {
                                      cubit.timecontroller.text =
                                          value!.format(context);
                                      print(value.format(context));
                                    });
                                  },
                                  type: TextInputType.datetime,
                                  label: 'Task time ',
                                  prefix: Icons.timelapse,
                                ),
                                SizedBox(
                                  height: 15.00,
                                ),
                                defultformfield(
                                  validator: (String? Value) {
                                    if (Value!.isEmpty) {
                                      return 'Date must not be empty';
                                    }
                                    return null;
                                  },
                                  controller: cubit.datecontroller,
                                  onTap: () {
                                    showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now(),
                                            lastDate:
                                                DateTime.parse('2023-07-21'))
                                        .then((value) {
                                      cubit.datecontroller.text =
                                          DateFormat.yMMMd().format(value!);
                                      print(DateFormat.yMMMd().format(value));
                                    });
                                  },
                                  type: TextInputType.datetime,
                                  label: 'Task date ',
                                  prefix: Icons.calendar_today,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .closed
                      .then((value) {
                    cubit.changebottmomsheet(isShow: false, icon: Icons.edit);
                  });

                  cubit.changebottmomsheet(isShow: true, icon: Icons.add);
                }
              },
              child: Icon(cubit.defultIcon),
            )),
            bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: cubit.currentIndex,
                onTap: (index) {
                  cubit.changeindex(index);
                },
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.menu), label: 'Tasks'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.check_box), label: 'Done'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.archive), label: 'Archived'),
                ]),
          );
        },
      ),
    );
  }
}
