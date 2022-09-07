// ignore_for_file: prefer_const_constructors

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/shared/Cubit/cubit.dart';

Widget defultformfield({
  required final FormFieldValidator<String> validator,
  required TextEditingController controller,
  required TextInputType type,
  void Function(String)? onsubmit,
  void Function(String)? changed,
  VoidCallback? suffixpressed,
  VoidCallback? onTap,
  required String label,
  bool isPassword = false,
  required IconData prefix,
  IconData? suffix,
}) =>
    TextFormField(
      validator: validator,
      controller: controller,
      obscureText: isPassword,
      onChanged: changed,
      onTap: onTap,
      onFieldSubmitted: onsubmit,
      keyboardType: type,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixpressed,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: OutlineInputBorder(),
      ),
    );

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );
Widget buildTasksItem(Map model, context) => Dismissible(
    key: Key(model['id'].toString()),
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40.0,
            child: Text('${model['time']}'),
          ),
          SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${model['title']}'),
                Text(
                  '${model['date']}',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          IconButton(
            onPressed: () {
              appcubit
                  .get(context)
                  .updateDatabase(status: 'done', id: model['id']);
            },
            icon: Icon(Icons.check_box),
            color: Colors.green,
          ),
          IconButton(
            onPressed: () {
              appcubit.get(context).updateDatabase(
                    status: 'archived',
                    id: model['id'],
                  );
            },
            icon: Icon(Icons.archive_rounded),
            color: Colors.grey[900],
          )
        ],
      ),
    ),
    onDismissed: (Direction) {
      appcubit.get(context).DeleteDatabase(id: model['id']);
    });
Widget tasksBuilder({
  required List<Map> Tasks,
}) =>
    ConditionalBuilder(
      condition: Tasks.length > 0,
      builder: (context) => ListView.separated(
        itemBuilder: (context, index) {
          return buildTasksItem(Tasks[index], context);
        },
        separatorBuilder: (context, index) => myDivider(),
        itemCount: Tasks.length,
      ),
      fallback: (context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Icon(
              Icons.menu,
              size: 100.0,
              color: Colors.grey,
            ),
            Text(
              'No Tasks Yet, Please Add Some Tasks',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
