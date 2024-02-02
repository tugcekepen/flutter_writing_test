import 'package:flutter_test/flutter_test.dart';
import 'package:writing_test/model/Lesson.dart';
import 'package:writing_test/model/Student.dart';
import 'package:writing_test/model/School.dart';

void main(){
  group("tests to student methods ", () {
    test("username method should return the user name of the student", () {
      //Arrange
      final student = Student("Tuğçe", "Kepen");

      //Act
      String username = student.username();
      
      //Assert
      expect(username, "tugcekepen");
    });

    test("toString method should return the full name of the student", () {
      //Arrange
      final student = Student("Tuğçe", "Kepen");

      //Act
      String fullName = student.toString();

      //Assert
      expect(fullName, "Tuğçe Kepen");
    });

    test("schoolInfo()", () {
      //Arrange
      final school = School.withName("Samsun Üniversitesi");
      List<Lesson> lessons = [Lesson("Görüntü İşleme"), Lesson("Mobil Programlama"), Lesson("Yapay Zeka")];
      final student = Student.full("Tuğçe", "Kepen", school, "Lisans", 3, "Bahar Dönemi", 3.5, lessons);

      //Act
      String studentInfo = student.studentInfo();

      //Assert
      expect(studentInfo, "Tuğçe Kepen Samsun Üniversitesi Lisans 3 3.5");
    });
  });
}