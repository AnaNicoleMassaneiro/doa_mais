import 'package:flutter/material.dart';

import '../../../shared/components/SubmitButton.dart';

class SubmitButtonWidget extends StatelessWidget {
  const SubmitButtonWidget({Key? key, required this.onPressed, required this.isLoading})
      : super(key: key);

  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: SubmitButton(
        onPressed: null,
        isLoading: isLoading,
      ),
    );
  }
}
