import 'package:flutter/material.dart';

import '../../Widget/bezierContainer.dart';
import '../../shared/components/SubmitButton.dart';
import 'components/CreateAccountLabel.dart';
import 'components/EmailPasswordWidget.dart';
import 'components/SignUpTitle.dart';

class SignUpPage extends StatefulWidget {
    SignUpPage({Key? key, this.title}) : super(key: key);

    final String? title;

    @override
    _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
    TextEditingController nameController = TextEditingController();
    TextEditingController cpfController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();
    TextEditingController emailController = TextEditingController();

    bool isLoading = false;

    bool _validateFields() {
        bool isValid = true;

        if (nameController.text.isEmpty) {
            setState(() {
                isValid = false;
                nameController.clear();
            });
        }
        if (cpfController.text.isEmpty) {
            setState(() {
                isValid = false;
                cpfController.clear();
            });
        }
        if (emailController.text.isEmpty) {
            setState(() {
                isValid = false;
                emailController.clear();
            });
        }
        if (passwordController.text.isEmpty) {
            setState(() {
                isValid = false;
                passwordController.clear();
            });
        }
        if (confirmPasswordController.text.isEmpty) {
            setState(() {
                isValid = false;
                confirmPasswordController.clear();
            });
        }

        return isValid;
    }

    void _submitForm() {
        setState(() {
            isLoading = true;
        });

        if (!_validateFields()) {
            setState(() {
                isLoading = false;
            });
            return;
        }

        final String name = nameController.text;
        final String cpf = cpfController.text;
        final String email = emailController.text;
        final String password = passwordController.text;
        final String confirmPassword = confirmPasswordController.text;

        if (password != confirmPassword) {
            setState(() {
                isLoading = false;
            });

            // Show error dialog
            showDialog(
                context: context,
                builder: (BuildContext context) {
                    return AlertDialog(
                        title: Text('Erro'),
                        content: Text('As senhas não coincidem.'),
                        actions: [
                            TextButton(
                                onPressed: () {
                                    Navigator.of(context).pop();
                                },
                                child: Text('OK'),
                            ),
                        ],
                    );
                },
            );

            confirmPasswordController.clear();
            return;
        }

        showDialog(
            context: context,
            builder: (BuildContext context) {
                return AlertDialog(
                    title: Text('Success'),
                    content: Text('Doador registado com sucesso.'),
                    actions: [
                        TextButton(
                            onPressed: () {
                                Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                        ),
                    ],
                );
            },
        );

        setState(() {
            isLoading = false;
        });
    }

    @override
    Widget build(BuildContext context) {
        final height = MediaQuery.of(context).size.height;
        return Scaffold(
            body: Container(
                height: height,
                child: Stack(
                    children: <Widget>[
                        Positioned(
                            top: -height * .15,
                            right: -MediaQuery.of(context).size.width * .4,
                            child: BezierContainer(),
                        ),
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: SingleChildScrollView(
                                child: Column(
                                    children: <Widget>[
                                        SizedBox(height: height * .2),
                                        SignUpTitle(),
                                        SizedBox(height: 50),
                                        EmailPasswordWidget(
                                            nameController: nameController,
                                            cpfController: cpfController,
                                            emailController: emailController,
                                            passwordController: passwordController,
                                            confirmPasswordController: confirmPasswordController,
                                        ),
                                        SizedBox(height: 20),
                                        SubmitButton(
                                            onPressed: _submitForm,
                                            isLoading: isLoading,
                                        ),
                                        Container(
                                            padding: EdgeInsets.symmetric(vertical: 10),
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                                'Esqueceu sua senha?',
                                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                                            ),
                                        ),
                                        SizedBox(height: height * .055),
                                        CreateAccountLabel(),
                                    ],
                                ),
                            ),
                        ),
                        Positioned(top: 40, left: 0, child: BackButton()),
                    ],
                ),
            ),
        );
    }
}
