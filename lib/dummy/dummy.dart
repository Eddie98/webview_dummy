import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testdeltasoft/dummy/constants.dart';
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
      'question': 'What is the name of the most common grip in table tennis?',
      'correctAnswer': 1,
      'userAnswer': -1,
      'answers': [
        'Pinch grip',
        'Hand shake grip',
        'Death grip',
        'Low squeeze grip',
      ],
    },
    {
      'question': 'What is the ready stance for playing table tennis?',
      'correctAnswer': 2,
      'userAnswer': -1,
      'answers': [
        'Straight leg, elbows bent, arms at side.',
        'Straight leg, elbor\\ws straight, arms out.',
        'Bent legs, elbows bent, arms out',
        'Beng legs, elboes straight, arms at side.',
      ],
    },
    {
      'question': 'The old method of scoring table tennis was:',
      'correctAnswer': 0,
      'userAnswer': -1,
      'answers': [
        'Score to 21 and switch serve every 5 points',
        'Score to 11 and switch serve every 3 points',
        'Score to 15 and switch serve every 2 points',
        'Score to 18 points and switch serve every 3 points',
      ],
    },
    {
      'question': 'The revised method of scoring table tennis is:',
      'correctAnswer': 3,
      'userAnswer': -1,
      'answers': [
        'Score to 21 and switch serve every 5 points.',
        'Score to 15 and switch serve every 2 points',
        'Score to 18 points and switch serve every 3 points',
        'Score to 11 points and switch serve every 2 points.',
      ],
    },
    {
      'question': 'Table tennis always ends at a specific score.',
      'correctAnswer': 1,
      'userAnswer': -1,
      'answers': [
        'True',
        'False',
      ],
    },
    {
      'question': 'When the score is tied 10 to 10 it is called',
      'correctAnswer': 2,
      'userAnswer': -1,
      'answers': [
        'Uno',
        'Twice',
        'Deuce',
        'Dos',
      ],
    },
    {
      'question':
          'What is it called when hitting the net while serving and the ball successfully makes it over the net?',
      'correctAnswer': 3,
      'userAnswer': -1,
      'answers': [
        'Set',
        'Deuce',
        'Dos',
        'Let',
      ],
    },
    {
      'question': 'Who gets the point when a let occurs on a serve?',
      'correctAnswer': 2,
      'userAnswer': -1,
      'answers': [
        'The server',
        'The defender',
        'No one',
        'Everybody',
      ],
    },
    {
      'question': 'The forehand follow through should go where?',
      'correctAnswer': 0,
      'userAnswer': -1,
      'answers': [
        'Up towards the face like a salute',
        'Down towards the ground',
        'Accross the chest',
        'Straight towards the shot',
      ],
    },
    {
      'question': 'The back hand follow through should go where?',
      'correctAnswer': 3,
      'userAnswer': -1,
      'answers': [
        'Up towards the face like a salute',
        'Down towards the ground',
        'Accross the chest',
        'Straight towards the shot',
      ],
    },
    {
      'question': 'Creating topspin is a defensive strategy.',
      'correctAnswer': 1,
      'userAnswer': -1,
      'answers': [
        'True',
        'False',
      ],
    },
    {
      'question': 'To create backspin the ball should be hit on top.',
      'correctAnswer': 1,
      'userAnswer': -1,
      'answers': [
        'True',
        'False',
      ],
    },
    {
      'question': 'To create topspin the ball should be hit on top.',
      'correctAnswer': 0,
      'userAnswer': -1,
      'answers': [
        'True',
        'False',
      ],
    },
    {
      'question': 'A defensive move in table tennis is the',
      'correctAnswer': 0,
      'userAnswer': -1,
      'answers': [
        'Block',
        'Push',
        'Loop',
        'Topspin',
      ],
    },
    {
      'question': 'A foul in table tennis is',
      'correctAnswer': 3,
      'userAnswer': -1,
      'answers': [
        'Touching the table',
        'Cupping the ball while serving',
        'Toucing the net',
        'All of the above',
      ],
    },
  ];
  bool isShowCorrectAndInCorrenctAnswers = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: UnFocusable(
        child: Scaffold(
          backgroundColor: Colors.white,
          extendBodyBehindAppBar: true,
          body: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16.0, 92.0, 16.0, 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Texts.mainTitle,
                  style: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontSize: 32.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12.0),
                Text(
                  Texts.mainDescription,
                  style: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 32.0),
                ...List.generate(
                  questionsAndAnswers.length,
                  (index) {
                    final item = questionsAndAnswers.elementAt(index);
                    return Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: _Item(
                        index: index,
                        isShowCorrectAndInCorrenctAnswers:
                            isShowCorrectAndInCorrenctAnswers,
                        question: item['question'],
                        correctAnswer: item['correctAnswer'],
                        userAnswer: item['userAnswer'],
                        answers: item['answers'],
                        onSelectItem: (String question, int index) {
                          setState(() {
                            questionsAndAnswers = questionsAndAnswers
                                .map<Map<String, dynamic>>((e) {
                              if (e['question'] == question) {
                                e['userAnswer'] = index;
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
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isShowCorrectAndInCorrenctAnswers =
                            !isShowCorrectAndInCorrenctAnswers;
                      });
                    },
                    child: Text(
                      'Submit',
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 20.0,
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
    required this.isShowCorrectAndInCorrenctAnswers,
    required this.question,
    required this.correctAnswer,
    required this.userAnswer,
    required this.answers,
    required this.onSelectItem,
  });

  final int index;
  final bool isShowCorrectAndInCorrenctAnswers;
  final String question;
  final int correctAnswer;
  final int userAnswer;
  final List<String> answers;
  final void Function(String, int) onSelectItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${index + 1}. $question',
          style: GoogleFonts.montserrat(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8.0),
        ...List.generate(answers.length, (i) {
          final answer = answers.elementAt(i);

          return CheckboxListTile(
            value: i == userAnswer,
            tileColor: isShowCorrectAndInCorrenctAnswers
                ? (userAnswer == correctAnswer && i == correctAnswer) ||
                        i == correctAnswer
                    ? Colors.greenAccent
                    : i == userAnswer
                        ? Colors.redAccent
                        : Colors.transparent
                : Colors.transparent,
            title: Text(
              answer,
              style: GoogleFonts.montserrat(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            visualDensity: VisualDensity.compact,
            onChanged: (bool? value) => onSelectItem(question, i),
          );
        }),
      ],
    );
  }
}
