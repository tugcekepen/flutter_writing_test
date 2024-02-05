class School{
  late String _name;
  String grade = "Üniversite";
  late String _adress;
  late int _studentCount;
  static List<String> degrees = ["Ön Lisans", "Lisans", "Yüksek Lisans", "Doktora"];
  static List<String> periods = ["Güz Dönemi", "Bahar Dönemi"];

  School(){
    _name = "";
    _adress =  "";
    _studentCount = 1;
  }

  School.withName(String name){
    _name = name;
    _adress =  "";
    _studentCount = 1;
  }

  School.full(String name, String adress, int studentCount){
    _name = name;
    _adress = adress;
    if (studentCount > 0) {
      _studentCount = studentCount;
    } else {
      throw ArgumentError('Geçersiz öğrenci sayısı.');
    }
  }

  String get name => _name;

  set name(String value){
    if(value.length >= 2){
      _name = value;
    } else {
      throw ArgumentError('Okul adı en az 2 karakter olmalıdır.');
    }
  }

  int get studentCount => _studentCount;

  set studentCount(int value){
    if(value > 0){
      _studentCount = value;
    } else {
      throw ArgumentError('Geçersiz öğrenci sayısı.');
    }
  }

  String get adress => _adress;

  set adress(String value){
    if(value.length > 3){
      _adress = value;
    } else {
      throw ArgumentError('Adres en az 3 karakter olmalıdır.');
    }
  }

  String schoolInfo() {
    return "Okul: $name Türü: $grade Adresi: $adress Öğrenci Sayısı: $_studentCount";
  }
}