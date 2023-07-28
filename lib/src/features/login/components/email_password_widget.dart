import 'package:doa_mais/src/features/signup/components/CpfInputFormatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../shared/components/InputField.dart';

class EmailPasswordWidget extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  EmailPasswordWidget({
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  final TextEditingController nameController = TextEditingController(); // Add this line
  final TextEditingController cpfController = TextEditingController(); // Add this line

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        InputField(
          title: 'Nome',
          controller: nameController,
          isRequired: true,
        ),
        SizedBox(height: 10),
        InputField(
          title: 'CPF',
          controller: cpfController,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(11),
            CpfInputFormatter(),
          ],
          isRequired: true,
        ),
        SizedBox(height: 10),
        InputField(
          title: 'Email',
          controller: emailController,
          isRequired: true,
        ),
        SizedBox(height: 10),
        InputField(
          title: 'Senha',
          controller: passwordController,
          isPassword: true,
          isRequired: true,
        ),
        SizedBox(height: 10),
        InputField(
          title: 'Confirmação de Senha',
          controller: confirmPasswordController,
          isPassword: true,
          isRequired: true,
        ),
      ],
    );
  }
}
