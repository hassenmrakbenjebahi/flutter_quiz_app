 import 'package:flutter/material.dart';
import 'dart:async';
import 'package:get/get.dart';
import 'package:quizapp/model/quiz.dart';

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
    


  Quiz quiz = Get.arguments as Quiz;
  int _questionIndex = 0;
  int _score = 0;
  List<int> _answers = [];
  List<String> _questions = [];
  List<List<String>> _options = [];
  void gereQuiz(){
    
    for(var item in quiz.questions){
       _questions.add(item.question);
       _answers.add(item.correct);
       _options.add(item.options);

    }

  }



  bool _isTimeUp = false;

  int _remainingTimeInSeconds = 300; // 10 minutes
  late Timer _timer;

  List<int> _selectedAnswers = []; // Stocke les réponses sélectionnées par l'utilisateur
  
  @override
  void initState() {
    super.initState();
        gereQuiz();
      _selectedAnswers = List<int>.filled(_questions.length, -1); 
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
      
      }
       else {
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

void _navigateToScoreDialog() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Quiz Finished'),
        content:   Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(width: 1000),
          const Text(
            'Your Score: ',
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(255, 228, 111, 15),
            ),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(
                  strokeWidth: 10,
                  value: _score / 10,
                  color: Color.fromARGB(255, 228, 111, 15),
                  backgroundColor: Color.fromARGB(255, 116, 114, 114),
                ),
              ),
              Column(
                children: [
                  Text(
                    _score.toString(),
                    style: const TextStyle(fontSize: 80),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${(_score / 10 * 100).round()}%',
                    style: const TextStyle(fontSize: 25),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Ferme la boîte de dialogue
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}



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
              style: TextStyle(
                  fontSize: 20, fontFamily: AutofillHints.creditCardNumber),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.timer_outlined,color: Colors.white,size: 15.0),
                label: Text(
                  '${(_remainingTimeInSeconds ~/ 60).toString().padLeft(2, '0')}:${(_remainingTimeInSeconds % 60).toString().padLeft(2, '0')}',
                    style: TextStyle(color: Colors.white,fontSize: 15.0), // Texte blanc

                ),
                
                style:  ElevatedButton.styleFrom(
               backgroundColor: Color.fromARGB(238, 245, 101, 5),
               
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
                  color: _questionIndex == index ? Color.fromARGB(255, 255, 115, 0) : Colors.grey,
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
          Divider(
              color: Color.fromARGB(255, 250, 104, 6),
              height: 60.0,
            ),
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
                child: Card(
                elevation: 3, // Ajoute une ombre pour un effet de profondeur
                child: RadioListTile<int>(
                title: Text(entry.value),
                value: entry.key,
                groupValue: _selectedAnswers[_questionIndex],
                onChanged: _isTimeUp ? null : (value) => _answerQuestion(value!),
              ),
            ),
          ),
        )
       .toList(),
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
                child: Text('BACK' , style: TextStyle(color: Colors.white), // Texte blanc
                ),
                style:  ElevatedButton.styleFrom(
                   backgroundColor: Color.fromARGB(238, 245, 101, 5)
                ),
              ),
        ElevatedButton(
         onPressed:_questionIndex < _questions.length - 1 ? _nextQuestion : _navigateToScoreDialog,
         child: Text(_questionIndex < _questions.length - 1 ? 'NEXT' : 'SEND', style: TextStyle(color: Colors.white)),
         style: ElevatedButton.styleFrom(
         backgroundColor: _questionIndex < _questions.length - 1
           ? Color.fromARGB(238, 245, 101, 5) 
           :Color.fromARGB(238, 245, 101, 5),                      
           ),
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
