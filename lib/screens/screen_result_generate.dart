import 'package:flutter/material.dart';
import 'package:quizapp/model/question.dart';

class ScreenResultGenerate extends StatefulWidget {
  const ScreenResultGenerate({Key? key}) : super(key: key);

  @override
  State<ScreenResultGenerate> createState() => _ScreenResultGenerateState();
}

class _ScreenResultGenerateState extends State<ScreenResultGenerate> {
  List<Question> questions = [
    Question(
      question: "What is the capital of France?",
      options: ["Paris", "London", "Berlin", "Rome"],
    ),
    Question(
      question: "What is 2 + 2?",
      options: ["3", "4", "5", "6"],
    ),
    Question(
      question: "What is the capital of France?",
      options: ["Paris", "London", "Berlin", "Rome"],
    ),
    Question(
      question: "What is 2 + 2?",
      options: ["3", "4", "5", "6"],
    ),
    Question(
      question: "What is 2 + 2?",
      options: ["3", "4", "5", "6"],
    ),
    Question(
      question: "What is the capital of France?",
      options: ["Paris", "London", "Berlin", "Rome"],
    ),
    Question(
      question: "What is 2 + 2?",
      options: ["3", "4", "5", "6"],
    )
  ];

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
              style: TextStyle(fontSize: 20, fontFamily: 'Roboto'),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: questions
              .asMap()
              .entries
              .map(
                (entry) => Card(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          "Question ${entry.key + 1}: ${entry.value.question}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: entry.value.options.length,
                        itemBuilder: (context, optionIndex) {
                          String option = entry.value.options[optionIndex];
                          return ListTile(
                            title: Text(option),
                            onTap: () {
                              // Logique à exécuter lorsque l'option est sélectionnée
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
