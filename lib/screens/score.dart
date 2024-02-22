import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScoreQuiz extends StatefulWidget {
  const ScoreQuiz({super.key});

  @override
  State<ScoreQuiz> createState() => _ScoreQuizState();
}

class _ScoreQuizState extends State<ScoreQuiz> {
  @override
  Widget build(BuildContext context) {
    final int score = Get.arguments as int;


    return Container(
      child: Text("Score :${score}"),
    );
  }
}