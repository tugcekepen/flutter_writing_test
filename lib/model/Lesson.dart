class Lesson{
  late String _name;
  late int _credit;
  late double _firstExamPoint;
  late double _secondExamPoint;

  Lesson(String name) {
    _name = name;
    _credit = 0;
    _firstExamPoint = 0.0;
    _secondExamPoint = 0.0;
  }

  String get name => _name;

  set name(String value){
    if(value.length >= 2){
      _name = value;
    } else {
      throw ArgumentError('Ders adı en az 2 karakter olmalıdır.');
    }
  }

  int get credit => _credit;

  set credit(int value){
    if(value>0){
      _credit = value;
    } else {
      throw ArgumentError('Geçersiz kredi değeri.');
    }
  }

  double get firstExamPoint => _firstExamPoint;

  set firstExamPoint(double value){
    if(value>=0 && value<=100){
      _firstExamPoint = value;
    } else {
      throw ArgumentError('Geçersiz sınav puanı.');
    }
  }

  double get secondExamPoint => _secondExamPoint;

  set secondExamPoint(double value){
    if(value>=0 && value<=100){
      _secondExamPoint = value;
    } else {
      throw ArgumentError('Geçersiz sınav puanı.');
    }
  }

  double get point {
    return (_firstExamPoint*0.4 + _secondExamPoint*0.6);
  }
}