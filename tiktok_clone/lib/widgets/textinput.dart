import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final Widget prefixIcon;
  final bool isObscure;
  const TextInput(
      {Key? key,
      required this.controller,
      required this.labelText,
      required this.prefixIcon,
      this.isObscure = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: controller,
        obscureText: isObscure,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          labelText: labelText,
          prefixIcon: prefixIcon,
          focusColor: Colors.white,
          labelStyle: const TextStyle(),
          fillColor: Colors.grey.shade800,
          filled: true,
        ),
      ),
    );
  }
}
