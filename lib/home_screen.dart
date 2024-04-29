
import 'package:flutter/material.dart';

bool isHover=false;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.2),
            const Expanded(
              child: Center(
                  child: Text(
                    'QuizCraft',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold
                    ),
                  )
              )
            ),
            Container(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.58,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)
                      ),
                      color: Colors.deepPurple[800]
                  ),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    width: double.infinity,
                    // height: MediaQuery.of(context).size.height * 0.55,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15)
                        ),
                        color: Colors.deepPurple[600]
                    ),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      width: double.infinity,
                      // height: MediaQuery.of(context).size.height * 0.55,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15)
                          ),
                          color: Colors.deepPurple[400]
                      ),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        width: double.infinity,
                        // height: MediaQuery.of(context).size.height * 0.55,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15)
                            ),
                            color: Colors.deepPurple[200]
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/chat'); // Navigate to entry screen
                                },
                                style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                      const EdgeInsets.symmetric(horizontal: 60, vertical: 15)),
                                  backgroundColor: MaterialStateProperty.all(Colors.white),
                                ),
                                child: const Text(
                                  'Start Here',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height * 0.2)
                            ]
                        ),
                    )
                  )
                )
            )
          ],
        ),
      ),
    );
  }
}