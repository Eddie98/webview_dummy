import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testdeltasoft/dummy/constants.dart';
import 'package:testdeltasoft/dummy/widgets/snackbar.dart';
import 'package:testdeltasoft/dummy/widgets/unfocusable.dart';

import 'controller.dart';

class Dummy extends StatefulWidget {
  const Dummy({super.key});

  @override
  State<Dummy> createState() => _DummyState();
}

class _DummyState extends State<Dummy> {
  final getxCtrl = Get.find<Controller>();

  List<Map<String, dynamic>> questionsAndAnswers = [
    {
      'id': 0,
      'question': 'What kind of sport is usually played on this field or area?',
      'picture': 'assets/0.gif',
      'correctAnswer': 3,
      'userAnswer': -1,
      'answers': [
        'Table tennis',
        'Dodgeball',
        'Basque pelota',
        'Squash',
      ],
    },
    {
      'id': 1,
      'question': 'What kind of sport is usually played on this field or area?',
      'picture': 'assets/1.gif',
      'correctAnswer': 1,
      'userAnswer': -1,
      'answers': [
        'Formula One',
        'Speedskating',
        'Steeplechase',
        'Cricket',
      ],
    },
    {
      'id': 2,
      'question': 'What kind of sport is usually played on this field or area?',
      'picture': 'assets/2.gif',
      'correctAnswer': 2,
      'userAnswer': -1,
      'answers': [
        'Field lacrosse',
        'Korfball',
        'Field hockey',
        'Association football/Soccer',
      ],
    },
    {
      'id': 3,
      'question': 'What kind of sport is usually played on this field or area?',
      'picture': 'assets/3.gif',
      'correctAnswer': 3,
      'userAnswer': -1,
      'answers': [
        'Korfball',
        'Dodgeball',
        'Basketball',
        'Handball',
      ],
    },
    {
      'id': 4,
      'question': 'What kind of sport is usually played on this field or area?',
      'picture': 'assets/4.gif',
      'correctAnswer': 1,
      'userAnswer': -1,
      'answers': [
        'Roller derby',
        'Ice hockey',
        'Curling',
        'Figure Skating',
      ],
    },
    {
      'id': 5,
      'question': 'What kind of sport is usually played on this field or area?',
      'picture': 'assets/5.gif',
      'correctAnswer': 3,
      'userAnswer': -1,
      'answers': [
        'Carom billiards',
        'Boules',
        'Baseball',
        'Snooker',
      ],
    },
    {
      'id': 6,
      'question': 'What kind of sport is usually played on this field or area?',
      'picture': 'assets/6.gif',
      'correctAnswer': 3,
      'userAnswer': -1,
      'answers': [
        'Waterpolo',
        'Handball',
        'Basque pelota',
        'Competitive swimming',
      ],
    },
    {
      'id': 7,
      'question': 'What kind of sport is usually played on this field or area?',
      'picture': 'assets/7.gif',
      'correctAnswer': 0,
      'userAnswer': -1,
      'answers': [
        'Korfball',
        'Netball',
        'Basketball',
        'Squash',
      ],
    },
    {
      'id': 8,
      'question': 'What kind of sport is usually played on this field or area?',
      'picture': 'assets/8.gif',
      'correctAnswer': 0,
      'userAnswer': -1,
      'answers': [
        'American football',
        'Australian rules football',
        'Cricket',
        'Gaelic football/Hurling',
      ],
    },
    {
      'id': 9,
      'question': 'What kind of sport is usually played on this field or area?',
      'picture': 'assets/9.gif',
      'correctAnswer': 3,
      'userAnswer': -1,
      'answers': [
        'Competitive swimming',
        'Cricket',
        'Speedskating',
        'Track running',
      ],
    },
  ];
  bool isShowCorrectAndInCorrenctAnswers = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async => false,
      child: UnFocusable(
        child: Scaffold(
          backgroundColor: Colors.blue[100],
          extendBodyBehindAppBar: true,
          body: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16.0, 92.0, 16.0, 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Texts.mainTitle,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.actor(
                    color: Colors.black,
                    fontSize: 32.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12.0),
                Text(
                  Texts.mainDescription,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.actor(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                ...List.generate(
                  questionsAndAnswers.length,
                  (index) {
                    final item = questionsAndAnswers.elementAt(index);
                    return Padding(
                      padding: const EdgeInsets.only(top: 42.0),
                      child: _Item(
                        index: index,
                        id: item['id'],
                        picture: item['picture'],
                        isShowCorrectAndInCorrenctAnswers:
                            isShowCorrectAndInCorrenctAnswers,
                        question: item['question'],
                        correctAnswer: item['correctAnswer'],
                        userAnswer: item['userAnswer'],
                        answers: item['answers'],
                        onSelectItem: (int id, int i) {
                          setState(() {
                            questionsAndAnswers = questionsAndAnswers
                                .map<Map<String, dynamic>>((e) {
                              if (e['id'] == id) {
                                e['userAnswer'] = i;
                              }
                              return e;
                            }).toList();
                          });
                        },
                      ),
                    );
                  },
                ),
                const SizedBox(height: 32.0),
                SizedBox(
                  width: size.width,
                  height: 45.0,
                  child: ElevatedButton(
                    onPressed: () {
                      if (questionsAndAnswers
                          .any((e) => e['userAnswer'] == -1)) {
                        showSnackbar(
                          context: context,
                          text: 'Answer all questions!',
                        );
                      } else {
                        setState(() {
                          isShowCorrectAndInCorrenctAnswers =
                              !isShowCorrectAndInCorrenctAnswers;
                        });

                        final correctAnswersLength = questionsAndAnswers
                            .where((e) => e['userAnswer'] == e['correctAnswer'])
                            .length;
                        final questionsLength = questionsAndAnswers.length;

                        showSnackbar(
                          context: context,
                          text:
                              'You answered $correctAnswersLength questions out of $questionsLength correctly ',
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      ),
                      backgroundColor: Colors.indigo,
                    ),
                    child: Text(
                      'Show results',
                      style: GoogleFonts.actor(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({
    required this.index,
    required this.id,
    required this.picture,
    required this.isShowCorrectAndInCorrenctAnswers,
    required this.question,
    required this.correctAnswer,
    required this.userAnswer,
    required this.answers,
    required this.onSelectItem,
  });

  final int index;
  final int id;
  final String picture;
  final bool isShowCorrectAndInCorrenctAnswers;
  final String question;
  final int correctAnswer;
  final int userAnswer;
  final List<String> answers;
  final void Function(int, int) onSelectItem;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          textAlign: TextAlign.center,
          style: GoogleFonts.actor(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8.0),
        Image.asset(
          picture,
          fit: BoxFit.cover,
          width: size.width,
        ),
        const SizedBox(height: 8.0),
        ...List.generate(answers.length, (i) {
          final answer = answers.elementAt(i);

          return CheckboxListTile(
            value: i == userAnswer,
            tileColor: Colors.transparent,
            title: Text(
              answer,
              style: GoogleFonts.actor(
                color: isShowCorrectAndInCorrenctAnswers
                    ? (userAnswer == correctAnswer && i == correctAnswer) ||
                            i == correctAnswer
                        ? Colors.green
                        : i == userAnswer
                            ? Colors.red
                            : Colors.black
                    : Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            activeColor: Colors.pinkAccent,
            checkboxShape: const RoundedRectangleBorder(),
            visualDensity: VisualDensity.compact,
            onChanged: (bool? value) => onSelectItem(id, i),
          );
        })
      ],
    );
  }
}
