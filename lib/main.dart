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

  List<int> _selectedAnswers = []; // Stocke les réponses sélectionnées par l'utilisateur

  @override
  void initState() {
    super.initState();
      _selectedAnswers = List<int>.filled(_questions.length, -1); // Ajoutez cette ligne

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

  void _previousQuestion() {
    setState(() {
      if (_questionIndex > 0) {
        _questionIndex--;
      }
    });
  }
void _answerQuestion(int selectedOption) {
  if (!_isTimeUp) {
    setState(() {
      // Vérifier si la réponse précédemment sélectionnée était correcte
      bool previousAnswerWasCorrect = _selectedAnswers[_questionIndex] == _answers[_questionIndex];

      // Enregistrer la nouvelle réponse sélectionnée
      _selectedAnswers[_questionIndex] = selectedOption;

      // Vérifier si la nouvelle réponse est correcte
      bool newAnswerIsCorrect = _selectedAnswers[_questionIndex] == _answers[_questionIndex];

      // Si l'utilisateur passe d'une réponse correcte à une réponse incorrecte,
      // décrémentez le score
      if (previousAnswerWasCorrect && !newAnswerIsCorrect) {
        _score--;
      }
      // Sinon, si l'utilisateur passe d'une réponse incorrecte à une réponse correcte,
      // incrémente le score
      else if (!previousAnswerWasCorrect && newAnswerIsCorrect) {
        _score++;
      }
    });
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Action du bouton
                },
                child: Text(
                  '${(_remainingTimeInSeconds ~/ 60).toString().padLeft(2, '0')}:${(_remainingTimeInSeconds % 60).toString().padLeft(2, '0')}'
                ),
              ),
              SizedBox(width: 20),
            ],
          ),
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
          SizedBox(height: 10),
          Center(
            child: Column(
              children: [
                Text(
                  _questions[_questionIndex],
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(height: 20.0),
                Column(
                  children: _options[_questionIndex]
                      .asMap()
                      .entries
                      .map(
                        (entry) => Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.0),
                          child: RadioListTile<int>(
                            title: Text(entry.value),
                            value: entry.key,
                            groupValue: _selectedAnswers[_questionIndex],
                            onChanged: _isTimeUp ? null : (value) => _answerQuestion(value!),
                          ),
                        ),
                      )
                      .toList(),
                ),
                SizedBox(height: 10.0),                  
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
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: _previousQuestion,
                child: Text('Précédent'),
              ),
              ElevatedButton(
                onPressed: _nextQuestion,
                child: Text('Suivant'),
              ),
            ],
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
