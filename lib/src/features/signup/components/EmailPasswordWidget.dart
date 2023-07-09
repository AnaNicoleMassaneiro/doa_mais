import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../shared/components/InputField.dart';
import '../validators/CpfValidator.dart';

class EmailPasswordWidget extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController cpfController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  const EmailPasswordWidget({
    required this.nameController,
    required this.cpfController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        InputField(
          title: 'Nome',
          controller: nameController,
          isRequired: true,
        ),
        SizedBox(height: 10), // Espaçamento entre o primeiro e o segundo InputField
        InputField(
          title: 'CPF',
          controller: cpfController,
          keyboardType: TextInputType.number,
          inputFormatters: [
            CpfValidator(maxLength: 11),
          ],
          isRequired: true,
        ),
        SizedBox(height: 10), // Espaçamento entre o segundo e o terceiro InputField
        InputField(
          title: 'Email',
          controller: emailController,
          isRequired: true,
        ),
        SizedBox(height: 10), // Espaçamento entre o terceiro e o quarto InputField
        InputField(
          title: 'Senha',
          controller: passwordController,
          isPassword: true,
          isRequired: true,
        ),
        SizedBox(height: 10), // Espaçamento entre o quarto e o quinto InputField
        InputField(
          title: 'Confirmação de Senha',
          controller: confirmPasswordController,
          isPassword: true,
          isRequired: true,
        ),
      ],
    );
}

  @override
  Widget build(BuildContext context) {
    // Return an empty container, as this widget doesn't render anything
    return _emailPasswordWidget();
  }
}
