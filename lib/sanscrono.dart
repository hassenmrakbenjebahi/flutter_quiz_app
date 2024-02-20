import 'package:flutter/material.dart';

void main() {
  runApp(QuizApp());
}

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: QuizScreen(),
    );
  }
}

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _questionIndex = 0;
  List<String> _questions = [
    'Quelle est la capitale de la France ?',
    'Quel est le plus grand océan du monde ?',
    'Combien de planètes composent notre système solaire ?'
  ];
  List<List<String>> _options = [
    ['Paris', 'Londres', 'Berlin', 'Rome'],
    ['Atlantique', 'Pacifique', 'Indien', 'Arctique'],
    ['5', '7', '8', '9']
  ];

  void _nextQuestion() {
    setState(() {
      _questionIndex = (_questionIndex + 1) % _questions.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _questions[_questionIndex],
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 20.0),
            Column(
              children: _options[_questionIndex]
                  .map((option) => Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.0),
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text(option),
                        ),
                      ))
                  .toList(),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _nextQuestion,
              child: Text('Suivant'),
            ),
          ],
        ),
      ),
    );
  }
}
