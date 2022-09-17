import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student/core/color.dart';
import 'package:student/core/constant.dart';
import 'package:student/view/add_student/text_form_widget.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../control/add_student/add_student_controller.dart';
import '../../model/data_model.dart';

class ScreenAddStudentData extends StatelessWidget {
  final int? id;
  final StudentModel? studentData;
  final bool? updateData;
  late double width;
  late double height;

  ScreenAddStudentData(
      {Key? key, this.id, this.studentData, required this.updateData})
      : super(key: key);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController standardController = TextEditingController();
  final TextEditingController placeController = TextEditingController();
  final AddStudentController addStudentController =
      Get.put(AddStudentController());

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    addStudentController.image.value = null;
    if (studentData != null) {
      nameController.text = studentData!.name;
      ageController.text = studentData!.age;
      standardController.text = studentData!.standard;
      placeController.text = studentData!.place;
      addStudentController.image.value = XFile(studentData!.profileImage!);
    }

    return Scaffold(
      backgroundColor: kbackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Add Details'),
      ),
      body: SizedBox(
        height: height,
        width: width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(
                      () {
                        return GestureDetector(
                          onTap: () {
                            homeBottomSheet();
                            log(width.toString());
                            log(height.toString());
                          },
                          child: SizedBox(
                            width: width * 50 / 100,
                            height: width * 50 / 100,
                            child: addStudentController.image.value == null
                                ? Lottie.network(
                                    imagePath,
                                  )
                                : CircleAvatar(
                                    backgroundImage: FileImage(
                                      File(addStudentController
                                          .image.value!.path),
                                    ),
                                  ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 30),
                    TextFormWidget(
                        textController: nameController, hintText: 'Name'),
                    kHeight15,
                    TextFormWidget(
                        textController: ageController, hintText: 'Age'),
                    kHeight15,
                    TextFormWidget(
                        textController: standardController, hintText: 'Class'),
                    kHeight15,
                    TextFormWidget(
                        textController: placeController, hintText: 'Place'),
                    kHeight50,
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          backgroundColor: kwhite,
                          minimumSize: Size(double.infinity, width * 12 / 100)),
                      onPressed: () async {
                        final success =
                            await addStudentController.addButtonPress(
                                name: nameController.text,
                                age: ageController.text,
                                standard: standardController.text,
                                place: placeController.text,
                                update: updateData ?? false,
                                updateData: studentData);

                        if (success) {
                          nameController.clear();
                          ageController.clear();
                          standardController.clear();
                          placeController.clear();
                          addStudentController.image.value = null;
                        }
                      },
                      child: studentData != null
                          ? const Text(
                              'UPDATE',
                              style:
                                  TextStyle(color: kbackground, fontSize: 20),
                            )
                          : const Text('ADD',
                              style:
                                  TextStyle(color: kbackground, fontSize: 20)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void homeBottomSheet() {
    Get.bottomSheet(
      Container(
        width: double.infinity,
        height: 80,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.0),
            topRight: Radius.circular(40.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            homeBottomSheetIcon(
                title: 'Camera', value: 'camera', icon: Icons.camera),
            homeBottomSheetIcon(
                title: 'Gallery', value: 'gallery', icon: Icons.photo),
          ],
        ),
      ),
    );
  }

  Column homeBottomSheetIcon(
      {required String title, required String value, required IconData icon}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: () {
              if (value == 'camera') {
                addStudentController.pickImageFromCamera();
              } else {
                addStudentController.pickImage();
              }

              Get.back();
            },
            icon: Icon(
              icon,
              size: 40,
              color: Colors.blue,
            )),
        Text(
          title,
          style: const TextStyle(fontSize: 15),
        )
      ],
    );
  }
}
