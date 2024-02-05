import 'package:flutter_test/flutter_test.dart';
import 'package:writing_test/model/School.dart';

void main(){
  group("School constructors", () {
    test("School.withName constructor", () {
      //Arrange
      final school = School.withName("Samsun Üniversitesi");

      //Act
      String name = school.name;

      //Assert
      expect(name, "Samsun Üniversitesi");
    });

    test("School.full constructor", () {
      //Arrange
      final school = School.full("Samsun Üniversitesi", "Samsun", 50000);

      //Act
      String name = school.name;
      String adress = school.adress;
      int studentCount = school.studentCount;

      //Assert
      expect(name, "Samsun Üniversitesi");
      expect(adress, "Samsun");
      expect(studentCount, isPositive);
    });

  });
  group("tests to school methods", () {
    test("schoolInfo()", () {
      //Arrange
      final school = School.withName("Samsun Anadolu Lisesi");
      school.adress = "Samsun";
      school.studentCount = 10000;

      //Assert
      expect(school.grade, equals("Üniversite"));

      //Act
      school.grade = "Lise";
  
      String info = school.schoolInfo();

      //Assert
      expect(info, "Okul: Samsun Anadolu Lisesi Türü: Lise Adresi: Samsun Öğrenci Sayısı: 10000");
    });

  });
  group("Errors in School class", () {
    test("School name cannot be less than 2 characters", () {
      School school = School();
      
      expect(() => school.name = "A", throwsA(isArgumentError));
    });

    test("School adress cannot be less than 3 characters", () {
      School school = School();
      
      expect(() => school.adress = "A", throwsA(isArgumentError));
    });

    test("Student count in school cannot be less than 1", () {
      School school =School.withName("Samsun Anadolu Lisesi");

      expect(() => School.full("Test School", "City", 0), throwsA(const TypeMatcher<ArgumentError>())); // Yol 1
      expect(() => school.studentCount = 0, throwsA(isArgumentError)); // Yol 2
    });

  });
}