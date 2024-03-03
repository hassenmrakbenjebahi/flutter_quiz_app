import 'package:flutter/material.dart';
import 'package:quizapp/model/question.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:quizapp/model/quiz.dart';
class ScreenAllQuiz extends StatefulWidget {
  const ScreenAllQuiz({Key? key}) : super(key: key);

  @override
  State<ScreenAllQuiz> createState() => _ScreenAllQuizState();
}

class _ScreenAllQuizState extends State<ScreenAllQuiz> {
  // Exemple de données pour la liste de quiz
  final List<Map<String, dynamic>> quizData = [
    {
      'title': 'Quiz 1',
      'image': 'assets/quiz.png',
    },
    {
      'title': 'Quiz 2',
      'image': 'assets/quiz.png',
    },
    {
      'title': 'Quiz 3',
      'image': 'assets/quiz.png',
    },
  ];


// Fonction pour récupérer les quizzes à partir du JSON
List<Quiz> parseQuizzes(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Quiz>((json) => Quiz.fromJson(json)).toList();
}



// Fonction pour récupérer tous les quizzes depuis le serveur
Future<List<Quiz>> fetchQuiz() async {
  // URL pour récupérer les quizzes
  Uri fetchUri = Uri.parse("http://192.168.1.183:5000/all_quiz");

  // En-têtes de la requête
  Map<String, String> headers = {
    "Content-Type": "application/json",
  };

  try {
    // Faire la requête HTTP GET
    final response = await http.get(fetchUri, headers: headers);

    if (response.statusCode == 200) {
      // Si la requête est réussie, désérialiser les données JSON en objets Dart
      List<Quiz> quizzes = parseQuizzes(response.body);
      return quizzes;
    } else {
      // Si la requête a échoué, afficher une boîte de dialogue d'erreur
      throw Exception('Failed to load quizzes');
    }
  } catch (e) {
    // Gérer les exceptions et afficher une boîte de dialogue d'erreur
    print('Error during fetchQuiz: $e');
    throw Exception('Failed to load quizzes');
  }
}    



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [  
            Image.asset(
              'assets/logo.png',
              width: 40,
              height: 40,
            ),
            SizedBox(width: 10),      
            Text(
              'My Job Applications',
              style: TextStyle(
                  fontSize: 20, fontFamily: AutofillHints.creditCardNumber),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: quizData.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: Image.asset(
                'assets/lquiz.jpg',
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
              title: Text(quizData[index]['title']),
              subtitle: Text('Description du quiz'),
              trailing: ElevatedButton(
                onPressed: () {
                  // Action à effectuer lors de l'appui sur le bouton
                  // Par exemple, naviguer vers une autre page
                },
                child: Text('Commencer'),
              ),
            ),
          );
        },
      ),
    );
  }
}
