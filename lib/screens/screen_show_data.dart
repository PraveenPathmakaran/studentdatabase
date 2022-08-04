import 'package:flutter/material.dart';
import 'package:student/db/model/data_model.dart';
import 'package:student/screens/screen_update.dart';
import 'dart:io';

// ignore: must_be_immutable
class ShowData extends StatelessWidget {
  int id;
  StudentModel listData;
  ShowData({Key? key, required this.id, required this.listData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) {
                    return ScreenUpdate(
                      id: id,
                      listData: listData,
                    );
                  },
                ),
              );
            },
            child: const Text(
              'EDIT',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: 100,
                      // ignore: unnecessary_null_comparison
                      backgroundImage: listData != null
                          ? FileImage(File(listData.profileImage.toString()))
                              as ImageProvider
                          : const AssetImage('images/student.png'),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    Row(
                      children: [
                        const Text(
                          'Name : ',
                          style: TextStyle(fontSize: 25),
                        ),
                        Text(
                          listData.name,
                          style: const TextStyle(fontSize: 25),
                        )
                      ],
                    ),
                    const Divider(),
                    Row(
                      children: [
                        const Text(
                          'Age  : ',
                          style: TextStyle(fontSize: 25),
                        ),
                        Text(
                          listData.age,
                          style: const TextStyle(fontSize: 25),
                        )
                      ],
                    ),
                    const Divider(),
                    Row(
                      children: [
                        const Text(
                          'Class  : ',
                          style: TextStyle(fontSize: 25),
                        ),
                        Text(
                          listData.standard,
                          style: const TextStyle(fontSize: 25),
                        )
                      ],
                    ),
                    const Divider(),
                    Row(
                      children: [
                        const Text(
                          'Place  : ',
                          style: TextStyle(fontSize: 25),
                        ),
                        Text(
                          listData.place,
                          style: const TextStyle(fontSize: 25),
                        )
                      ],
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
