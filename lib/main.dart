
import 'package:flutter/material.dart';
import 'package:quizcraft/home_screen.dart';
import 'package:quizcraft/entry_screen.dart';
import 'package:quizcraft/quiz_screen.dart';

void main() {
  runApp(MaterialApp(
    routes: {
      '/': (context) => const HomeScreen(),
      '/chat': (context) => const OpenAIEntryScreen(),
      '/quiz': (context) => const QuizScreen(),
    },
  ));
}
