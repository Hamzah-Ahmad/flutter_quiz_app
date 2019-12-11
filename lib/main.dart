import 'package:flutter/material.dart';
import 'question_bank.dart';
import 'question.dart';
import 'package:auto_size_text/auto_size_text.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
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
//  var alertStyle = AlertStyle(
//   animationType: AnimationType.fromTop,
//   isCloseButton: false,
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
// );

  void checkAnswer(bool userAnswer) {
    if (questBank.questions[questionNumber].answer == userAnswer) {
      answerChecks[questionNumber] = Icon(
        Icons.check,
        color: Colors.green,
      );
      score++;
    } else {
      answerChecks[questionNumber] = Icon(
        Icons.close,
        color: Colors.red,
      );
    }
    //answerChecks.add(SizedBox(width: 10,));
  }

  List<Icon> answerChecks = [];
  @override
  void initState() {
    super.initState();
    for (int i = 0; i < questBank.questions.length; i++) {
      answerChecks.add(Icon(
        Icons.trip_origin,
        color: Color(0xFF303030),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'QuizMi',
          style: TextStyle(fontSize: 45, fontFamily: 'LakkiReddy'),
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
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 20.0, left: 15, right: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Question:',
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'LakkiReddy'
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        AutoSizeText(
                          questBank.questions[questionNumber].questionText,
                          //textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 30,
                            height: 1.5,
                              fontFamily: 'LakkiReddy'

                          ),
                          maxLines: 3,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: _gameEnd
                    ? Container(
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Your Score: $score/${questBank.questions.length}',
                              style: TextStyle(
                                fontSize: 20,
                                  fontFamily: 'LakkiReddy'
                              ),
                            ),
                            FlatButton(
                              onPressed: () {
                                setState(() {
                                  questionNumber = 0;
                                  score = 0;
                                  answerChecks = [];
                                  for (int i = 0;
                                      i < questBank.questions.length;
                                      i++) {
                                    answerChecks.add(Icon(
                                      Icons.trip_origin,
                                      color: Color(0xFF303030),
                                    ));
                                  }
                                  _enabled = true;
                                  _gameEnd = false;
                                });
                              },
                              color: Colors.blue,
                              child: Text(
                                'Try Again',
                                style: TextStyle(
                                  color: Colors.white,
                                    fontFamily: 'LakkiReddy',
                                  fontSize: 18,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    : SizedBox(
                        height: 10,
                      ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 70),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      'True',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                          fontFamily: 'LakkiReddy'
                      ),
                    ),
                    onPressed: _enabled
                        ? () {
                            checkAnswer(true);
                            setState(() {
                              if (questionNumber == questBank.questions.length-1) {
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
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 70),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      'False',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                          fontFamily: 'LakkiReddy'
                      ),
                    ),
                    onPressed: _enabled
                        ? () {
                            checkAnswer(false);
                            setState(() {
                              if (questionNumber == questBank.questions.length-1) {
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
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
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
