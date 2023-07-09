import 'package:flutter/services.dart';

class CpfFormatter extends TextInputFormatter {
  static const int cpfLength = 11;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    String maskedText = '';
    String text = newValue.text;
    int selectionIndex = newValue.selection.end;

    // Remove all non-digit characters from the input text
    text = text.replaceAll(RegExp(r'[^0-9]'), '');

    // Apply the CPF mask
    if (text.length >= 4) {
      maskedText += text.substring(0, 3) + '.';
    }
    if (text.length >= 7) {
      maskedText += text.substring(3, 6) + '.';
    }
    if (text.length >= 10) {
      maskedText += text.substring(6, 9) + '-';
    }
    if (text.length >= 11) {
      maskedText += text.substring(9, 11);
    }

    maskedText += text.substring(11);

    selectionIndex += maskedText.length - text.length;

    return TextEditingValue(
      text: maskedText,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
