class QuestionModel{
  String question;
  String answer;
  String imageurl;

  QuestionModel({this.question, this.answer, this.imageurl});

  void setQuestion(String getQuestion){
    question = getQuestion;
  }

    void setAnswer(String getAnswer){
    answer = getAnswer;
  }

    void setImageUrl(String getImageUrl){
    imageurl = getImageUrl;
  }

  String getQuestion(){
    return question;
  }

  String getAnswer(){
    return answer;
  }

  String getImageUrl(){
    return imageurl;
  }



}