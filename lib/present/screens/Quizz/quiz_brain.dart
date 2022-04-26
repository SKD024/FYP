import 'question.dart';

class QuizBrain {
  int _questionNumber = 0;

  final List<Question> _questionBank = [
    Question('The printing press was first invented by Gutenberg in Europe.', false),
    Question('Despite conventional wisdom, people are reading more today than they ever have', true),
    Question('With the rise of the Internet and other new media, the publishing industry is no longer a major worldwide industry.', false),
    Question('The trend to make books cheaper to print and easier to transport is unlikely to continue in the 21st century with print-on-demand and e-books.', false),
    Question('Sales of e-books now almost match the revenues generated from print books.', false),
    Question('There are more daily book readers today than there were 60 years ago.', false),
    Question(
        'Magazines generally target specialized audiences, with 225 market classifications according to one trade group.',
        true),
    Question(
        'The most sold book is the Bible.',
        true),
    Question(
        'The most expensive book in the world is ‘Remembrance of Things Past’.',
        false),
    Question(
        'The first ever story written was ‘The Epic of Gilgamesh’.',
        true),
    Question('The largest collection consists of 5 million books.', false),

    Question(
        'The longest book in the world is ‘the Codex Leicester’.',
        false),
  ];

  void nextQuestion() {
    if (_questionNumber < _questionBank.length - 1) {
      _questionNumber++;
    }
  }

  String getQuestionText() {
    return _questionBank[_questionNumber].questionText;
  }

  bool getCorrectAnswer() {
    return _questionBank[_questionNumber].questionAnswer;
  }

  bool isFinished() {
    if (_questionNumber >= _questionBank.length - 1) {
      return true;

    } else {
      return false;
    }
  }

  void reset() {
    _questionNumber = 0;
  }
}
