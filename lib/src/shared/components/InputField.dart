import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputField extends StatefulWidget {
  final String title;
  final TextEditingController controller;
  final bool isPassword;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool isRequired;

  const InputField({
    required this.title,
    required this.controller,
    this.isPassword = false,
    this.keyboardType,
    this.inputFormatters,
    this.isRequired = false,
  });

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool _hasError = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(height: 10),
          Theme(
            data: Theme.of(context).copyWith(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
              hintColor: Colors.transparent,
              errorColor: Colors.red, // Cor do erro
            ),
            child: TextField(
              controller: widget.controller,
              obscureText: widget.isPassword,
              keyboardType: widget.keyboardType,
              inputFormatters: [
                ...?widget.inputFormatters,
              ],
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.transparent, // Cor da borda
                    width: 0, // Largura da borda
                  ),
                ),
                filled: true,
                fillColor: _hasError ? Colors.red.withOpacity(0.2) : Color(0xfff3f3f4),
              ),
              onTap: () {
                if (widget.title == 'CPF') {
                  FocusScope.of(context).requestFocus(FocusNode());
                  _showNumericKeyboard();
                }
              },
              onChanged: (_) {
                setState(() {
                  _hasError = false;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showNumericKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.show');
  }
}
