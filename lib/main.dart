import 'package:flutter/material.dart';
import 'question_bank.dart';
import 'question.dart';

import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //theme: ThemeData.dark(),
      home: QuizPage(),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  QuestionBank questBank = QuestionBank();
  Question questionClass = Question();
  int questionNumber = 0;
  int score = 0;
  bool _enabled = true;
  bool _gameEnd = false;
  var alertStyle = AlertStyle(
    animationType: AnimationType.fromTop,
    isCloseButton: false,
//    isOverlayTapDismiss: false,
//    descStyle: TextStyle(fontWeight: FontWeight.bold),
//    animationDuration: Duration(milliseconds: 400),
//    alertBorder: RoundedRectangleBorder(
//      borderRadius: BorderRadius.circular(0.0),
//      side: BorderSide(
//        color: Colors.grey,
//      ),
//    ),
//    titleStyle: TextStyle(
//      color: Colors.red,
//    ),
  );

  void checkAnswer(bool userAnswer) {
    if (questBank.questions[questionNumber].answer == userAnswer) {
      answerChecks.add(
        Icon(
          Icons.check,
          color: Colors.green,
        ),
      );
      score++;
    } else {
      answerChecks.add(
        Icon(
          Icons.close,
          color: Colors.red,
        ),
      );
    }
  }

  List<Icon> answerChecks = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quiz App',
          style: TextStyle(
            fontSize: 30,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Center(
                  child: Text(
                    questBank.questions[questionNumber].questionText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: _gameEnd ? Container(
                  child: Column(
                    children: <Widget>[
                      Text(
                          'Your Score: $score/${questBank.questions.length}',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      FlatButton(
                        onPressed: (){
                          setState(() {
                            questionNumber = 0;
                            score = 0;
                            answerChecks = [];
                            _enabled = true;
                            _gameEnd = false;
                          });
                        },
                        color: Colors.blue,
                        child: Text(
                            'Try Again',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                        ),
                      )
                    ],
                  ),
                ): SizedBox(height: 30,),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: FlatButton(
                    child: Text(
                        'True',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                    ),
                    onPressed: _enabled
                        ? () {
                            checkAnswer(true);
                            setState(() {
                              if (questionNumber >= 4) {
                                _enabled = false;
                                _gameEnd = true;
                                return;
                              }
                              questionNumber++;
                            });
                          }
                        : null,
                    color: Colors.green,
                    disabledColor: Colors.green[900],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: FlatButton(
                    child: Text('False',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),),
                    onPressed: _enabled
                        ? () {
                            checkAnswer(false);
                            setState(() {
                              if (questionNumber >= 4) {
                                _enabled = false;
                                _gameEnd = true;
                                return;
                              }
                              questionNumber++;
                            });
                          }
                        : null,
                    color: Colors.red,
                    disabledColor: Colors.red[900],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 3.0),
                child: Row(
                  children: answerChecks,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
