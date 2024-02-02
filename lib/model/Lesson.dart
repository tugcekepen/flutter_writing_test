class Lesson{
  late String _name;
  late int _credit;
  late double _firstExamPoint;
  late double _secondExamPoint;
  late double _point;

  Lesson(String name){
    _name = name;
  }

  String get name => _name;

  set name(String value){
    if(value.length >= 2){
      _name = value;
    } else {
      throw ArgumentError('Lesson name must be at least 2 characters long.');
    }
  }

  int get credit => _credit;

  set credit(int value){
    if(value>0){
      _credit = value;
    }
  }

  double get firstExamPoint => _firstExamPoint;

  set firstExamPoint(double value){
    if(value>=0 && value<=100){
      _firstExamPoint = value;
    }
  }

  double get secondExamPoint => _secondExamPoint;

  set secondExamPoint(double value){
    if(value>=0 && value<=100){
      _secondExamPoint = value;
    }
  }

  double get point => _point;

  set point(double value){
    if(value>=0 && value<=4){
      _point = value;
    }
  }
}