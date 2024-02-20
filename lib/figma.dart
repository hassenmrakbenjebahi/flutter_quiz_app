import 'package:flutter/material.dart';
import 'dart:async';

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
  int _score = 0;
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
  List<int> _answers = [0, 1, 2]; // Index des réponses correctes pour chaque question
  bool _isTimeUp = false;
  int _remainingTimeInSeconds = 600; // 10 minutes
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTimeInSeconds > 0) {
          _remainingTimeInSeconds--;
        } else {
          _isTimeUp = true;
          _timer.cancel(); // Arrêter le chronomètre une fois le temps écoulé
        }
      });
    });
  }

  void _nextQuestion() {
    setState(() {
      if (_questionIndex < _questions.length - 1) {
        _questionIndex++;
      } else {
        _isTimeUp = true; // Si toutes les questions ont été répondues, le temps est écoulé
        _timer.cancel(); // Arrêter le chronomètre
      }
    });
  }

  void _answerQuestion(int selectedOption) {
    if (!_isTimeUp) {
      if (selectedOption == _answers[_questionIndex]) {
        // Si la réponse est correcte, augmentez le score
        _score++;
      }
      _nextQuestion(); // Passer à la question suivante
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              _questions.length,
              (index) => Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _questionIndex == index ? Colors.blue : Colors.grey,
                ),
                child: Center(
                  child: Text(
                    (index + 1).toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: Center(
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
                                onPressed: () => _answerQuestion(_options[_questionIndex].indexOf(option)),
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
                  SizedBox(height: 20.0),
                  Text(
                    'Temps restant : ${(_remainingTimeInSeconds ~/ 60).toString().padLeft(2, '0')}:${(_remainingTimeInSeconds % 60).toString().padLeft(2, '0')}',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  if (_isTimeUp)
                      Column(
                     children: [
                     Text(
                      'Le temps est écoulé!',
                      style: TextStyle(fontSize: 18.0, color: Colors.red),
                     ),
                     Text(
                     'Votre score : $_score / ${_questions.length}',
                      style: TextStyle(fontSize: 18.0),
                     ),
                   ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel(); // Arrêter le chronomètre lors de la suppression du widget
    super.dispose();
  }
}
