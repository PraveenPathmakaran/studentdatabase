import 'package:flutter/material.dart';
import 'package:student/core/color.dart';

class TextFormWidget extends StatelessWidget {
  const TextFormWidget({
    Key? key,
    required this.textController,
    required this.hintText,
  }) : super(key: key);

  final TextEditingController textController;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: kwhite),
      cursorColor: kwhite,
      controller: textController,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kGrey),
            borderRadius: BorderRadius.circular(25.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kwhite),
            borderRadius: BorderRadius.circular(25.0),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          hintText: hintText,
          hintStyle: const TextStyle(color: kGrey)),
    );
  }
}
