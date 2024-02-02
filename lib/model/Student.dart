// ignore: file_names
import 'package:writing_test/model/School.dart';
import 'Lesson.dart';

class Student {
  static const int _counter = 0;
  static const int _totalCredit = 0;
  late int _id;
  late String _firstName;
  late String _lastName;
  late School _school;
  late String _degree;
  late int _schoolClass;
  late String _period;
  late List<Lesson> _lessons;
  int get lessonCount => _lessons.length;
  late double _gano;

  Student(String firstName, String lastName) {
    _id = _counter + 1;
    _firstName = firstName;
    _lastName = lastName;
  }

  Student.full(String firstName, String lastName, School school, String degree,
      int schoolClass, String period, double gano, List<Lesson> lessons) {
    _id = _counter + 1;
    _firstName = firstName;
    _lastName = lastName;
    _school = school;
    _degree = degree;
    _schoolClass = schoolClass;
    _period = period;
    _gano = gano;
    _lessons = lessons;
  }

  int get id => _id;

  String get firstName => _firstName;

  set firstName(String value) {
    if (_firstName.length >= 2) {
      _firstName = value;
    } else {
      throw ArgumentError('First name must be at least 2 characters long.');
    }
  }

  String get lastName => _lastName;

  set lastName(String value) {
    if (_lastName.length >= 2) {
      _lastName = value;
    } else {
      throw ArgumentError('Last name must be at least 2 characters long.');
    }
  }

  String get degree => _degree;

  set degree(String value) {
    if (School().degrees.any((degree) => degree == value)) {
      _degree = value;
    }
  }

  int get schoolClass => _schoolClass;

  set schoolClass(int value) {
    if (_schoolClass < 7 && _schoolClass > 0) {
      _schoolClass = value;
    }
  }

  String get period => _period;

  set period(String value) {
    if (School().periods.any((period) => period == value)) {
      _period = value;
    }
  }

  double get gano => _gano;

  set gano(double value) {
    double total = 0;
    if (_totalCredit > 0) {
      for (Lesson lesson in _lessons){
        total += lesson.point;
      }
      _gano = total / _totalCredit;
    } else {
      _gano = 0.0;
    }
  }

  // int totalCredit(int totalCredit){
  //   _totalCredit = totalCredit;
  //   for (Lesson lesson in _lessons){
  //     _totalCredit += lesson.credit;
  //   };
  //   return _totalCredit;
  // }

  School get school => _school;

  set school(School value) {
    if (_school.toString().length >= 2) {
      _school = value;
    } else {
      throw ArgumentError('First name must be at least 2 characters long.');
    }
  }

  List<Lesson> get lessons => _lessons;

  set lessons(List<Lesson> value) {
    if (value.length >= 2 && value.length <= 10) {
      _lessons = value;
    } else {
      throw ArgumentError('Number of lessons must be between 2 and 10.');
    }
  }

  @override
  String toString() {
    return "$_firstName $_lastName";
  }

  String username() {
    return "$_firstName$_lastName"
        .toLowerCase()
        .replaceAll('ı', 'i')
        .replaceAll('ğ', 'g')
        .replaceAll('ş', 's')
        .replaceAll('ç', 'c')
        .replaceAll('ü', 'u')
        .replaceAll('ö', 'o');
  }

  String studentInfo() {
    return "$_firstName $_lastName ${_school.name} $_degree $_schoolClass $_gano";
  }

  String studentSchoolInfo() {
    return "${_school.name} $_degree $_schoolClass";
  }

  int skippingClass() {
    if (_period == "Bahar Dönemi") {
      for (Lesson lesson in _lessons) {
        if (lesson.point >= 50) {
          _schoolClass++;
        }
      }
    }
    return _schoolClass;
  }

}
