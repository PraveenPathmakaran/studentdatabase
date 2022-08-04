import 'package:flutter/cupertino.dart';
import 'package:student/db/model/data_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

ValueNotifier<List<StudentModel>> studentNotifier = ValueNotifier([]);

Future<void> addStudent(StudentModel value) async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  // ignore: no_leading_underscores_for_local_identifiers
  final _id = await studentDB.add(value);
  value.id = _id;
  final data = StudentModel(
      id: _id,
      name: value.name,
      standard: value.standard,
      place: value.place,
      age: value.age,
      profileImage: value.profileImage);
  await studentDB.put(_id, data);
  studentNotifier.value.add(data);
  // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
  studentNotifier.notifyListeners();
}

Future<void> getAllStudents() async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  studentNotifier.value.clear();
  studentNotifier.value.addAll(studentDB.values);
  // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
  studentNotifier.notifyListeners();
}

Future<void> deleteStudent(int id) async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  await studentDB.delete(id);
  getAllStudents();
}

Future<void> updateStudent(StudentModel data) async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');

  // ignore: no_leading_underscores_for_local_identifiers
  await studentDB.put(data.id, data);
  // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
  studentNotifier.notifyListeners();
  getAllStudents();
}
