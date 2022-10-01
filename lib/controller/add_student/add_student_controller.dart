import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student/view/show_data/screen_show_data.dart';

import '../../core/color.dart';
import '../../model/data_model.dart';
import '../data_screen/data_screen_controller.dart';

class AddStudentController extends GetxController {
  RxInt tabIndex = 0.obs;

  Rxn<XFile> image = Rxn<XFile>();
  DataScreenController dataController = Get.put(DataScreenController());

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

  Future<bool> addButtonPress({
    required String name,
    required String age,
    required String standard,
    required String place,
    bool update = false,
    StudentModel? updateData,
  }) async {
    if (name == '' ||
        age == '' ||
        standard == '' ||
        place == '' ||
        image.value == null) {
      homeSnackBar(
          title: 'Failed',
          content: 'All fields and profile image are mandatory',
          color: kred);
      return false;
    } else {
      final student = StudentModel(
        name: name,
        age: age,
        standard: standard,
        place: place,
        profileImage: image.value!.path.toString(),
      );

      if (update) {
        final studentUpdate = StudentModel(
            name: name,
            age: age,
            standard: standard,
            place: place,
            profileImage: image.value!.path.toString(),
            id: updateData!.id);

        await dataController.updateStudent(studentUpdate);
        update = false;
        Get.off(ScreenShowData(id: updateData.id!));
      } else {
        dataController.addStudent(student);
      }

      homeSnackBar(
          title: 'Successful',
          content: 'Data Added Succesfully',
          color: kgreen);

      return true;
    }
  }

  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    try {
      if (image == null) {
        return;
      }
      XFile imageTemporary = XFile(image.path);

      this.image.value = imageTemporary;
    } on PlatformException catch (e) {
      homeSnackBar(title: 'Error', content: e.toString());
    }
  }

  Future pickImageFromCamera() async {
    try {
      XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) {
        return;
      }
      XFile imageTemporary = XFile(image.path);

      this.image.value = imageTemporary;
    } on PlatformException catch (e) {
      homeSnackBar(title: 'Failed to pick image', content: e.toString());
    }
  }

  void homeSnackBar(
      {required String title,
      required String content,
      Color color = Colors.white}) {
    Get.snackbar(title, content,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: color,
        duration: const Duration(seconds: 1));
  }

  @override
  void onClose() {
    Hive.close();
    super.onClose();
  }
}
