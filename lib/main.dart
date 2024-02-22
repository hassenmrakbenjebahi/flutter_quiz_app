import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/screens/quiz.dart';
import 'package:quizapp/screens/score.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
       initialRoute: '/quiz', 
      getPages: [
        GetPage(name: '/quiz', page: () => QuizApp()), 
        GetPage(name: '/score', page: () => ScoreQuiz()), 


      ],
    );
  }
}