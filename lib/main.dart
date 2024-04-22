import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/screens/quiz.dart';
import 'package:quizapp/screens/screenQuizs.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
       initialRoute: '/allquizbycandidat', 
      getPages: [
        GetPage(name: '/quiz', page: () => QuizApp()), 
        GetPage(name: '/allquizbycandidat', page:()=> ScreenQuiz()),



      ],
    );
  }
}