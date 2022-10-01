import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student/core/color.dart';
import 'package:student/view/show_data/screen_show_data.dart';
import '../../controller/add_student/add_student_controller.dart';
import '../../controller/data_screen/data_screen_controller.dart';
import '../../controller/search_screen/search_screen_controller.dart';
import '../../model/data_model.dart';

class NameSearch extends SearchDelegate<StudentModel> {
  DataScreenController dataScreenController = Get.put(DataScreenController());
  SearchScreenController searchScreenController =
      Get.put(SearchScreenController());

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // ignore: todo
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    searchScreenController.suggestionList = dataScreenController
        .studentModelList
        .where((p) => p.name.toLowerCase().contains(query.toLowerCase()))
        .toList()
        .obs;
    return Obx(
      () {
        return Container(
          color: kbackground,
          child: ListView.separated(
            itemCount: searchScreenController.suggestionList.length,
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(height: 3, color: Colors.white),
            itemBuilder: (BuildContext context, int index) {
              final listData = searchScreenController.suggestionList[index];
              return ListTile(
                onTap: () {
                  Get.off(ScreenShowData(
                    id: listData.id!,
                  ));
                },
                leading: CircleAvatar(
                  backgroundImage:
                      FileImage(File(listData.profileImage.toString())),
                ),
                title: Text(
                  listData.name,
                  style: const TextStyle(color: kwhite),
                ),
                subtitle:
                    Text(listData.age, style: const TextStyle(color: kwhite)),
                trailing: IconButton(
                  onPressed: () {
                    if (listData.id != null) {
                      dataScreenController.deleteStudent(listData.id!);
                      searchScreenController.suggestionList.removeAt(index);

                      Get.find<AddStudentController>().homeSnackBar(
                          content: "Successfully Deleted",
                          title: 'Successful',
                          color: Colors.green);
                    } else {
                      // ignore: avoid_print
                      print("Student id is null");
                    }
                  },
                  icon: const Icon(Icons.delete),
                  color: Colors.red,
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        color: kbackground, // affects AppBar's background color
        titleTextStyle: TextStyle(color: kwhite),
      ),
      textTheme: const TextTheme(headline6: TextStyle(color: Colors.white)),
      textSelectionTheme:
          const TextSelectionThemeData(cursorColor: Colors.white),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: kGrey),
        labelStyle: TextStyle(color: Colors.white),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent)),
      ),
    );
  }
}
