// import 'dart:math';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'quiz_brain.dart';

// QuizBrain object

QuizBrain quizBrain = QuizBrain();

void main() {
  runApp(const Quizzler());
}

class Quizzler extends StatelessWidget {
  const Quizzler({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];

  void checkAnswer(bool userChoice) {
    bool correctAnswer = quizBrain.getQuestionAnswer();
    //HINT! Step 4 Part B is in the quiz_brain.dart
    bool end = quizBrain.isFinished();

    setState(
      () {
        if (end == true) {
          Alert(
            context: context,
            type: AlertType.none,
            title: "Quiz Finished",
            desc: "You've reached the end of the quiz.",
            style: AlertStyle(
              backgroundColor: Colors.grey.shade900,
              titleStyle: const TextStyle(color: Colors.white),
              descStyle: const TextStyle(color: Colors.white),
            ),
            buttons: [
              DialogButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                color: const Color.fromARGB(255, 21, 51, 102),
                child: const Text(
                  "Restart",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              )
            ],
          ).show();
          quizBrain.reset();
          scoreKeeper.clear();
        } else {
          if (correctAnswer == userChoice) {
            scoreKeeper.add(
              const Icon(
                Icons.check,
                color: Colors.green,
              ),
            );
          } else {
            scoreKeeper.add(
              const Icon(
                Icons.close,
                color: Colors.red,
              ),
            );
          }
          quizBrain.nextQuestion();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              onPressed: () {
                checkAnswer(true);
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.green),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
              ),
              child: const Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              onPressed: () {
                checkAnswer(false);
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.red),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
              ),
              child: const Text(
                'False',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}
