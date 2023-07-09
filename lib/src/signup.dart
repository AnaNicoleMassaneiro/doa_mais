import 'package:doa_mais/src/service/users.dart';
import 'package:flutter/material.dart';

import 'Widget/bezierContainer.dart';
import 'components/CustomDialog.dart';
import 'components/InputField.dart';
import 'components/SubmitButton.dart';
import 'loginPage.dart';

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
  final UserRepository userRepository = UserRepository();

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Voltar',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  Widget _submitButton() {
    return SubmitButton(
      onPressed: isLoading ? null : _submitForm,
      isLoading: isLoading,
    );
  }

  void _showDialog(bool success) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialog(
          title: success ? 'Sucesso' : 'Erro',
          content: success ? 'Usuário registrado com sucesso.' : 'Erro ao registrar usuário.',
          onPressed: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  void _submitForm() {
    setState(() {
      isLoading = true;
    });

    final String name = nameController.text;
    final String cpf = cpfController.text;
    final String email = emailController.text;
    final String password = passwordController.text;
    final String confirmPassword = confirmPasswordController.text;

    if (password != confirmPassword) {
      setState(() {
        isLoading = false;
      });

      _showDialog(false);

      confirmPasswordController.clear();
      return;
    }

    userRepository.registerUser(name, cpf, password, email).then((result) {
      setState(() {
        isLoading = false;
      });

      _showDialog(result);
    });
  }

  Widget _loginAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Já tem uma conta ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Entrar',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: const TextSpan(
        text: 'DOA+',
        style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Color(0xffe24646)
        ),),
    );
  }


  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        InputField(
          title: 'Nome',
          controller: nameController,
        ),
        InputField(
          title: 'CPF',
          controller: cpfController,
        ),
        InputField(
          title: 'Email',
          controller: emailController,
        ),
        InputField(
          title: 'Senha',
          controller: passwordController,
          isPassword: true,
        ),
        InputField(
          title: 'Confirmação de Senha',
          controller: confirmPasswordController,
          isPassword: true,
        ),
      ],
    );
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
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer(),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .2),
                    _title(),
                    SizedBox(
                      height: 50,
                    ),
                    _emailPasswordWidget(),
                    SizedBox(
                      height: 20,
                    ),
                    _submitButton(),
                    SizedBox(height: height * .14),
                    _loginAccountLabel(),
                  ],
                ),
              ),
            ),
            Positioned(top: 40, left: 0, child: _backButton()),
          ],
        ),
      ),
    );
  }
}
