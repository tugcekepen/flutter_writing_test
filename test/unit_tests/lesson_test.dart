import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:writing_test/model/Lesson.dart';

void main() {
  late Lesson lesson;
  late Lesson lessonWithName;

  setUp(() {
    lesson = Lesson();
    lessonWithName = Lesson.withName("Matematik");
  });

  group("lesson methods tests", () {
    test("lessonInfo - default ctr", () {
      expect(lesson.lessonInfo,
          "Ders adı: --, Kredi: 0, 1. Sınav: 0.0, 2. Sınav: 0.0, Ortalama: 0.00");
    });

    test("lessonInfo - withName ctr", () {
      expect(lessonWithName.name, "Matematik");
      expect(lessonWithName.lessonInfo,
          "Ders adı: Matematik, Kredi: 0, 1. Sınav: 0.0, 2. Sınav: 0.0, Ortalama: 0.00");
    });
    
    test("point, when fields are not 0", () {
      lesson.firstExamPoint = 40;
      lesson.secondExamPoint = 60;

      expect(lesson.point, 52.0);
    });

    test("lessonInfo - filled fields", () {
      lessonWithName.credit = 3;
      lessonWithName.firstExamPoint = 45;
      lessonWithName.secondExamPoint = 63;

      expect(lessonWithName.lessonInfo,
          "Ders adı: Matematik, Kredi: 3, 1. Sınav: 45.0, 2. Sınav: 63.0, Ortalama: 55.80");
    });
  });

  group("lesson class errors", () {
    test("name error", () {
      expect(() => lesson.name = "a", throwsArgumentError);
    });

    test("credit error", () {
      expect(() => lesson.credit = 0, throwsArgumentError);
      expect(() => lesson.credit = -1, throwsArgumentError);
    });

    test("firsExamPoint error", () {
      expect(() => lesson.firstExamPoint = -1, throwsArgumentError);
      expect(() => lesson.firstExamPoint = 101, throwsArgumentError);
    });

    test("secondExamPoint error", () {
      expect(() => lesson.secondExamPoint = -1, throwsArgumentError);
      expect(() => lesson.secondExamPoint = 101, throwsArgumentError);
    });
  });
}
