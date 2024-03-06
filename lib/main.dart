import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/screens/DetailQuizScreen.dart';
import 'package:quizapp/screens/quiz.dart';
import 'package:quizapp/screens/score.dart';
import 'package:quizapp/screens/DetailQuizScreen.dart';
import 'package:quizapp/screens/screen_all_quiz.dart';
import 'package:quizapp/screens/screen_generate_quiz.dart';
import 'package:quizapp/screens/screen_result_generate.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
       initialRoute: '/allquiz', 
      getPages: [
        GetPage(name: '/quiz', page: () => QuizApp()), 
        GetPage(name: '/score', page: () => ScoreQuiz()), 
        GetPage(name: '/detailquiz', page:()=> DetailQuizScreen()),
        GetPage(name: '/generate_quiz', page:()=> ScreenGenerateQuiz()),
        GetPage(name: '/result_generate', page:()=> ScreenResultGenerate()),
        GetPage(name: '/allquiz', page:()=> ScreenAllQuiz()),


      ],
    );
  }
}