import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:quizapp/model/quiz.dart';
import 'package:quizapp/model/testQ.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quizapp/utils/constants.dart';
import 'package:quizapp/utils/globalColor.dart';

class ScreenAllQuiz extends StatefulWidget {
  const ScreenAllQuiz({Key? key}) : super(key: key);

  @override
  State<ScreenAllQuiz> createState() => _ScreenAllQuizState();
}

class _ScreenAllQuizState extends State<ScreenAllQuiz> {
 

// Fonction pour récupérer les quizzes à partir du JSON
List<Quiz> parseQuizzes(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Quiz>((json) => Quiz.fromJson(json)).toList();
}


  Future <Quiz> getQuizById( String id) async {

  // URL pour récupérer les quiz
  Uri fetchUri = Uri.parse("${Constants.BaseUri}/onequiz/${id}");

  // En-têtes de la requête
  Map<String, String> headers = {
    "Content-Type": "application/json",
  };

  try {
    // Faire la requête HTTP GET
    final response = await http.get(fetchUri, headers: headers);

    if (response.statusCode == 200) {
      // Si la requête est réussie, désérialiser les données JSON en objets Dart
      Quiz data = json.decode(response.body);
       return data;
    } else {
      // Si la requête a échoué, afficher une boîte de dialogue d'erreur
      throw Exception('Failed to load quiz');
    }
  } catch (e) {
    // Gérer les exceptions et afficher une boîte de dialogue d'erreur
    print('Error during fetchQuiz: $e');
    throw Exception('Failed to load quiiiiz');
  }

  }


// Fonction pour récupérer tous les quizzes depuis le serveur
Future<List<TestQ>> fetchQuiz() async {
  List<TestQ> testquizs = [];

  // URL pour récupérer les quizzes
  Uri fetchUri = Uri.parse("${Constants.BaseUri}/testQuizByCandidat/661e2faf36e2c6c7a2422726");

  // En-têtes de la requête
  Map<String, String> headers = {
    "Content-Type": "application/json",
  };

  try {
    // Faire la requête HTTP GET
    final response = await http.get(fetchUri, headers: headers);

    if (response.statusCode == 200) {
      // Si la requête est réussie, désérialiser les données JSON en objets Dart
      List<dynamic> data = json.decode(response.body);
       for (var item in data) {
         Quiz q = getQuizById(item["idQuiz"]) as Quiz;
         testquizs.add(TestQ(id: item["_id"], idRecruter: item["idRecruter"] , idCandidat: item["idCandidat"],idQuiz: item["idQuiz"], quiz: q, date: item["date"], score: item["score"], status: item["status"] ));
        }
    } else {
      // Si la requête a échoué, afficher une boîte de dialogue d'erreur
      throw Exception('Failed to load test quizs');
    }
  } catch (e) {
    // Gérer les exceptions et afficher une boîte de dialogue d'erreur
    print('Error during fetchQuiz: $e');
    throw Exception('Failed to load test quiiiizs');
  }
  return testquizs;
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
      body: FutureBuilder<List<TestQ>>(
        future: fetchQuiz(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: SpinKitCubeGrid(color: JobColor.appcolor, size: 50.0));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<TestQ>? testq = snapshot.data;
            return ListView.builder(
              itemCount: testq!.length,
              itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              leading: Image.asset(
                'assets/lquiz.jpg',
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
              title: Text(testq[index].quiz.theme,style: TextStyle(color: JobColor.appcolor,fontWeight: FontWeight.bold) ),
              subtitle: Text('${testq[index].quiz.questions.length} questions'),
              trailing: ElevatedButton(
                onPressed: () {
                  Get.toNamed('/detailquiz',arguments: testq[index]);
                },
                 child: Text('continue',style: TextStyle(color: Colors.white)),
                 style:  ElevatedButton.styleFrom(
                 backgroundColor: JobColor.appcolor
                 ),              
               ),
            ),
          );
              },
            );
          }
        },
      ),
    );
  }
  

}
