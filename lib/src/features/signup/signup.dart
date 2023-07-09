import 'package:doa_mais/src/features/signup/validators/CpfValidator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../Widget/bezierContainer.dart';
import '../../shared/components/CustomDialog.dart';
import '../../shared/components/InputField.dart';
import '../../shared/components/SubmitButton.dart';
import '../login/loginPage.dart';
import '../../service/users.dart';

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
    return GestureDetector(
      onTap: isLoading ? null : _submitForm,
      child: SubmitButton(
        onPressed: null,
        isLoading: isLoading,
      ),
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

  bool _validateFields() {
    bool isValid = true;

    // Verifique cada campo obrigatório e destaque os campos não preenchidos
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
        ),
      ),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        InputField(
          title: 'Nome',
          controller: nameController,
          isRequired: true,
        ),
        InputField(
          title: 'CPF',
          controller: cpfController,
          keyboardType: TextInputType.number,
          inputFormatters: [
            CpfValidator(maxLength: 9),
          ],
          isRequired: true,
        ),
        InputField(
          title: 'Email',
          controller: emailController,
          isRequired: true,
        ),
        InputField(
          title: 'Senha',
          controller: passwordController,
          isPassword: true,
          isRequired: true,
        ),
        InputField(
          title: 'Confirmação de Senha',
          controller: confirmPasswordController,
          isPassword: true,
          isRequired: true,
        ),
      ],
    );
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text('or'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignUpPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Cadastre-se aqui',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Cadastro',
              style: TextStyle(
                  color: Color(0xffe24646),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
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
                top: -height * .15,
                right: -MediaQuery.of(context).size.width * .4,
                child: BezierContainer()),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: height * .2),
                    _title(),
                    SizedBox(height: 50),
                    _emailPasswordWidget(),
                    SizedBox(height: 20),
                    _submitButton(),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      alignment: Alignment.centerRight,
                      child: Text('Esqueceu a senha?',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500)),
                    ),
                    _divider(),
                    SizedBox(height: height * .055),
                    _createAccountLabel(),
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
