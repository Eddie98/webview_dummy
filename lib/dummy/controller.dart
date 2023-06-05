import 'package:get/get.dart';

class Controller extends GetxController {
  final correctAnswersIdList = <int>[];

  final playersList = <Map<String, dynamic>>[
    {
      'id': 0,
      'image': 'assets/0.avif',
      'question': 'Who is this famous fighter?',
      'correctAnswer': 'Daniel Cormier',
      'options': [
        'Demetrious Johnson',
        'Brian Ortega',
        'Nate Diaz',
        'Daniel Cormier',
      ],
      'description':
          'Daniel Cormier made two U.S. Olympic teams for wrestling in 2004 and 2008 before switching to MMA. He became the rare UFC fighter to hold championship titles in both light heavyweight and heavyweight divisions at the same time, and by August 2018, Cormier was ranked as the number one pound-for-pound fighter in the UFC.',
    },
    {
      'id': 1,
      'image': 'assets/1.avif',
      'question': 'Who is this MMA athlete?',
      'correctAnswer': 'Conor McGregor',
      'options': [
        'Jon Jones',
        'Conor McGregor',
        'Stipe Miocic',
        'Anderson Silva',
      ],
      'description':
          'Irish fighter Conor McGregor is one of the most recognizable UFC fighters ever, both due to his skill in the ring and his antics out of the ring. He won featherweight and lightweight titles in 2015, and was ranked as the number two pound-for-pound fighter in the UFC in the summer of 2018.',
    },
    {
      'id': 2,
      'image': 'assets/2.avif',
      'question': 'Name this UFC star.',
      'correctAnswer': 'Max Holloway',
      'options': [
        'Brian Ortega',
        'Chuck Liddell',
        'Max Holloway',
        'Georges St. Pierre',
      ],
      'description':
          'Featherweight fighter Max Holloway made his UFC debut in 2012 -- the youngest UFC fighter on the roster at that time. Though he lost that first match, he went on to be ranked as the fourth best pound-for-pound fighter in the UFC by August 2018.',
    },
    {
      'id': 3,
      'image': 'assets/3.avif',
      'question': 'Do you know the name of this UFC icon?',
      'correctAnswer': 'George St. Pierres',
      'options': [
        'Nate Diaz',
        'TJ Dillashaw',
        'Robert Whittaker',
        'George St. Pierres',
      ],
      'description':
          'Canadian Georges St. Pierre has been one of the most successful welterweight fighters in UFC history. Though he vacated his middleweight title due to illness in 2017, he remained high in UFC pound-for-pound rankings in 2018.',
    },
    {
      'id': 4,
      'image': 'assets/4.avif',
      'question': 'Can you name the fighter in this image?',
      'correctAnswer': 'Demetrious Johnson',
      'options': [
        'Royce Gracie',
        'Daniel Cormier',
        'Demetrious Johnson',
        'Jon Jones',
      ],
      'description':
          'Demetrious Johnson was a successful MMA and cagefighter before moving to the UFC in 2011. He won his debut match in a unanimous decision, and became the inaugural champ in the UFC flyweight division.',
    },
    {
      'id': 5,
      'image': 'assets/5.avif',
      'question': 'Match this fighter to the correct name.',
      'correctAnswer': 'Tyron Woodley',
      'options': [
        'Chuck Liddell',
        'Tyron Woodley',
        'Conor McGregor',
        'Anderson Silva',
      ],
      'description':
          'Tyron Woodley was a Division I wrestler in college before moving to a career in MMA. He won the UFC welterweight championship at a July 2016 match in Atlanta, Georgia.',
    },
    {
      'id': 6,
      'image': 'assets/6.avif',
      'question': 'Pick the correct name of this mixed martial artist.',
      'correctAnswer': 'Stipe Miocic',
      'options': [
        'Stipe Miocic',
        'Randy Couture',
        'Brian Ortega',
        'Max Holloway',
      ],
      'description':
          'Stipe Miocic picked up the heavyweight championship title at UFC 198 in 2016. By July 2018, he was ranked number one in the UFC heavyweight rankings, and number eight on the organization\'s list of top pound-for-pound fighters.',
    },
    {
      'id': 7,
      'image': 'assets/7.avif',
      'question': 'Can you ID this UFC star?',
      'correctAnswer': 'Amanda Nunes',
      'options': [
        'Amanda Nunes',
        'Holly Holm',
        'Rhonda Rousey',
        'Nicco Montano',
      ],
      'description':
          'Amanda Nunes became the UFC bantamweight champion at UFC 200 in 2016 -- a title she went on to defend at least three times through summer 2018. In July 2018, she was listed as the 14th best pound-for-pound fighter within the UFC -- a list that includes both men and women.',
    },
    {
      'id': 8,
      'image': 'assets/8.avif',
      'question': 'Think you know the name of this fighter?',
      'correctAnswer': 'Jon Jones',
      'options': [
        'Demetrious Johnson',
        'Max Holloway',
        'Daniel Cormier',
        'Jon Jones',
      ],
      'description':
          'Jon Jones earned the light heavyweight championship title in 2011, and again in 2016. Despite a lot of success in the ring, his career has been threatened by both legal troubles and struggles with banned substances.',
    },
    {
      'id': 9,
      'image': 'assets/9.avif',
      'question': 'Can you name this UFC star?',
      'correctAnswer': 'Nicco Montano',
      'options': [
        'Cris Cyborg',
        'Nicco Montano',
        'Rhonda Rousey',
        'Rose Namajunas',
      ],
      'description':
          'Nicco Montano joined the UFC in 2017, and went on to become the inaugural flyweight champ. She defeated Roxanne Modafferi in a December 2017 match in Las Vegas to take the belt.',
    },
    {
      'id': 10,
      'image': 'assets/10.avif',
      'question': 'Which UFC star is this?',
      'correctAnswer': 'TJ Dillashaw',
      'options': [
        'Conor McGregor',
        'TJ Dillashaw',
        'Stipe Miocic',
        'Jon Jones',
      ],
      'description':
          'TJ Dillashaw wrestld for Cal State Fullerton before building a career in MMA. He was the UFC bantamweight champ in 2014, and again in 2017. By July 2018, he was ranked as the third best pound-for-pound fighter in the UFC.',
    },
    {
      'id': 11,
      'image': 'assets/11.avif',
      'question': 'Name this UFC athlete.',
      'correctAnswer': 'Khabib Nurmegomedov',
      'options': [
        'Demetrious Johnson',
        'Chuck Liddell',
        'Khabib Nurmegomedov',
        'Max Holloway',
      ],
      'description':
          'Russian fighter Khabib Nurmegomedov earned a black belt in judo before moving into MMA. He won the UFC lightweight title at UFC 223 in April 2018, making him the first Muslim fighter in UFC history to win a title.',
    },
  ];
}
