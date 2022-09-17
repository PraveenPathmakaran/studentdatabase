import 'package:hive/hive.dart';
part 'data_model.g.dart';

@HiveType(typeId: 1)
class StudentModel {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String age;
  @HiveField(2)
  final String standard;
  @HiveField(3)
  final String place;
  @HiveField(4)
  final String? profileImage;
  @HiveField(5)
  int? id;

  StudentModel(
      {required this.name,
      required this.age,
      required this.standard,
      required this.place,
      this.profileImage,
      this.id});
}
