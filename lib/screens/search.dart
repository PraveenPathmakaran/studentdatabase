import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student/db/functions/db_functions.dart';
import 'package:student/db/model/data_model.dart';
import 'package:student/screens/screen_show_data.dart';

class NameSearch extends SearchDelegate<StudentModel> {
  final List<StudentModel> studentName = studentNotifier.value;
  var abc = studentNotifier.value.toString();
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // ignore: todo
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList =
        studentName.where((p) => p.name.startsWith(query)).toList();
    return ValueListenableBuilder(
      valueListenable: studentNotifier,
      builder:
          (BuildContext ctx, List<StudentModel> studentList, Widget? child) {
        studentList = studentList;
        return ListView.separated(
            itemCount: suggestionList.length,
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(height: 3, color: Colors.white),
            itemBuilder: (BuildContext context, int index) {
              final listData = suggestionList[index];
              return ListTile(
                onTap: () {
                  Navigator.of(context)
                      .pushReplacement(MaterialPageRoute(builder: (ctx) {
                    return ShowData(
                      id: listData.id!,
                      listData: listData,
                    );
                  }));
                },
                leading: CircleAvatar(
                  backgroundImage:
                      FileImage(File(listData.profileImage.toString())),
                ),
                title: Text(listData.name),
                subtitle: Text(listData.age),
                trailing: IconButton(
                  onPressed: () {
                    if (listData.id != null) {
                      deleteStudent(listData.id!);
                      bottomSnack(
                          context, "Successfully Deleted", Colors.green);
                    } else {
                      // ignore: avoid_print
                      print("Student id is null");
                    }
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.delete),
                  color: Colors.red,
                ),
              );
            });
      },
    );
  }

  void bottomSnack(ctx1, String textt, Color clr) {
    ScaffoldMessenger.of(ctx1).showSnackBar(
      SnackBar(
        duration: const Duration(milliseconds: 800),
        content: Text(textt),
        backgroundColor: clr,
      ),
    );
  }
}
