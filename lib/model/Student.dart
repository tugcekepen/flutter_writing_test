// ignore_for_file: file_names

import 'package:writing_test/model/School.dart';
import 'Lesson.dart';

class Student {
  static int _counter = 0;
  late int id;
  late String name;
  late String surname;
  late School school;
  late String degree;
  late int schoolClass;
  late String period;
  late List<Lesson> lessons;

  Student.withName(this.name, this.surname)
      : id = ++_counter,
        school = School.withName("Samsun Üniversitesi"),
        degree = "Lisans",
        schoolClass = 1,
        period = "Güz Dönemi",
        lessons = [];

  Student.full(this.name, this.surname, this.school, this.degree,
      this.schoolClass, this.period, this.lessons)
      : id = ++_counter;

  String get fullName => '$name $surname';

  String get username => '${name.toLowerCase()}${surname.toLowerCase()}'
      .replaceAll('ı', 'i')
      .replaceAll('ğ', 'g')
      .replaceAll('ş', 's')
      .replaceAll('ç', 'c')
      .replaceAll('ü', 'u')
      .replaceAll('ö', 'o');

  String get studentInfo =>
      'Adı: $name\nSoyadı: $surname\nOkul Adı: ${school.name}\nEğitim Düzeyi: $degree\nSınıfı: $schoolClass\nGano: $gano';

  String get studentSchoolInfo =>
      'Okul Adı: ${school.name}\nEğitim Düzeyi: $degree\nSınıfı: $schoolClass';

  int get lessonCount => lessons.length;

  int get totalCredit =>
      lessons.map((lesson) => lesson.credit).reduce((a, b) => a + b);

  int get gano => _calculateGano();

  int _calculateGano() {
    double total = 0;
    int totalCredit = 0;

    for (Lesson lesson in lessons) {
      total += lesson.point * lesson.credit;
      totalCredit += lesson.credit;
    }

    double gano = totalCredit > 0 ? (total / totalCredit) : 0.0;
    return gano.round();
  }

  setLessons(List<Lesson> value) {
    if (value.length <= 10) {
      lessons = value;
      _calculateGano();
    } else {
      throw ArgumentError('Ders sayısı 10\'dan fazla olamaz!');
    }
  }

  List<Lesson> addLesson(Lesson lesson) {
    if (lessons.length < 10) {
      lessons.add(lesson);
      _calculateGano();
      return lessons;
    } else {
      throw ArgumentError('Ders sayısı 10\'u geçemez!');
    }
  }

  List<Lesson> removeLesson(Lesson lesson) {
    if (lessons.isEmpty) {
      throw ArgumentError(
          'Öğrencinin dersi bulunmamaktadır. Ders çıkarılamaz!');
    }
    if (!lessons.contains(lesson)) {
      throw ArgumentError(
          'Öğrencinin bu dersi bulunmamaktadır. Ders çıkarılamaz!');
    }
    lessons.remove(lesson);
    _calculateGano();
    return lessons;
  }

  int skippingClass() {
    if (period == "Bahar Dönemi") {
      if (gano >= 50) {
        schoolClass = schoolClass + 1;
      }
    }
    return schoolClass;
  }

  @override
  String toString() {
    return '$name $surname';
  }
}
