  // lib/screens/materias_screen.dart
import 'package:flutter/material.dart';
import 'package:tese2k/main.dart';
import 'package:tese2k/pages/materia.dart';

  // lib/screens/materias_screen.dart
  // lib/screens/materias_screen.dart

  class MateriasScreen extends StatelessWidget {
    final List<String> materias = [
      'Matemática',
      'História',
      'Geografia',
      'Ciências',
      'Português',
      'Inglês',
    ];

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent, // Cor azul na barra superior
          title: Text('Matérias'),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()),
                );
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: materias.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Card(
                  elevation: 4,
                  child: InkWell(
                    onTap: () {
                      // Função ao clicar em cada matéria
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Icon(Icons.book, size: 48, color: Colors.blueAccent),
                          SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              materias[index],
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );
    }
  }
