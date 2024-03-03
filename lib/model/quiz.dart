import 'package:quizapp/model/question.dart';
class Quiz {
   String id;
   String theme;
   List<Question> questions ;

   Quiz({required this.id , required this.theme , required this.questions});
   
}