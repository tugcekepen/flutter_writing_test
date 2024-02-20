import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:writing_test/model/Lesson.dart';
import 'package:writing_test/model/Student.dart';
import 'package:writing_test/model/School.dart';

class MockStudent extends Mock implements Student {
  @override
  late List<Lesson> lessons;
  @override
  List<Lesson> addLesson(Lesson lesson) {
    lessons.add(lesson);
    return lessons;
  }
}

void main() {
  late Student mockStudent;

  List<Lesson> lessons = [
    Lesson.withName("Görüntü İşleme"),
    Lesson.withName("Mobil Programlama"),
    Lesson.withName("Yapay Zeka")
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
      mockStudent.addLesson(Lesson.withName("Oyun Programlama"));

      expect(mockStudent.lessons.last.name, "Oyun Programlama");
    });

//-------

    // test("removeLesson() should remove a lesson from the student's lessons", () {
    //   Student student = Student.withName("Ali", "Yılmaz");

    //   //Act
    //   when(() => mockStudent.addLesson(mockLesson)).thenAnswer((_) {
    //     mockLessons.add(mockLesson);
    //     return; // Stubbing a void method
    //   });

    //   mockStudent.addLesson(mockLesson);

    //   //Assert
    //   expect(mockLessons.first.name, "Mobil Programlama");
    // });

    test("removeLesson() should remove a lesson from the students's lessons",
        () {
      List<String> lessonNames = [
        "Mobil Programlama",
        "Yapay Zeka",
        "Görüntü İşleme"
      ];

      for (int i = 0; i < lessonNames.length; i++) {
        mockStudent.addLesson(Lesson.withName(lessonNames[i]));
      }

      expect(mockStudent.lessons.length, 3);

      //when(() => mockStudent.removeLesson(mockStudent.lessons.last)).thenReturn(mockStudent.lessons);

      //mockStudent.removeLesson(Lesson("Mobil Programlama")); //Bu şekilde olmaz çünkü referanslar farklı olacak
      final removedLesson = mockStudent.lessons.last;
      mockStudent.removeLesson(removedLesson);

      expect(mockStudent.lessons.contains(removedLesson), isFalse);

      mockStudent.removeLesson(mockStudent.lessons.first);
      mockStudent.removeLesson(mockStudent.lessons.first);

      expect(mockStudent.lessons, isEmpty);
    });

    test("studentSchoolInfo() with Student.full() constructor", () {
      //Arrange
      final school = School.withName("Ondokuz Mayıs Üniversitesi");
      List<Lesson> lessons = [
        Lesson.withName("Mobil Programlama"),
        Lesson.withName("Yapay Zeka")
      ];
      final student = Student.full(
          "Zafer", "Dağ", school, "Ön Lisans", 3, "Bahar Dönemi", lessons);

      //Act
      String studentSchoolInfo = mockStudent.studentSchoolInfo();

      //Assert
      expect(studentSchoolInfo, "Ondokuz Mayıs Üniversitesi Ön Lisans 3");
    });

    test("studentSchoolInfo() with Student.withName() constructor", () {
      //Arrange
      final mockStudent = Student.withName("Tuğçe", "Kepen");

      //Act
      String studentSchoolInfo = mockStudent.studentSchoolInfo();

      //Assert
      expect(studentSchoolInfo, "Samsun Üniversitesi Lisans 1");
    });

    group("_calculateGano()", () {
      test("gano calculate with _calculateGano() in the background", () {
        //Arrange
        final school = School.withName("Ondokuz Mayıs Üniversitesi");
        List<Lesson> lessons = [
          Lesson.withName("Mobil Programlama"),
          Lesson.withName("Yapay Zeka")
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
        int gano = mockStudent.gano;

        //Assert
        expect(gano, 72.25);
      });

      test("if course grades are entered as 0", () {
        var lesson1 = Lesson.withName("Mobil Programlama");
        lesson1.firstExamPoint = 0;
        lesson1.secondExamPoint = 0;
        lesson1.credit = 3;

        var lesson2 = Lesson.withName("Yapay Zeka");
        lesson2.firstExamPoint = 0;
        lesson2.secondExamPoint = 0;
        lesson2.credit = 5;

        var mockStudent = Student.withName("Zafer", "Dağ");
        mockStudent.addLesson(lesson1);
        mockStudent.addLesson(lesson2);

        expect(mockStudent.gano, 0);
      });

      test("if course grades are null/empty", () {
        var lesson1 = Lesson.withName("Mobil Programlama");
        lesson1.credit = 3;

        var lesson2 = Lesson.withName("Yapay Zeka");
        lesson2.credit = 5;

        var mockStudent = Student.withName("Zafer", "Dağ");
        mockStudent.addLesson(lesson1);
        mockStudent.addLesson(lesson2);

        expect(mockStudent.gano,
            isNotNull); // çünkü constructor'da sınav notları 0.0 olarak tanımlanmışken
      });
    });
  });
}
