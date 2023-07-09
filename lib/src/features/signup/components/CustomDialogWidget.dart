import 'package:flutter/material.dart';
import '../../../shared/components/CustomDialog.dart';

class CustomDialogWidget extends StatelessWidget {
  const CustomDialogWidget({
    Key? key,
    required this.success,
    required this.onPressed,
  }) : super(key: key);

  final bool success;
  final VoidCallback onPressed;

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialog(
          title: success ? 'Sucesso' : 'Erro',
          content: success ? 'Usuário registrado com sucesso.' : 'Erro ao registrar usuário.',
          onPressed: onPressed,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Return an empty container, as this widget doesn't render anything
    return Container();
  }
}
