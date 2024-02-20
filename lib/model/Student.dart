// ignore_for_file: file_names

import 'package:writing_test/model/School.dart';
import 'Lesson.dart';

class Student {
  static int _counter = 0;
  late int id;
  late String _firstName;
  late String _lastName;
  late School _school;
  late String _degree;
  late int _schoolClass;
  late String _period;
  late List<Lesson> _lessons;
  int get lessonCount => _lessons.length;
  double get gano => _calculateGano();

  Student.withName(String firstName, String lastName) {
    id = ++_counter;
    _firstName = firstName;
    _lastName = lastName;
    _school = School.withName("Samsun Üniversitesi");
    _degree = "Lisans";
    _schoolClass = 1;
    _period = "Güz Dönemi";
    _lessons = [];
  }

  Student.full(String firstName, String lastName, School school, String degree,
      int schoolClass, String period, List<Lesson> lessons) {
    id = ++_counter;
    _firstName = firstName;
    _lastName = lastName;
    _school = school;
    _degree = degree;
    _schoolClass = schoolClass;
    _period = period;
    _lessons = lessons;
  }

  String get firstName => _firstName;

  set firstName(String value) {
    if (_firstName.length >= 2) {
      _firstName = value;
    } else {
      throw ArgumentError('Ad en az 2 karakter olmalıdır.');
    }
  }

  String get lastName => _lastName;

  set lastName(String value) {
    if (_lastName.length >= 2) {
      _lastName = value;
    } else {
      throw ArgumentError('Soyad en az 2 karakter olmalıdır.');
    }
  }

  String get degree => _degree;

  set degree(String value) {
    if (School.degrees.contains(value)) {
      _degree = value;
    } else {
      throw ArgumentError('Geçersiz derece.');
    }
  }

  int get schoolClass => _schoolClass;

  set schoolClass(int value) {
    if (value >= 0) {
      if (_degree == "Ön Lisans") {
        if (value >= 0 && value <= 4) {
          _schoolClass = value;
        } else {
          throw ArgumentError('Geçersiz sınıf değeri.');
        }
      } else if (_degree == "Lisans") {
        if (value >= 0 && value <= 7) {
          _schoolClass = value;
        } else {
          throw ArgumentError('Geçersiz sınıf değeri.');
        }
      } else if (_degree == "Yüksek Lisans") {
        if (value >= 0 && value <= 4) {
          _schoolClass = value;
        } else {
          throw ArgumentError('Geçersiz sınıf değeri.');
        }
      } else if (_degree == "Doktora") {
        if (value >= 0 && value <= 5) {
          _schoolClass = value;
        } else {
          throw ArgumentError('Geçersiz sınıf değeri.');
        }
      } else {
        throw ArgumentError('Geçersiz derece.');
      }
    } else {
      throw ArgumentError('Geçersiz sınıf değeri.');
    }
  }

  String get period => _period;

  set period(String value) {
    if (School.periods.contains(value)) {
      _period = value;
    } else {
      throw ArgumentError('Geçersiz dönem.');
    }
  }

  double _calculateGano() {
    double total = 0;
    int totalCredit = 0;

    for (Lesson lesson in _lessons) {
      total += lesson.point * lesson.credit;
      totalCredit += lesson.credit;
    }

    double gano = totalCredit > 0 ? (total / totalCredit) : 0.0;
    return gano;
  }

  int get totalCredit {
    int totalCredit = 0;
    for (Lesson lesson in _lessons) {
      totalCredit += lesson.credit;
    }
    return totalCredit;
  }

  School get school => _school;

  set school(School value) {
    if (_school.toString().length >= 2) {
      _school = value;
    } else {
      throw ArgumentError('Okul adı en az 2 karakter olmalıdır.');
    }
  }

  List<Lesson> get lessons => _lessons;

  set lessons(List<Lesson> value) {
    if (value.length <= 10) {
      _lessons = value;
      _calculateGano();
    } else {
      throw ArgumentError('Ders sayısı 10\'dan fazla olamaz.');
    }
  }

  void addLesson(Lesson lesson) {
    if (_lessons.length < 10) {
      _lessons.add(lesson);
      _calculateGano();
    } else {
      throw ArgumentError("Ders sayısı 10'u geçemez.");
    }
  }

  void removeLesson(Lesson lesson) {
    _lessons.remove(lesson);
    _calculateGano();
  }

  String fullName() {
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
    return "$_firstName $_lastName ${_school.name} $_degree $_schoolClass $gano";
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
