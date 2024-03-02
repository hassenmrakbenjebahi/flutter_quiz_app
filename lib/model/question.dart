class Question {
  String question;
  List<String> options;
  int correct;

  Question({required this.question, required this.options,required this.correct});

    Map<String, dynamic> toJson() {
    return {
      'question': question,
      'options': options,
      'correct': correct,
    };
  }
}
