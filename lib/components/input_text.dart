import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final IconData icon;

  InputText(this.controller, this.labelText, this.hintText, {this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            icon: this.icon != null ? Icon(this.icon) : null,
            labelText: labelText,
            hintText: hintText),
        keyboardType: TextInputType.number,
      ),
    );
  }
}
