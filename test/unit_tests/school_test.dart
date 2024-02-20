import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:writing_test/model/School.dart';

class MockSchool extends Mock implements School {
  @override
  String get name => "Samsun Anadolu Lisesi";

  @override
  String get adress => "Samsun";

  @override
  int get studentCount => 10000;

  @override
  String get grade => "Lise";
}

void main() {
  late School mockSchool;

  setUp(() {
    mockSchool = MockSchool();
  });

  group("School constructors", () {
    test("School.withName constructor", () {
      final realSchool = School.withName("Samsun Üniversitesi");

      expect(realSchool.name, "Samsun Üniversitesi");
    });

    test("School.full constructor", () {
      //Arrange
      final realSchool = School.full("Samsun Üniversitesi", "Samsun", 50000);

      //Act
      String name = realSchool.name;
      String adress = realSchool.adress;
      int studentCount = realSchool.studentCount;

      //Assert
      expect(name, "Samsun Üniversitesi");
      expect(adress, "Samsun");
      expect(studentCount, isPositive);
    });
  });
  group("tests to school methods", () {
    test("schoolInfo()", () {
      // when(() => school.schoolInfo()).thenReturn(
      //     "Okul: Samsun Anadolu Lisesi Türü: Lise Adresi: Samsun Öğrenci Sayısı: 10000");
      when(() => mockSchool.schoolInfo()).thenAnswer((_) {
        return "Okul: ${mockSchool.name} Türü: ${mockSchool.grade} Adresi: ${mockSchool.adress} Öğrenci Sayısı: ${mockSchool.studentCount}";
      });

      expect(mockSchool.schoolInfo(),
          "Okul: Samsun Anadolu Lisesi Türü: Lise Adresi: Samsun Öğrenci Sayısı: 10000");
    });
  });
  group("Errors in School class", () {
    test("School name cannot be less than 2 characters", () {
      School realSchool = School();

      expect(() => realSchool.name = "A", throwsA(isArgumentError));
    });

    test("School adress cannot be less than 3 characters", () {
      School realSchool = School();

      expect(() => realSchool.adress = "A", throwsA(isArgumentError));
    });

    test("Student count in school cannot be less than 1", () {
      School school = School.withName("Samsun Anadolu Lisesi");

      expect(() => School.full("Test School", "City", 0),
          throwsA(const TypeMatcher<ArgumentError>())); // Yol 1
      expect(() => school.studentCount = 0, throwsA(isArgumentError)); // Yol 2
    });
  });
}
