
import 'package:flutter/material.dart';
import '../services/response_process.dart';

double _value = 20;
List<Quiz> quizzes = [];

class OpenAIEntryScreen extends StatefulWidget {
  const OpenAIEntryScreen({super.key});

  @override
  State<OpenAIEntryScreen> createState() => _OpenAIEntryScreenState();
}

class _OpenAIEntryScreenState extends State<OpenAIEntryScreen> {
  TextEditingController promptController1 = TextEditingController();
  TextEditingController promptController2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Expanded(
            child: Column(
              children: [
                SizedBox(height: 200),
                Center(
                  child: Text(
                    'Craft Your Quiz',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                )
              ]
            )
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.55,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.93,
                      // height: MediaQuery.of(context).size.height * 0.58,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(15)),
                          color: Colors.deepPurple[200]
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
                        child: TextFormField(
                          controller: promptController1,
                          maxLines: 1,
                          decoration: const InputDecoration(
                            labelText: "What is your quiz about?",
                          ),
                        ),
                      ),
                    ),
                    // padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),

                  ),
                  const SizedBox(height: 25),
                  Container(
                      alignment: Alignment.center,
                      child: Container(
                        // padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        width: MediaQuery.of(context).size.width * 0.93,
                        // height: MediaQuery.of(context).size.height * 0.58,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(15)),
                            color: Colors.deepPurple[200]
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
                          child: TextFormField(
                            controller: promptController2,
                            maxLines: 1,
                            decoration: const InputDecoration(
                              labelText: "Detailed description?",
                            ),
                          ),
                        ),
                      )
                  ),
                  const SizedBox(height: 25),
                  Container(
                      alignment: Alignment.center,
                      child: Container(
                        // padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        width: MediaQuery.of(context).size.width * 0.93,
                        // height: MediaQuery.of(context).size.height * 0.58,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(15)),
                            color: Colors.deepPurple[200]
                        ),
                        child: Slider(
                          min: 5.0,
                          max: 20.0,
                          value: _value,
                          divisions: 3,
                          label: '${_value.round()}',
                          onChanged: (value) {
                            setState(() {
                              _value = value;
                            });
                          },
                        )
                      )
                  ),
                ]
            ),
          ),




          // Padding(
          //   padding: const EdgeInsets.all(20.0),
          //   child: Text(
          //     response ?? "",
          //     style: TextStyle(color: Colors.grey.shade800),
          //   ),
          // ),
          ElevatedButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: 80, vertical: 20)),
                backgroundColor: MaterialStateProperty.all(Colors.deepPurple[200]),
              ),
              onPressed: (promptController1.text.isNotEmpty &&
                  promptController2.text.isNotEmpty) ? () async {
                quizzes = await ResponseProcess.getQuizzes(
                  prompt1: promptController1.text,
                  prompt2: promptController2.text,
                  numQuestions: _value,
                );

                Navigator.pushNamed(context, '/quiz', arguments: quizzes);
              }
              : null,
              child: const Text(
                "Submit",
                style: TextStyle(fontSize: 16),
              )
          ),
          const SizedBox(height: 25),
        ],
      ),
    );
  }
}