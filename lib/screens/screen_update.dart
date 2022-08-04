import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:student/db/model/data_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student/db/functions/db_functions.dart';

// ignore: must_be_immutable
class ScreenUpdate extends StatefulWidget {
  int id;
  StudentModel listData;
  ScreenUpdate({Key? key, required this.id, required this.listData})
      : super(key: key);

  @override
  State<ScreenUpdate> createState() => _ScreenUpdateState();
}

class _ScreenUpdateState extends State<ScreenUpdate> {
  File? image;
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final standardController = TextEditingController();
  final placeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    textFieldUpdate();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Data'),
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
                    backgroundImage: image == null
                        ? FileImage(
                            File(widget.listData.profileImage.toString()))
                        : FileImage(image!),
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
                      onUpdateStudentButtonClicked();
                      Navigator.pop(context);
                    },
                    child: const Text('Update'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> textFieldUpdate() async {
    nameController.text = widget.listData.name;
    ageController.text = widget.listData.age;
    standardController.text = widget.listData.standard;
    placeController.text = widget.listData.place;
  }

  Future<void> onUpdateStudentButtonClicked() async {
    final name = nameController.text.trim();
    final age = ageController.text.trim();
    final standard = standardController.text.trim();
    final place = placeController.text.trim();
    if (name.isEmpty || age.isEmpty || standard.isEmpty || place.isEmpty) {
      bottomSnack(context, 'Not Updated', Colors.red);
    } else {
      final student = StudentModel(
        id: widget.id,
        name: name,
        age: age,
        standard: standard,
        place: place,
        profileImage: image == null
            ? widget.listData.profileImage.toString()
            : image!.path.toString(),
      );
      updateStudent(student);
      getAllStudents();
      bottomSnack(context, 'Updated Succesfully', Colors.blue);
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
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
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
