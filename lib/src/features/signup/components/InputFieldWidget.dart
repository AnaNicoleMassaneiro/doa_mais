import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../shared/components/InputField.dart';

class InputFieldWidget extends StatelessWidget {
  const InputFieldWidget({
    Key? key,
    required this.title,
    required this.controller,
    this.isRequired = false,
    this.isPassword = false,
    this.keyboardType,
    this.inputFormatters,
  }) : super(key: key);

  final String title;
  final TextEditingController controller;
  final bool isRequired;
  final bool isPassword;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return InputField(
      title: title,
      controller: controller,
      isRequired: isRequired,
      isPassword: isPassword,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
    );
  }
}
