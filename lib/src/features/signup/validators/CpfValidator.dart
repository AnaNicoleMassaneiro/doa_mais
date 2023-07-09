import 'package:flutter/services.dart';

class CpfValidator extends TextInputFormatter {
  final int maxLength;

  CpfValidator({this.maxLength = 11});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length > maxLength) {
      return oldValue;
    }
    return newValue;
  }
}
