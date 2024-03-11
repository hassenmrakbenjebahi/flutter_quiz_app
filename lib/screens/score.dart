import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/utils/globalColor.dart';

class ScoreQuiz extends StatefulWidget {
  const ScoreQuiz({super.key});

  @override
  State<ScoreQuiz> createState() => _ScoreQuizState();
}

class _ScoreQuizState extends State<ScoreQuiz> {

  
  @override
  Widget build(BuildContext context) {
    final int score = Get.arguments as int;

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(width: 1000),
          const Text(
            'Your Score: ',
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.w500,
              color: JobColor.appcolor,
            ),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 250,
                width: 250,
                child: CircularProgressIndicator(
                  strokeWidth: 10,
                  value: score / 10,
                  color: JobColor.appcolor,
                  backgroundColor: Color.fromARGB(255, 116, 114, 114),
                ),
              ),
              Column(
                children: [
                  Text(
                    score.toString(),
                    style: const TextStyle(fontSize: 80),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${(score / 10 * 100).round()}%',
                    style: const TextStyle(fontSize: 25),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
    
  }
}