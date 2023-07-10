import 'package:flutter/material.dart';

import '../../scheduling/schedulingPage.dart';

class ButtonPrimary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343,
      height: null,
      decoration: BoxDecoration(
        color: Color(0xFFD54444),
        borderRadius: BorderRadius.circular(100),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SchedulingPage(),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 16),
            Text(
              'Agendar doação',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                fontFamily: 'Inter',
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
