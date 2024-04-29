import 'package:flutter/material.dart';
import '../services/response_process.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<int> selectedOptions = [];
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  bool _showingQuiz = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final List<Quiz> quizzes =
    ModalRoute.of(context)!.settings.arguments as List<Quiz>;
    selectedOptions = List.filled(quizzes.length, -1); // Initialize with -1 (no option selected)
  }

  @override
  Widget build(BuildContext context) {
    final List<Quiz> quizzes =
    ModalRoute.of(context)!.settings.arguments as List<Quiz>;
    if (!_showingQuiz) {
      int correctAnswers = 0;
      for (int i = 0; i < quizzes.length; i++) {
        if (quizzes[i].options[selectedOptions[i]] == quizzes[i].answer) {
          correctAnswers++;
        }
      }
      double percentage = (correctAnswers / quizzes.length) * 100;
      return Scaffold(
        backgroundColor: Colors.grey[900],
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 200),
                Text(
                  'YOUR RESULT',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  '${percentage.round()}%',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 72,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  'You got $correctAnswers out of ${quizzes.length} correct',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 20),
                ...quizzes.asMap().entries.map((entry) {
                  int index = entry.key;
                  Quiz quiz = entry.value;
                  return Card(
                    color: Colors.deepPurple[200],
                    margin: const EdgeInsets.all(16.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            quiz.question,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Text(
                            'Your Answer: ${quiz.options[selectedOptions[index]]}',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'Correct Answer: ${quiz.answer}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green[800],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
                SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Back'),
                ),
              ],
            ),
          )

        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                PopupMenuButton(
                  icon: Icon(Icons.settings, color: Colors.white),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Text('Skip to answer'),
                      onTap: () {
                        setState(() {
                          _showingQuiz = false;
                          for (int i = 0; i < selectedOptions.length; i++) {
                            if (selectedOptions[i] == -1) {
                              selectedOptions[i] = 0; // Mark empty answers as wrong
                            }
                          }
                        });
                      },
                    ),
                    PopupMenuItem(
                      child: Text('Exit'),
                      onTap: () {
                        Navigator.pushNamed(context, '/');
                      },
                    ),
                  ],
                ),
                SizedBox(width: 16.0),
              ],
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: quizzes.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.deepPurple[200],
                    margin: const EdgeInsets.all(16.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            quizzes[index].question,
                            style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 16.0),
                          ...quizzes[index].options.asMap().entries.map(
                                (entry) {
                              int optionIndex = entry.key;
                              String option = entry.value;

                              return RadioListTile(
                                title: Text(
                                  option,
                                  style: TextStyle(fontSize: 18),
                                ),
                                value: optionIndex,
                                groupValue: selectedOptions[index],
                                onChanged: (int? value) {
                                  setState(() {
                                    selectedOptions[index] = value ?? -1;
                                  });
                                },
                              );
                            },
                          ).toList(),
                          if (_currentIndex == quizzes.length - 1)
                            ElevatedButton(
                              onPressed: selectedOptions.contains(-1)
                                  ? null
                                  : () {
                                setState(() {
                                  _showingQuiz = false;
                                });
                              },
                              child: Text('Submit'),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    color: Colors.white,
                    onPressed: _currentIndex == 0
                        ? null
                        : () {
                      _pageController.previousPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                  Text(
                    'Question ${_currentIndex + 1} of ${quizzes.length}',
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_forward),
                    color: Colors.white,
                    onPressed: _currentIndex == quizzes.length - 1
                        ? null
                        : () {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}