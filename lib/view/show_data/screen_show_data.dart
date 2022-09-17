import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student/core/color.dart';
import 'package:student/view/add_student/add_student_data.dart';
import 'dart:io';

import '../../control/data_screen/data_screen_controller.dart';

class ScreenShowData extends StatelessWidget {
  final int id;
  ScreenShowData({Key? key, required this.id}) : super(key: key);
  final DataScreenController dataScreenController =
      Get.put(DataScreenController());

  @override
  Widget build(BuildContext context) {
    final list = dataScreenController.studentModelList.obs;
    final listData = list.value.singleWhere((e) => e.id == id).obs;

    return Obx(() {
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
                    studentData: listData.value,
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
                          listData.value.profileImage.toString(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    ScreenShowDataTextField(
                      content: listData.value.name,
                      title: 'Name',
                    ),
                    ScreenShowDataTextField(
                      content: listData.value.age,
                      title: 'Age',
                    ),
                    ScreenShowDataTextField(
                      content: listData.value.standard,
                      title: 'Class',
                    ),
                    ScreenShowDataTextField(
                      content: listData.value.place,
                      title: 'Place',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}

class ScreenShowDataTextField extends StatelessWidget {
  const ScreenShowDataTextField(
      {Key? key, required this.content, required this.title})
      : super(key: key);

  final String content;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$title : ',
          style: const TextStyle(fontSize: 25),
        ),
        Text(
          content,
          style: const TextStyle(fontSize: 25),
        )
      ],
    );
  }
}