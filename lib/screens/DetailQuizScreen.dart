import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailQuizScreen extends StatefulWidget {
  const DetailQuizScreen({Key? key}) : super(key: key);

  @override
  State<DetailQuizScreen> createState() => _DetailQuizScreenState();
}

class _DetailQuizScreenState extends State<DetailQuizScreen> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              "assets/logo.png",
              width: 40.0,
              height: 40.0,
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
      body: SingleChildScrollView(
        child: Center( // Utiliser le widget Center pour centrer la Card
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.04), // Padding adaptatif
            child: Card(
              elevation: 3.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.all(screenWidth * 0.03), // Padding adaptatif
                    child: Text(
                      'Brif Explanation About This Quiz',
                      style: TextStyle(
                        fontSize: screenWidth * 0.06, // Taille de police adaptative
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 25.0), // Espacement entre les règles du quiz et le reste du contenu
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                    child: Row(
                      children: [
                        _buildCircleIcon(Icons.check_circle), // Appel à une fonction pour créer l'icône dans un cercle
                        SizedBox(width: 10), // Espacement entre l'icône et le texte
                        Text('10 questions'), // Texte de la règle
                      ],
                    ),
                  ),
                  SizedBox(width: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                    child: Row(
                      children: [
                        _buildCircleIcon(Icons.timer), // Appel à une fonction pour créer l'icône dans un cercle
                        SizedBox(width: 10), // Espacement entre l'icône et le texte
                        Text('5 minutes'), // Texte de la règle
                      ],
                    ),
                  ),
                  SizedBox(width: 25),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                    child: Text(
                      'Please read the text bellow  carefully so you can understand it :',
                      style: TextStyle(fontSize: screenWidth * 0.04),
                    ),
                  ),
                  SizedBox(width: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                    child: Text(
                      '- Tap on options to select the correct answer',
                      style: TextStyle(fontSize: screenWidth * 0.04),
                    ),
                  ),
                  SizedBox(width: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                    child: Text(
                      '- Click submit if you are sure you want to complete all this questions',
                      style: TextStyle(fontSize: screenWidth * 0.04),
                    ),
                  ),
                   SizedBox(width: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                    child: Text(
                      '- You have the freedom to navigate between the quiz questions at your own pace',
                      style: TextStyle(fontSize: screenWidth * 0.04),
                    ),
                  ),
                      SizedBox(width: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                    child: Text(
                      '-  Feel free to review and modify your answers at any time before submitting the quiz',
                      style: TextStyle(fontSize: screenWidth * 0.04),
                    ),
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                       Get.toNamed('/quiz');
                    },
                    child: Text('Start Quiz', style: TextStyle(color: Colors.white)),
                     style:  ElevatedButton.styleFrom(
                     backgroundColor: Color.fromARGB(238, 245, 101, 5)
                ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCircleIcon(IconData iconData) {
    return Container(
      width: 40.0,
      height: 40.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color.fromARGB(255, 243, 145, 33), // Couleur du cercle
      ),
      child: Icon(
        iconData,
        color: Colors.white, // Couleur de l'icône
        size: 24.0, // Taille de l'icône
      ),
    );
  }
}
