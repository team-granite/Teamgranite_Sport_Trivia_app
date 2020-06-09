// import 'dart:convert';
// import 'package:connectivity/connectivity.dart';

// import 'package:http/http.dart' as http;
// import 'package:sport_trivia_app/model/questionModel.dart';


// class Data {


//  Future<List<QuestionModel>> getQuestions () async {

//   try {
//   final response = await http.get(url);
//   if(response.statusCode == 200){
//   List<QuestionModel> list = parseQuestions(response.body);
//   return list;
//   } else {
//     throw Exception("Error");
//   }

    
//   } catch (e) {
//   }

// }

//   static List<QuestionModel> parseQuestions(String responseBody){
//     final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
//     return parsed.map<QuestionModel>((json)=> QuestionModel.fromJson(json)).toList();
//   }

// }

 

//     // method defined to check internet connectivity
// Future<bool> isConnected() async {
//   var connectivityResult = await (Connectivity().checkConnectivity());
//   if (connectivityResult == ConnectivityResult.mobile) {
//     return true;
//   } else if (connectivityResult == ConnectivityResult.wifi) {
//     return true;
//   }
//   return false;
// }



// // List<QuestionModel> getQuestion(){

// //   List<QuestionModel> questions = List<QuestionModel>();
// //   QuestionModel questionModel = QuestionModel();



 
// //   // //1
// //   // questionModel.setQuestion("A baby has more bones than an adult");
// //   // questionModel.setAnswer("True");
// //   // questionModel.setImageUrl("https://images.pexels.com/photos/789786/pexels-photo-789786.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940");
// //   // questions.add(questionModel);
// //   // questionModel = new QuestionModel();

// //   // //2
// //   // questionModel.setQuestion("A shark can blink its eyes");
// //   // questionModel.setAnswer("True");
// //   // questionModel.setImageUrl("https://images.pexels.com/photos/726478/pexels-photo-726478.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940");
// //   // questions.add(questionModel);

// //   // questionModel = new QuestionModel();

// //   // //3
// //   // questionModel.setQuestion("The U.S dollars are made from fiber");
// //   // questionModel.setAnswer("False");
// //   // questionModel.setImageUrl("https://images.pexels.com/photos/259027/pexels-photo-259027.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500");
// //   // questions.add(questionModel);

// //   // questionModel = new QuestionModel();

// //   // //4
// //   // questionModel.setQuestion("Sandwich is named after a person");
// //   // questionModel.setAnswer("True");
// //   // questionModel.setImageUrl("https://images.pexels.com/photos/1647163/pexels-photo-1647163.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500");
// //   // questions.add(questionModel);

// //   // questionModel = new QuestionModel();

// //   // //5
// //   // questionModel.setQuestion("A tiger gas stripes on its skin");
// //   // questionModel.setAnswer("True");
// //   // questionModel.setImageUrl("https://images.pexels.com/photos/302304/pexels-photo-302304.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500");
// //   // questions.add(questionModel);

// //   // questionModel = new QuestionModel();

// //   // //6
// //   // questionModel.setQuestion("An ostrich has the largest eye in the world");
// //   // questionModel.setAnswer("False");
// //   // questionModel.setImageUrl("https://images.pexels.com/photos/60692/bird-animal-nature-strauss-60692.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500");
// //   // questions.add(questionModel);

// //   // questionModel = new QuestionModel();

// //   // //7
// //   // questionModel.setQuestion("Some 16 billion emails are send daily");
// //   // questionModel.setAnswer("False");
// //   // questionModel.setImageUrl("https://images.pexels.com/photos/374074/pexels-photo-374074.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940");
// //   // questions.add(questionModel);

// //   // questionModel = new QuestionModel();

// //   // //8
// //   // questionModel.setQuestion("Gorilla's blood type is all B");
// //   // questionModel.setAnswer("True");
// //   // questionModel.setImageUrl("https://images.pexels.com/photos/2657973/pexels-photo-2657973.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500");
// //   // questions.add(questionModel);

// //   // questionModel = new QuestionModel();


// //   // return questions;

// // }