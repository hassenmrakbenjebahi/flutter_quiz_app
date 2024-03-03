import 'package:flutter/material.dart';

class ScreenAllQuiz extends StatefulWidget {
  const ScreenAllQuiz({Key? key}) : super(key: key);

  @override
  State<ScreenAllQuiz> createState() => _ScreenAllQuizState();
}

class _ScreenAllQuizState extends State<ScreenAllQuiz> {
  // Exemple de données pour la liste de quiz
  final List<Map<String, dynamic>> quizData = [
    {
      'title': 'Quiz 1',
      'image': 'assets/quiz.png',
    },
    {
      'title': 'Quiz 2',
      'image': 'assets/quiz.png',
    },
    {
      'title': 'Quiz 3',
      'image': 'assets/quiz.png',
    },
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
              style: TextStyle(
                  fontSize: 20, fontFamily: AutofillHints.creditCardNumber),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: quizData.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: Image.asset(
                'assets/lquiz.jpg',
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
              title: Text(quizData[index]['title']),
              subtitle: Text('Description du quiz'),
              trailing: ElevatedButton(
                onPressed: () {
                  // Action à effectuer lors de l'appui sur le bouton
                  // Par exemple, naviguer vers une autre page
                },
                child: Text('Commencer'),
              ),
            ),
          );
        },
      ),
    );
  }
}
