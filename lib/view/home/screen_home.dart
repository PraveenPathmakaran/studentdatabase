import 'package:flutter/material.dart';
import 'package:student/core/color.dart';
import 'package:student/view/add_student/add_student_data.dart';
import 'package:student/view/data_screen/screen_data.dart';
import 'package:get/get.dart';

import '../../controller/add_student/add_student_controller.dart';
import '../../controller/data_screen/data_screen_controller.dart';

class ScreenHome extends StatelessWidget {
  ScreenHome({Key? key}) : super(key: key);
  final stateController = Get.put(AddStudentController());

  //BottomNavigationbar
  final pages = [
    ScreenAddStudentData(updateData: false),
    ScreenStudentDetails()
  ];
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Scaffold(
          body: pages[stateController.tabIndex.value],
          bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: kGrey,
            selectedItemColor: kwhite,
            backgroundColor: kbackground,
            elevation: 0,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.data_array,
                  ),
                  label: 'Details'),
            ],
            currentIndex: stateController.tabIndex.value,
            onTap: (index) {
              if (index == 1) {
                Get.find<DataScreenController>().getAllStudents();
              }
              stateController.tabIndex.value = index;
            },
          ),
        );
      },
    );
  }
}
