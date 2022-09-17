import 'dart:io';
import 'package:flutter/material.dart';
import 'package:student/core/color.dart';
import 'package:student/view/search/search.dart';
import '../../control/add_student/add_student_controller.dart';
import '../../control/data_screen/data_screen_controller.dart';
import '../show_data/screen_show_data.dart';
import 'package:get/get.dart';

class ScreenStudentDetails extends StatelessWidget {
  ScreenStudentDetails({Key? key}) : super(key: key);

  final DataScreenController dataScreenController =
      Get.put(DataScreenController());
  @override
  Widget build(BuildContext context) {
    dataScreenController.getAllStudents;
    return Scaffold(
      backgroundColor: kbackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
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
      body: Obx(
        () {
          return dataScreenController.studentModelList.isEmpty
              ? const Center(
                  child: Text("List is empty"),
                )
              : ListView.separated(
                  itemCount: dataScreenController.studentModelList.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(height: 3, color: Colors.white),
                  itemBuilder: (BuildContext context, int index) {
                    final listData =
                        dataScreenController.studentModelList[index];
                    return ListTile(
                      onTap: () {
                        Get.to(
                          () => ScreenShowData(
                            id: listData.id!,
                          ),
                        );
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
                            dataScreenController.deleteStudent(listData.id!);

                            Get.find<AddStudentController>().homeSnackBar(
                                title: 'Successful',
                                content: "Successfully deleted",
                                color: Colors.green);
                          } else {}
                        },
                        icon: const Icon(Icons.delete),
                        color: Colors.red,
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
