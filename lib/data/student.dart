import 'package:writing_test/data/lesson.dart';
import 'package:writing_test/data/school.dart';
import 'package:writing_test/model/School.dart';
import 'package:writing_test/model/Student.dart';

Student id_1 = Student.full("Tuğçe", "Başal", schools[0], "Lisans", 3, School.periods[0],
  [lessons[0], lessons[1], lessons[2], lessons[3], lessons[4], lessons[5]]);
Student id_2 = Student.full("Ali", "Yılmaz", schools[2], "Lisans", 1, School.periods[0],
  [lessons[3], lessons[4], lessons[5], lessons[1]]);
Student id_3 = Student.full("Mehmet", "Kaplan", schools[4], "Lisans", 2, School.periods[0],
  [lessons[5], lessons[6], lessons[7], lessons[8], lessons[2]]);
Student id_4 = Student.full("Ayşe", "Akyol", schools[1], "Lisans", 4, School.periods[0],
  [lessons[0], lessons[1], lessons[2], lessons[3], lessons[4], lessons[5], lessons[6], lessons[7]]);
Student id_5 = Student.full("Zafer", "Dağ", schools[5], "Lisans", 1, School.periods[0],
  [lessons[3], lessons[4], lessons[5], lessons[1]]);
Student id_6 = Student.full("Melike", "Turan", schools[3], "Lisans", 2, School.periods[0],
  [lessons[5], lessons[6], lessons[7], lessons[8], lessons[2]]);

List<Student> students = [id_1, id_2, id_3, id_4, id_5, id_6];