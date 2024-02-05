import 'package:flutter_test/flutter_test.dart';
import 'package:writing_test/model/Lesson.dart';
import 'package:writing_test/model/Student.dart';
import 'package:writing_test/model/School.dart';

void main(){
  group("tests to student methods ", () {
    test("username method should return the user name of the student", () {
      //Arrange
      final student = Student.withName("Tuğçe", "Kepen");

      //Act
      String username = student.username();
      
      //Assert
      expect(username, "tugcekepen");
    });

    test("toString method should return the full name of the student", () {
      //Arrange
      final student = Student.withName("Tuğçe", "Kepen");

      //Act
      String fullName = student.toString();

      //Assert
      expect(fullName, "Tuğçe Kepen");
    });

    test("studentInfo()", () {
      //Arrange
      final school = School.withName("Samsun Üniversitesi");
      List<Lesson> lessons = [Lesson("Görüntü İşleme"), Lesson("Mobil Programlama"), Lesson("Yapay Zeka")];
      final student = Student.full("Tuğçe", "Kepen", school, "Lisans", 3, "Bahar Dönemi", lessons);

      //Act
      String studentInfo = student.studentInfo();

      //Assert
      expect(studentInfo, "Tuğçe Kepen Samsun Üniversitesi Lisans 3 3.5");
    });

    test("addLesson() should add a lesson to the student's lessons", () {
      Student student = Student.withName("Ali", "Yılmaz");

      var lessons = student.lessons;

      expect(lessons, isEmpty);
      expect(lessons.length, 0);

      student.addLesson(Lesson("Yapay Zeka"));

      expect(lessons.length, 1); //Uzunluğun kontrolü yol 1
      expect(lessons, hasLength(1)); //Uzunluğun kontrolü yol 2
      expect(lessons.first.name, "Yapay Zeka");
    });

    test("removeLesson() should remove a lesson from the student's lessons", () {
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
      List<Lesson> lessons = [Lesson("Mobil Programlama"), Lesson("Yapay Zeka")];
      final student = Student.full("Zafer", "Dağ", school, "Ön Lisans", 3, "Bahar Dönemi", lessons);

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
        List<Lesson> lessons = [Lesson("Mobil Programlama"), Lesson("Yapay Zeka")];
        lessons[0].firstExamPoint = 80;
        lessons[0].secondExamPoint = 90;
        lessons[0].credit = 3;
        lessons[1].firstExamPoint = 70;
        lessons[1].secondExamPoint = 60;
        lessons[1].credit = 5;
        final student = Student.full("Zafer", "Dağ", school, "Ön Lisans", 3, "Bahar Dönemi", lessons);

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

        expect(student.gano, isNotNull); // çünkü constructor'da sınav notları 0.0 olarak tanımlanmışken
      });

    });
    

  });
}