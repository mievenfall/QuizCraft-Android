import '../services/chat_service.dart';

class ResponseProcess {
  static Future<List<Quiz>> getQuizzes({
    required String prompt1,
    required String prompt2,
    required double numQuestions,
  }) async {
    String? response = await ChatService().request([
      prompt1,
      prompt2,
      numQuestions.toString()
    ]);

    return parseQuizzes(response!);
  }

  static List<Quiz> parseQuizzes(String text) {
    List<Quiz> quizzes = [];
    List<String> questions = [];
    List<List<String>> options = [];
    List<String> answers = [];
    List<String> explanation = [];
    int currentQuestion = -1;
    int currentAnswer = -1;
    bool isAnswerSection = false;

    List<String> lines = text.split("\n");

    for (var line in lines) {
      if (line.startsWith("Quiz:")) {
        isAnswerSection = false;
      }
      if (line.startsWith("Question")) {
        currentQuestion++;
        String question = line.substring(line.indexOf(":") + 2).trim();
        questions.add(question);
        options.add([]);
        isAnswerSection = false;
      } else if (line.startsWith("Option")) {
        if (currentQuestion >= 0 && currentQuestion < options.length) {
          String option = line.substring(line.indexOf(":") + 2).trim();
          options[currentQuestion].add(option);
        }
      } else if (line.startsWith("Answer:")) {
        isAnswerSection = true;
        break;
      }
    }

    while (true) {
      if (lines[0].startsWith("Answer:")) {
        break;
      }
      lines.remove(lines[0]);
    }

    for (var line in lines) {
      if (line.startsWith("Question")) {
        currentAnswer++;
        if (currentAnswer >= 0 && currentAnswer < questions.length) {
          String answer = line.substring(line.indexOf(":") + 2).trim();
          if (currentAnswer < answers.length) {
            answers[currentAnswer] = answer.substring(line.indexOf(":")).trim();
          } else {
            answers.add(answer.substring(line.indexOf(":")).trim());
          }
        }
      } else if (line.startsWith("Expla")) {
        if (currentAnswer >= 0 && currentAnswer < explanation.length) {
          explanation[currentAnswer] = line;
        } else {
          explanation.add(line);
        }
      }
    }

    for (int i = 0; i < questions.length; i++) {
      String answer = "";
      if (i < answers.length) {
        answer = answers[i].trim();
      }
      String exp = "";
      if (i < explanation.length) {
        exp = explanation[i].trim();
      }
      Quiz quiz = Quiz(
        question: questions[i],
        options: options[i],
        answer: answer,
        explanation: exp,
      );
      quizzes.add(quiz);
    }

    return quizzes;
  }
}

class Quiz {
  String question;
  List<String> options;
  String answer;
  String explanation;

  Quiz({
    required this.question,
    required this.options,
    required this.answer,
    required this.explanation,
  });
}