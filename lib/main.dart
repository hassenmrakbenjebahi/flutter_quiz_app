import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/screens/DetailQuizScreen.dart';
import 'package:quizapp/screens/quiz.dart';
import 'package:quizapp/screens/score.dart';
import 'package:quizapp/screens/DetailQuizScreen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
       initialRoute: '/detailquiz', 
      getPages: [
        GetPage(name: '/quiz', page: () => QuizApp()), 
        GetPage(name: '/score', page: () => ScoreQuiz()), 
        GetPage(name: '/detailquiz', page:()=> DetailQuizScreen()),
      ],
    );
  }
}