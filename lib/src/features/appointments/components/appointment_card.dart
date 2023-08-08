import 'package:flutter/material.dart';

class AppointmentCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16),
      child: Container(
        width: 335,
        height: 151,
        child: Padding( // Add Padding widget
          padding: EdgeInsets.all(12), // Add 12px padding to all sides
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 24,
                height: 24,
                // Add any content or decoration for the left container
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.0828,
                height: MediaQuery.of(context).size.height * 0.13,
                margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.084,
                  right: MediaQuery.of(context).size.width * 0.084,
                ),
                color: Color(0xFFD64545),
                // Add any content or decoration for the middle container
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 275,
                      height: 19,
                      margin: EdgeInsets.only(bottom: 14),
                      child: Text(
                        'Doação de 01 de março',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      width: 268,
                      height: 30,
                      child: Text(
                        'Hemobanco R. Cap. Souza Franco, 290 - Bigorrilho, Curitiba',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      width: 268,
                      height: 44,
                      margin: EdgeInsets.only(top: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 1, color: Color(0xFFD64545)),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Center(
                        child: Text(
                          'Ver Exames!',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
