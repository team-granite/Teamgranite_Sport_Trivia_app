class QuestionModel{
  final Results results;
  

  QuestionModel({this.results});
  factory QuestionModel.fromJson(Map<String, dynamic> parsedJson){
    return QuestionModel(
      results: Results.fromJson(parsedJson['results']),
    );
  }
}

class Results{
  final String question;
  final String correct_answer;

  Results({this.question, this.correct_answer});

  factory Results.fromJson(Map<String, dynamic> parsedJson){
      return Results(
      question: parsedJson['question'],
      correct_answer: parsedJson['correct_answer'],
      );
  }

  
}