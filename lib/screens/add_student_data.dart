import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student/db/functions/db_functions.dart';
import 'package:student/db/model/data_model.dart';

class ScreenAddStudentData extends StatefulWidget {
  const ScreenAddStudentData({Key? key}) : super(key: key);

  @override
  State<ScreenAddStudentData> createState() => _ScreenAddStudentDataState();
}

class _ScreenAddStudentDataState extends State<ScreenAddStudentData> {
  //for gallery image
  File? image;

  TextEditingController nameController = TextEditingController();

  TextEditingController ageController = TextEditingController();

  TextEditingController standardController = TextEditingController();

  TextEditingController placeController = TextEditingController();

  @override
  Widget build(BuildContext context1) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 100,
                    backgroundImage: image != null
                        ? FileImage(image!) as ImageProvider
                        : const AssetImage('images/student.png'),
                    child: IconButton(
                      iconSize: 130,
                      alignment: Alignment.bottomRight,
                      onPressed: () {
                        showBottomSheet(context);
                      },
                      icon: const Icon(
                        Icons.photo_camera,
                        size: 50,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Name',
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: ageController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Age',
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: standardController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Class',
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: placeController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Place',
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(150, 50)),
                    onPressed: () {
                      onAddStudentButtonClicked(context1);
                      setState(() {
                        nameController.clear();
                        ageController.clear();
                        standardController.clear();
                        placeController.clear();
                        image = null;
                      });
                    },
                    child: const Text('Add'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> onAddStudentButtonClicked(BuildContext context1) async {
    final name = nameController.text.trim();
    final age = ageController.text.trim();
    final standard = standardController.text.trim();
    final place = placeController.text.trim();
    if (name.isEmpty ||
        age.isEmpty ||
        standard.isEmpty ||
        place.isEmpty ||
        image == null) {
      bottomSnack(
          context1, "All fields and profile image are mandatory", Colors.red);
    } else {
      final student = StudentModel(
        name: name,
        age: age,
        standard: standard,
        place: place,
        profileImage: image!.path.toString(),
      );
      addStudent(student);
      bottomSnack(context1, "Data added successfully", Colors.green);
    }
  }

  Future<void> showBottomSheet(BuildContext ctx) async {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: ctx,
        builder: (ctx1) {
          return Container(
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          pickImageFromCamera();
                          Navigator.of(context).pop(ctx1);
                        },
                        icon: const Icon(
                          Icons.camera,
                          size: 40,
                          color: Colors.blue,
                        )),
                    const Text(
                      "Camera",
                      style: TextStyle(fontSize: 15),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        pickImage();
                        Navigator.of(context).pop(ctx1);
                      },
                      icon: const Icon(
                        Icons.photo,
                        size: 40,
                        color: Colors.blue,
                      ),
                    ),
                    const Text(
                      "Gallery",
                      style: TextStyle(fontSize: 15),
                      textAlign: TextAlign.end,
                    )
                  ],
                ),
              ],
            ),
          );
        });
  }

  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    try {
      if (image == null) {
        return;
      }
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print('Failed to pick image : $e');
    }
  }

  Future pickImageFromCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) {
        return;
      }
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print('Failed to pick image : $e');
    }
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
