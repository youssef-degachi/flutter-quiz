import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeProPage(),
    );
  }
}

class HomeProPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Pro Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => QuestionPage()),
            );
          },
          child: Text('Welcome'),
        ),
      ),
    );
  }
}

class QuestionPage extends StatefulWidget {
  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  String selectedLanguage = '';
  String selectedCard = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose the Language'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'What language do you want to use?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  selectedLanguage = 'Arabic';
                });
              },
              child: Text('Arabic'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  selectedLanguage = 'French';
                });
              },
              child: Text('French'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  selectedLanguage = 'English';
                });
              },
              child: Text('English'),
            ),
            SizedBox(height: 30),
            if (selectedLanguage.isNotEmpty)
              Column(
                children: [
                  Text(
                    'Select the correct answer:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => QuizPage(selectedLanguage)),
                      );
                    },
                    child: Text('Start Quiz'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  final String language;

  QuizPage(this.language);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Question> questions = [
    Question('What is 2 + 2?', ['3', '4', '5'], '4'),
    Question('What is the capital of France?', ['Berlin', 'Madrid', 'Paris'], 'Paris'),
    Question('What color do you get when you mix red and white?', ['Pink', 'Purple', 'Orange'], 'Pink'),
    // Add more questions here
  ];
  
  int currentQuestionIndex = 0;
  int score = 0;

  void answerQuestion(String answer) {
    if (answer == questions[currentQuestionIndex].correctAnswer) {
      score++;
    }

    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      // Navigate to the result page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ResultPage(score, questions.length)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz (${widget.language})'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(questions[currentQuestionIndex].question, style: TextStyle(fontSize: 20)),
          SizedBox(height: 20),
          ...questions[currentQuestionIndex].answers.map((answer) {
            return ElevatedButton(
              onPressed: () => answerQuestion(answer),
              child: Text(answer),
            );
          }).toList(),
        ],
      ),
    );
  }
}

class ResultPage extends StatelessWidget {
  final int score;
  final int totalQuestions;

  ResultPage(this.score, this.totalQuestions);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Result'),
      ),
      body: Center(
        child: Text(
          'Your score: $score out of $totalQuestions',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class Question {
  String question;
  List<String> answers;
  String correctAnswer;

  Question(this.question, this.answers, this.correctAnswer);
}