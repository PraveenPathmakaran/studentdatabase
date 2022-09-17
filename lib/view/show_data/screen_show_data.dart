import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student/core/color.dart';
import 'package:student/model/data_model.dart';
import 'package:student/view/add_student/add_student_data.dart';
import 'dart:io';

import '../../controller/data_screen/data_screen_controller.dart';

class ScreenShowData extends StatelessWidget {
  final int id;
  ScreenShowData({Key? key, required this.id}) : super(key: key);
  final DataScreenController dataScreenController =
      Get.put(DataScreenController());

  @override
  Widget build(BuildContext context) {
    final list = dataScreenController.studentModelList;
    final listData = list.singleWhere((e) => e.id == id);

    return Scaffold(
      backgroundColor: kbackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              Get.off(
                () => ScreenAddStudentData(
                  studentData: listData,
                  updateData: true,
                ),
              );
            },
            child: const Text(
              'EDIT',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 100,
                    backgroundImage: FileImage(
                      File(
                        listData.profileImage.toString(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  StudentDataTable(listData: listData)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class StudentDataTable extends StatelessWidget {
  const StudentDataTable({
    Key? key,
    required this.listData,
  }) : super(key: key);

  final StudentModel listData;

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: <DataColumn>[
        const DataColumn(
          label: StudentDataShowText(title: 'Name'),
        ),
        DataColumn(label: StudentDataShowText(title: listData.name)),
      ],
      rows: <DataRow>[
        DataRow(
          cells: <DataCell>[
            const DataCell(StudentDataShowText(title: 'Age')),
            DataCell(StudentDataShowText(title: listData.age)),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            const DataCell(StudentDataShowText(title: 'Class')),
            DataCell(StudentDataShowText(title: listData.standard)),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            const DataCell(StudentDataShowText(title: 'Place')),
            DataCell(StudentDataShowText(title: listData.place)),
          ],
        ),
      ],
    );
  }
}

class StudentDataShowText extends StatelessWidget {
  final String title;
  const StudentDataShowText({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: kwhite,
          overflow: TextOverflow.ellipsis),
    );
  }
}
