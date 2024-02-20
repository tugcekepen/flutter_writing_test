import 'package:flutter_test/flutter_test.dart';
import 'package:writing_test/model/Lesson.dart';
import 'package:writing_test/model/Student.dart';
import 'package:writing_test/model/School.dart';
import 'package:mocktail/mocktail.dart';

class MockStudent extends Mock implements Student {
  @override
  late List<Lesson> lessons;
  @override
  void addLesson(Lesson lesson) {
    lessons.add(lesson);
  }
}

void main() {
  late Student mockStudent;

  List<Lesson> lessons = [
    Lesson("Görüntü İşleme"),
    Lesson("Mobil Programlama"),
    Lesson("Yapay Zeka")
  ];

  lessons[0].credit = 3;
  lessons[0].firstExamPoint = 80;
  lessons[0].secondExamPoint = 90;
  lessons[1].credit = 4;
  lessons[1].firstExamPoint = 70;
  lessons[1].secondExamPoint = 60;
  lessons[2].credit = 5;
  lessons[2].firstExamPoint = 90;
  lessons[2].secondExamPoint = 100;

  setUp(() {
    mockStudent = MockStudent();
    mockStudent.firstName = "Ali";
    mockStudent.lastName = "Yılmaz";
    mockStudent.school = School.withName("Samsun Üniversitesi");
    mockStudent.degree = "Lisans";
    mockStudent.schoolClass = 1;
    mockStudent.period = "Güz Dönemi";
    mockStudent.lessons = lessons;
  });

  group("tests to student methods ", () {
    test("username method should return the user name of the student", () {
      when(() => mockStudent.username()).thenReturn("aliyilmaz");

      expect(mockStudent.username(), "aliyilmaz");
    });

    test("toString method should return the full name of the student", () {
      when(() => mockStudent.fullName()).thenReturn("Ali Yılmaz");

      expect(mockStudent.fullName(), "Ali Yılmaz");
    });

    test("studentInfo()", () {
      when(() => mockStudent.studentInfo())
          .thenReturn("Ali Yılmaz Samsun Üniversitesi Lisans 1 83");

      //Assert
      expect(mockStudent.studentInfo(),
          "Ali Yılmaz Samsun Üniversitesi Lisans 1 83");
    });

    test("addLesson() should add a lesson to the student's lessons", () {
      mockStudent.addLesson(Lesson("Oyun Programlama"));

      expect(mockStudent.lessons.last.name, "Oyun Programlama");
    });

//-------

    test("removeLesson() should remove a lesson from the student's lessons",
        () {
      Student student = Student.withName("Ali", "Yılmaz");

      student.addLesson(Lesson("Yapay Zeka"));
      student.addLesson(Lesson("Mobil Programlama"));
      student.addLesson(Lesson("Görüntü İşleme"));

      var lessons = student.lessons;

      expect(lessons.length, 3);

      //student.removeLesson(Lesson("Mobil Programlama")); //Bu şekilde olmaz çünkü referanslar farklı olacak
      student.removeLesson(student.lessons.last);

      var lessonNames = lessons.map((e) => e.name).toList();

      expect(lessons.length, 2);
      expect(lessonNames.contains("Görüntü İşleme"), isFalse);

      student.removeLesson(lessons.first);
      student.removeLesson(lessons.first);

      expect(lessons.length, 0);
      expect(lessons, []);
    });

    test("studentSchoolInfo() with Student.full() constructor", () {
      //Arrange
      final school = School.withName("Ondokuz Mayıs Üniversitesi");
      List<Lesson> lessons = [
        Lesson("Mobil Programlama"),
        Lesson("Yapay Zeka")
      ];
      final student = Student.full(
          "Zafer", "Dağ", school, "Ön Lisans", 3, "Bahar Dönemi", lessons);

      //Act
      String studentSchoolInfo = student.studentSchoolInfo();

      //Assert
      expect(studentSchoolInfo, "Ondokuz Mayıs Üniversitesi Ön Lisans 3");
    });

    test("studentSchoolInfo() with Student.withName() constructor", () {
      //Arrange
      final student = Student.withName("Tuğçe", "Kepen");

      //Act
      String studentSchoolInfo = student.studentSchoolInfo();

      //Assert
      expect(studentSchoolInfo, "Samsun Üniversitesi Lisans 1");
    });

    group("_calculateGano()", () {
      test("gano calculate with _calculateGano() in the background", () {
        //Arrange
        final school = School.withName("Ondokuz Mayıs Üniversitesi");
        List<Lesson> lessons = [
          Lesson("Mobil Programlama"),
          Lesson("Yapay Zeka")
        ];
        lessons[0].firstExamPoint = 80;
        lessons[0].secondExamPoint = 90;
        lessons[0].credit = 3;
        lessons[1].firstExamPoint = 70;
        lessons[1].secondExamPoint = 60;
        lessons[1].credit = 5;
        final student = Student.full(
            "Zafer", "Dağ", school, "Ön Lisans", 3, "Bahar Dönemi", lessons);

        //Act
        double gano = student.gano;

        //Assert
        expect(gano, 72.25);
      });

      test("if course grades are entered as 0", () {
        var lesson1 = Lesson("Mobil Programlama");
        lesson1.firstExamPoint = 0;
        lesson1.secondExamPoint = 0;
        lesson1.credit = 3;

        var lesson2 = Lesson("Yapay Zeka");
        lesson2.firstExamPoint = 0;
        lesson2.secondExamPoint = 0;
        lesson2.credit = 5;

        var student = Student.withName("Zafer", "Dağ");
        student.addLesson(lesson1);
        student.addLesson(lesson2);

        expect(student.gano, 0);
      });

      test("if course grades are null/empty", () {
        var lesson1 = Lesson("Mobil Programlama");
        lesson1.credit = 3;

        var lesson2 = Lesson("Yapay Zeka");
        lesson2.credit = 5;

        var student = Student.withName("Zafer", "Dağ");
        student.addLesson(lesson1);
        student.addLesson(lesson2);

        expect(student.gano,
            isNotNull); // çünkü constructor'da sınav notları 0.0 olarak tanımlanmışken
      });
    });
  });
}
