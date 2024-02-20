import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:writing_test/model/Person.dart';

class MockPerson extends Mock implements Person {
  MockPerson();

  MockPerson.full(String name, int age) {
    this.name = name;
    this.age = age;
  }
}

void main() {
  group('Person Test', () {
    test('Constructor should initialize fields correctly 1', () {
      // Arrange
      final person = Person.full('John', 30);

      // Assert
      expect(person.name, 'John');
      expect(person.age, 30);
    });

    test('Constructor should initialize fields correctly 2', () {
      const String expectedName = 'John';
      const int expectedAge = 30;
      Person mockPerson = MockPerson.full(expectedName, expectedAge);

      when(() => mockPerson.name).thenReturn(expectedName);
      when(() => mockPerson.age).thenReturn(expectedAge);

      // Assert
      expect(mockPerson.name, 'John');
      expect(mockPerson.age, 30);
    });

    test('Constructor should initialize fields correctly 3', () {
      Person mockPerson = MockPerson();

      when(() => mockPerson.name).thenReturn('John');
      when(() => mockPerson.age).thenReturn(30);

      // Assert
      expect(mockPerson.name, 'John');
      expect(mockPerson.age, 30);
    });
  });
}
