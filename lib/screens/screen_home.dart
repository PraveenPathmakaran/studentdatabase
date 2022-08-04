import 'package:flutter/material.dart';
import 'package:student/db/functions/db_functions.dart';
import 'package:student/screens/add_student_data.dart';
import 'package:student/screens/screen_data.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  //BottomNavigationbar
  int currentSelectedIndex = 0;
  final pages = [const ScreenAddStudentData(), const ScreenStudentDetails()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentSelectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.data_array), label: 'Details'),
        ],
        currentIndex: currentSelectedIndex,
        onTap: (index) {
          if (index == 1) {
            getAllStudents();
          }
          setState(() {
            currentSelectedIndex = index;
          });
        },
      ),
    );
  }
}
