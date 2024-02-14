import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:writing_test/model/Lesson.dart';
import 'package:writing_test/model/Student.dart';
import 'package:writing_test/model/School.dart';

class MockStudent extends Mock implements Student {
  @override
  List<Lesson> lessons = [];

  @override
  List<Lesson> addLesson(Lesson lesson) {
    lessons.add(lesson);
    return lessons;
  }

  @override
  List<Lesson> removeLesson(Lesson lesson) {
    lessons.remove(lesson);
    return lessons;
  }
}

class MockLesson extends Mock implements Lesson {
  @override
  late String name;

  @override
  MockLesson();

  @override
  MockLesson.withName(String name);
}

class MockSchool extends Mock implements School {}

void main(){

  late Student mockStudent;
  late Lesson mockLesson;
  late School mockSchool;

  setUp(() {
    mockStudent = MockStudent();
    mockLesson = MockLesson();
    mockSchool = MockSchool();
  });

  group("tests to mockStudent methods ", () {
    test("username method should return the user name of the mockStudent", () {
      //Arrange
      mockStudent.firstName = "Tuğçe";
      mockStudent.lastName = "Kepen";

      when(() => mockStudent.username()).thenReturn("tugcekepen");
      
      //Assert
      expect(mockStudent.username(), "tugcekepen");
    });

    test("toString method should return the full name of the mockStudent", () {
      //Arrange
      mockStudent.firstName = "Ali";
      mockStudent.lastName = "Yılmaz";

      when(() => mockStudent.fullName()).thenReturn("Ali Yılmaz");

      //Assert
      expect(mockStudent.fullName(), "Ali Yılmaz");
    });

    // test("studentInfo()", () {
    //   //Arrange
    //   mockSchool.name = "Samsun Üniversitesi";

    //   List<String> lessonNames = ["Mobil Programlama", "Yapay Zeka", "Görüntü İşleme"];
    //   List<int> lessonCredits = [3, 5, 4];
    //   List<double> firstExamPoints = [80, 70, 90];
    //   List<double> secondExamPoints = [90, 60, 85];

    //   for(String lesson in lessonNames){
    //     mockLessons.add(Lesson.withName(lesson));
    //   }

    //   for(int i=0; i<lessonNames.length; i++){
    //     mockLessons[i].credit = lessonCredits[i];
    //     mockLessons[i].firstExamPoint = firstExamPoints[i];
    //     mockLessons[i].secondExamPoint = secondExamPoints[i];
    //   }

    //   mockStudent.firstName = "Tuğçe";
    //   mockStudent.lastName = "Kepen";
    //   mockStudent.school = mockSchool;
    //   mockStudent.degree = "Lisans";
    //   mockStudent.schoolClass = 3;

    //   //Act
    //   when(() => mockStudent.studentInfo()).thenReturn("Tuğçe Kepen Samsun Üniversitesi Lisans 3 77");
    
    //   final studentInfo = mockStudent.studentInfo();

    //   //Assert
    //   expect(studentInfo, "Tuğçe Kepen Samsun Üniversitesi Lisans 3 77");
    // });

    // test("addLesson() should add a lesson to the student's lessons", () {
    //   //Arrange
    //   mockLesson.name = "Mobil Programlama";

    //   //Act
    //   when(() => mockStudent.addLesson(mockLesson)).thenAnswer((_) {
    //     mockLessons.add(mockLesson);
    //     return; // Stubbing a void method
    //   });

    //   mockStudent.addLesson(mockLesson);

    //   //Assert
    //   expect(mockLessons.first.name, "Mobil Programlama");
    // });

    test("removeLesson() should remove a lesson from the students's lessons", () {
      List<String> lessonNames = ["Mobil Programlama", "Yapay Zeka", "Görüntü İşleme"];

      for(int i=0; i<lessonNames.length; i++){
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
      List<Lesson> mockLessons = [Lesson.withName("Mobil Programlama"), Lesson.withName("Yapay Zeka")];
      final mockStudent = Student.full("Zafer", "Dağ", school, "Ön Lisans", 3, "Bahar Dönemi", mockLessons);

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
        List<Lesson> mockLessons = [Lesson.withName("Mobil Programlama"), Lesson.withName("Yapay Zeka")];
        mockLessons[0].firstExamPoint = 80;
        mockLessons[0].secondExamPoint = 90;
        mockLessons[0].credit = 3;
        mockLessons[1].firstExamPoint = 70;
        mockLessons[1].secondExamPoint = 60;
        mockLessons[1].credit = 5;
        final mockStudent = Student.full("Zafer", "Dağ", school, "Ön Lisans", 3, "Bahar Dönemi", mockLessons);

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

        expect(mockStudent.gano, isNotNull); // çünkü constructor'da sınav notları 0.0 olarak tanımlanmışken
      });

    });
    

  });
}