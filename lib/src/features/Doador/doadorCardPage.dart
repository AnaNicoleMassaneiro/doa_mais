import 'package:flutter/material.dart';
import '../menu/TabBarComponent.dart';

class DoadorCardScreen extends StatefulWidget {
  @override
  _DoadorCardScreenState createState() => _DoadorCardScreenState();
}

class _DoadorCardScreenState extends State<DoadorCardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('Cartão de doador'),
        backgroundColor: Color(0xFFE24646),
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(45.7353),
                color: Color(0xFFD64545), // red
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment(0, 1),
                    child: Text(
                      'Documento',
                      style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  // ... Rest of the Align widgets for text
                  Positioned(
                    left: 12,
                    right: 12,
                    bottom: 12,
                    child: Text(
                      'CARTEIRINHA DE DOADOR',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Center(

                    child: Text(
                      'Doador número 123123',
                      style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 30),
          Container(
            width: 200,
            height: 35,
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xFFD64545), // red
                width: 3.65882,
              ),
              borderRadius: BorderRadius.circular(10.5),
            ),
            child: Center(
              child: Text(
                'Fazer download',
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFFD64545), // red
                ),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: TabBarComponent(initialSelectedIndex: 1)
    );
  }
}
