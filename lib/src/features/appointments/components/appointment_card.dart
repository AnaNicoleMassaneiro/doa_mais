import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io' as io;
import 'package:url_launcher/url_launcher.dart';

import '../../menu/TabBarComponent.dart';

class AppointmentCard extends StatefulWidget {
  @override
  _AppointmentCardState createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard> {
  List<Map<String, dynamic>> appointmentDataList = [];
  bool isLoading = true;

  Future<void> fetchAppointmentData() async {
    int? userId = await _getUserId();

    final response = await http.get(
      Uri.parse('http://localhost:8080/appointments/user/$userId'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      setState(() {
        appointmentDataList = responseData.cast<Map<String, dynamic>>();
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load appointment data');
    }
  }

  void downloadAndOpenPdf(int appId) async {
    String pdfUrl = 'http://localhost:8080/appointments/$appId/download-pdf'; // Substitua pela URL real do seu PDF

    if (await canLaunch(pdfUrl)) {
      await launch(pdfUrl);
    } else {
      throw 'Could not launch $pdfUrl';
    }
  }

  @override
  void initState() {
    super.initState();
    fetchAppointmentData();
  }

  Future<int?> _getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('userId');
    return userId;
  }

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
        title: Text('Exames'),
        backgroundColor: Color(0xFFE24646),
      ),
      body: Card(
        margin: EdgeInsets.all(16),
        child: isLoading
            ? CircularProgressIndicator()
            : appointmentDataList.isEmpty
                ? Center(
                    child: Text('Não há agendamentos para este usuário.'),
                  )
                : Container(
                    width: 335,
                    height: 151,
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            // Adicione qualquer conteúdo ou decoração para o contêiner à esquerda
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.0828,
                            height: MediaQuery.of(context).size.height * 0.13,
                            margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.084,
                              right: MediaQuery.of(context).size.width * 0.084,
                            ),
                            color: Color(0xFFD64545),
                            // Adicione qualquer conteúdo ou decoração para o contêiner do meio
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
                                    'Doação de ${appointmentDataList[0]['date']}',
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
                                    'Hemobanco ${appointmentDataList[0]['hemobanco']['address']}, ${appointmentDataList[0]['hemobanco']['city']}',
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
                                    border: Border.all(
                                      width: 1,
                                      color: Color(0xFFD64545),
                                    ),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: ElevatedButton( // Use ElevatedButton para criar um botão elevado
                                    onPressed: () {
                                      downloadAndOpenPdf(appointmentDataList[0]['id']);
                                    },
                                    child: Text(
                                      'Baixar Exames!',
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                )

                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
      ),
      bottomNavigationBar: TabBarComponent(initialSelectedIndex: 2),
    );
  }
}
