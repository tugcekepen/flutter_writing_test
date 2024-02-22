import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:writing_test/model/Lesson.dart';
import 'package:writing_test/model/Student.dart';
import 'package:writing_test/model/School.dart';

class MockStudent extends Mock implements Student {
  @override
  List<Lesson> lessons = [];
  @override
  int get lessonCount => lessons.length;
  @override
  int get totalCredit =>
      lessons.map((lesson) => lesson.credit).reduce((a, b) => a + b);
}

class MockLesson extends Mock implements Lesson {
  @override
  double get point => firstExamPoint * 0.4 + secondExamPoint * 0.6;
}

class MockSchool extends Mock implements School {}

void main() {
  late Student student;
  late Student mockStudent;
  late School mockSchool;

  Lesson createMockLesson(
      String name, int credit, double firstExamPoint, double secondExamPoint) {
    final createdMockLesson = MockLesson();
    when(() => createdMockLesson.name)
        .thenReturn(name); // MockLesson'in name özelliğini ayarla
    when(() => createdMockLesson.credit)
        .thenReturn(credit); // MockLesson'in credit özelliğini ayarla
    when(() => createdMockLesson.firstExamPoint).thenReturn(
        firstExamPoint); // MockLesson'in firstExamPoint özelliğini ayarla
    when(() => createdMockLesson.secondExamPoint).thenReturn(
        secondExamPoint); // MockLesson'in secondExamPoint özelliğini ayarla
    return createdMockLesson;
  }

  setUp(() {
    student = Student.withName("Ali", "Yılmaz");
    mockStudent = MockStudent();
    mockSchool = MockSchool();
  });

  setUpAll(() {
    registerFallbackValue(MockLesson());
  });

  group("tests to student methods ", () {
    test("username method should return the user name of the student", () {
      when(() => mockStudent.username).thenReturn("aliyilmaz");

      expect(student.username, "aliyilmaz");
    });

    test("fullName method should return the full name of the student", () {
      when(() => mockStudent.fullName).thenReturn("Ali Yılmaz");

      expect(student.fullName, "Ali Yılmaz");
    });

    test("studentSchoolInfo", () {
      when(() => mockSchool.name).thenReturn("Samsun Üniversitesi");
      when(() => mockStudent.degree).thenReturn("Lisans");
      when(() => mockStudent.schoolClass).thenReturn(1);

      when(() => mockStudent.studentSchoolInfo)
          .thenReturn("Samsun Üniversitesi Lisans 1");

      expect(student.studentSchoolInfo, "Samsun Üniversitesi Lisans 1");
    });

    group("addLesson()", () {
      test('addLesson() should add lesson to lessons list', () {
        final initialLength = student.lessons.length;
        final expectedLength = initialLength + 1;

        final mockLesson = createMockLesson("Mobil Programlama", 3, 80, 90);

        when(() => mockStudent.addLesson(any(that: isA<Lesson>())))
            .thenAnswer((invocation) {
          mockStudent.lessons
              .add(invocation.positionalArguments.first as Lesson);
          return mockStudent.lessons;
        });

        student.addLesson(mockLesson);

        expect(student.lessons.length, equals(expectedLength));
      });

      test(
          'addLesson() should throw ArgumentError when lesson count exceeds 10',
          () {
        final mockLesson = createMockLesson("Mobil Programlama", 3, 80, 90);

        // Öğrenciye 10 ders ekleyelim
        for (var i = 0; i < 10; i++) {
          student.addLesson(mockLesson);
        }

        // 11. dersi eklemeye çalışalım, bunun bir ArgumentError fırlatması gerekiyor
        expect(() => student.addLesson(mockLesson), throwsArgumentError);
      });
    });

    group("setLessons()", () {
      test("setLessons() should add lessons list to lessons list", () {
        final mockLesson1 = createMockLesson("Mobil Programlama", 3, 80, 90);
        final mockLesson2 = createMockLesson("Yapay Zeka", 4, 60, 70);

        final lessons = [mockLesson1, mockLesson2];

        when(() => mockStudent.setLessons(any(that: isA<List<Lesson>>())))
            .thenAnswer((invocation) => mockStudent.lessons =
                invocation.positionalArguments.first as List<Lesson>);

        student.setLessons(lessons);

        expect(student.lessons, lessons);
      });

      test(
          'setLessons() should throw ArgumentError when lesson count exceeds 10',
          () {
        final mockLesson = createMockLesson("Mobil Programlama", 3, 80, 90);

        final lessons = [
          mockLesson,
          mockLesson,
          mockLesson,
          mockLesson,
          mockLesson,
          mockLesson,
          mockLesson,
          mockLesson,
          mockLesson,
          mockLesson,
          mockLesson
        ]; // 11 ders

        // 11 tane dersi eklemeye çalışalım, bunun bir ArgumentError fırlatması gerekiyor
        expect(() => student.setLessons(lessons), throwsArgumentError);
      });
    });

    test("gano", () {
      final mockLesson1 = createMockLesson("Mobil Programlama", 3, 80, 90);
      final mockLesson2 = createMockLesson("Yapay Zeka", 4, 60, 70);

      student.addLesson(mockLesson1);
      student.addLesson(mockLesson2);

      when(() => mockStudent.gano).thenReturn(75); // gano: 74,571'den 75 olmalı

      expect(student.gano, 75);
    
    });

    test("studentInfo", () {
      final mockLesson = createMockLesson("Mobil Programlama", 3, 80, 90);

      student.addLesson(mockLesson);

      when(() => mockStudent.studentInfo)
          .thenReturn("Ali Yılmaz Samsun Üniversitesi Lisans 1 86");

      expect(student.studentInfo, "Ali Yılmaz Samsun Üniversitesi Lisans 1 86");
    });

    test("lessonCount", () {
      final mockLesson1 = createMockLesson("Mobil Programlama", 3, 80, 90);
      final mockLesson2 = createMockLesson("Yapay Zeka", 4, 60, 70);

      student.addLesson(mockLesson1);
      student.addLesson(mockLesson2);

      expect(student.lessonCount, 2);
    });

    test("totalCredit", () {
      final mockLesson1 = createMockLesson("Mobil Programlama", 3, 80, 90);
      final mockLesson2 = createMockLesson("Yapay Zeka", 4, 60, 70);

      student.addLesson(mockLesson1);
      student.addLesson(mockLesson2);

      // totalCredit hesaplaması doğru olmalı
      expect(student.totalCredit, 7);
    });

    group("removeLesson()", () {
      test('removeLesson should remove lesson to lessons list', () {
        final mockLesson = createMockLesson("Mobil Programlama", 3, 80, 90);
        student.addLesson(mockLesson);

        final initialLength = student.lessons.length;
        final expectedLength = initialLength - 1;

        when(() => mockStudent.removeLesson(any(that: isA<Lesson>())))
            .thenAnswer((invocation) {
          mockStudent.lessons
              .remove(invocation.positionalArguments.first as Lesson);
          return mockStudent.lessons;
        });

        student.removeLesson(mockLesson);

        expect(student.lessons.length, equals(expectedLength));
      });

      test("removeLesson() method should throw an error when there are no lessons left.", () {
        final mockLesson = createMockLesson("Mobil Programlama", 3, 80, 90);

        expect(() => student.removeLesson(mockLesson), throwsArgumentError);
      });

      test("removeLesson() method should throw an error when trying to remove a lesson that the student doesn't have.", () {
        final mockLesson1 = createMockLesson("Mobil Programlama", 3, 80, 90);
        final mockLesson2 = createMockLesson("Yapay Zeka", 4, 60, 70);

        student.addLesson(mockLesson1);

        expect(() => student.removeLesson(mockLesson2), throwsArgumentError);
      });
    });

    test("skippingClass()", () {
      final beforeClass = student.schoolClass; // Öğrencinin sınıfı 1
      final afterClass = beforeClass + 1; // 2. sınıfa geçmesi gerekiyor

      final mockLesson1 = createMockLesson("Mobil Programlama", 3, 80, 90);
      final mockLesson2 = createMockLesson("Yapay Zeka", 4, 60, 70);

      student.addLesson(mockLesson1);
      student.addLesson(mockLesson2);

      student.period = "Bahar Dönemi"; // Sınıf atlaması için dönem Bahar olmalı

      student.skippingClass();

      expect(student.schoolClass, afterClass);
    });
  });
}
