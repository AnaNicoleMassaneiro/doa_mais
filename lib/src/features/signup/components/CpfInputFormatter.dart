import 'package:flutter/services.dart';

class CpfInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length > 3 && newValue.text.length < 7) {
      final String maskedText =
          "${newValue.text.substring(0, 3)}.${newValue.text.substring(3)}";
      return TextEditingValue(
        text: maskedText,
        selection: TextSelection.collapsed(offset: maskedText.length),
      );
    } else if (newValue.text.length > 6 && newValue.text.length < 10) {
      final String maskedText =
          "${newValue.text.substring(0, 3)}.${newValue.text.substring(3, 6)}.${newValue.text.substring(6)}";
      return TextEditingValue(
        text: maskedText,
        selection: TextSelection.collapsed(offset: maskedText.length),
      );
    } else if (newValue.text.length >= 10) {
      final String maskedText =
          "${newValue.text.substring(0, 3)}.${newValue.text.substring(3, 6)}.${newValue.text.substring(6, 9)}-${newValue.text.substring(9)}";
      return TextEditingValue(
        text: maskedText,
        selection: TextSelection.collapsed(offset: maskedText.length),
      );
    }
    return newValue;
  }
}
