import 'package:hive_flutter/hive_flutter.dart';
import 'package:get/get.dart';

import '../../model/data_model.dart';

class DataScreenController extends GetxController {
  /////
  RxList<StudentModel> studentModelList = <StudentModel>[].obs;
////
  Future<void> addStudent(StudentModel value) async {
    final studentDB = await Hive.openBox<StudentModel>('student_db');
    final id = await studentDB.add(value);
    value.id = id;
    final data = StudentModel(
        id: id,
        name: value.name,
        standard: value.standard,
        place: value.place,
        age: value.age,
        profileImage: value.profileImage);
    await studentDB.put(id, data);
    getAllStudents();
  }

  Future<void> getAllStudents() async {
    final studentDB = await Hive.openBox<StudentModel>('student_db');
    studentModelList.clear();
    studentModelList.addAll(studentDB.values);
  }

  Future<void> deleteStudent(int id) async {
    final studentDB = await Hive.openBox<StudentModel>('student_db');
    await studentDB.delete(id);
    getAllStudents();
  }

  Future<void> updateStudent(
    StudentModel data,
  ) async {
    final studentDB = await Hive.openBox<StudentModel>('student_db');
    await studentDB.put(data.id, data);
    getAllStudents();
  }
}
