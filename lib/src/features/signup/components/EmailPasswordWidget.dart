import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../shared/components/InputField.dart';
import '../validators/CpfValidator.dart';
import 'CpfInputFormatter.dart';

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


  @override
  Widget build(BuildContext context) {
    // Return an empty container, as this widget doesn't render anything
    return _emailPasswordWidget();
  }
}
