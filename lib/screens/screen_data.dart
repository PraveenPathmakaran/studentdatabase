import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student/db/functions/db_functions.dart';
import 'package:student/db/model/data_model.dart';
import 'package:student/screens/search.dart';
import 'screen_show_data.dart';

class ScreenStudentDetails extends StatefulWidget {
  const ScreenStudentDetails({Key? key}) : super(key: key);

  @override
  State<ScreenStudentDetails> createState() => _ScreenStudentDetailsState();
}

class _ScreenStudentDetailsState extends State<ScreenStudentDetails> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Data'),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: NameSearch());
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: studentNotifier,
        builder:
            (BuildContext ctx, List<StudentModel> studentList, Widget? child) {
          studentList = studentList;
          return ListView.separated(
              itemCount: studentList.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(height: 3, color: Colors.white),
              itemBuilder: (BuildContext context, int index) {
                final listData = studentList[index];
                return ListTile(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (ctx) {
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
                            context, "Successfully deleted", Colors.green);
                      } else {
                        // ignore: avoid_print
                        print("Student id is null");
                      }
                    },
                    icon: const Icon(Icons.delete),
                    color: Colors.red,
                  ),
                );
              });
        },
      ),
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
