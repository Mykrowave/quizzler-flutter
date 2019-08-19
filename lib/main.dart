import 'package:flutter/material.dart';
import 'package:quizzler/quiz-brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
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
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> _scoreKeeper = [];

  final QuizBrain _quizBrain = new QuizBrain();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                _quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
                textColor: Colors.white,
                color: Colors.green,
                child: Text(
                  'True',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    markScore(true);
                  });
                }),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                setState(() {
                  markScore(false);
                });
              },
            ),
          ),
        ),
        Expanded(
          child: Row(
            children: _scoreKeeper,
          ),
        )
      ],
    );
  }

  void markScore(bool answer) {
    if (_quizBrain.isAnswerCorrect(answer))
      _scoreKeeper.add(Icon(Icons.check, color: Colors.green));
    else
      _scoreKeeper.add(Icon(Icons.close, color: Colors.red));

    _quizBrain.nextQuestion();
    endOfQuizCheck();
  }

  void endOfQuizCheck() {
    if (_quizBrain.isEndOfQuiz()) {
      Alert(
          context: context,
          type: AlertType.success,
          title: "Quiz Complete",
          desc: "Thanks for taking the Quiz",
          buttons: [
            DialogButton(
              child: Text('COOL!'),
              onPressed: () {
                setState(() {
                  _quizBrain.resetQuiz();
                  _scoreKeeper.clear();
                });

                Navigator.pop(context);
              },
              width: 120,
            )
          ]).show();
    }
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
