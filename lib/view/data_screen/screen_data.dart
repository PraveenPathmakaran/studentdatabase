import 'dart:io';
import 'package:flutter/material.dart';
import 'package:student/core/color.dart';
import 'package:student/view/search/search.dart';
import '../../controller/add_student/add_student_controller.dart';
import '../../controller/data_screen/data_screen_controller.dart';
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
        title: const Text(
          'ALL STUDENTS',
          style: TextStyle(color: kParisWhite),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: NameSearch());
            },
            icon: const Icon(
              Icons.search,
              color: kParisWhite,
            ),
          )
        ],
      ),
      body: Obx(
        () {
          return dataScreenController.studentModelList.isEmpty
              ? const Center(
                  child: Text("List is empty"),
                )
              : ListView.builder(
                  itemCount: dataScreenController.studentModelList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final listData =
                        dataScreenController.studentModelList[index];
                    return Card(
                      color: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: ListTile(
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
                        title: Text(
                          listData.name,
                          style: const TextStyle(color: kwhite),
                        ),
                        subtitle: Text(
                          listData.standard,
                          style: const TextStyle(color: kwhite),
                        ),
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
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
