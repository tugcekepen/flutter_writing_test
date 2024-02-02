class School{
  late String _name;
  String grade = "Ünivesite";
  late String _adress;
  late int _studentCount;
  List<String> degrees = ["Ön Lisans", "Lisans", "Yüksek Lisans", "Doktora"];
  List<String> periods = ["Güz Dönemi", "Bahar Dönemi"];

  School();

  School.withName(String name){
    _name = name;
  }

  School.full(String name, String adress, int studentCount){
    _name = name;
    _adress = adress;
    _studentCount = studentCount;
  }

  String get name => _name;

  set name(String value){
    if(value.length>2){
      _name = value;
    }
  }

  int get studentCount => _studentCount;

  set studentCount(int value){
    if(value>0){
      _studentCount = value;
    }
  }

  String get adress => _adress;

  set adress(String value){
    if(value.length>3){
      adress = value;
    }
  }

  String schoolInfo() {
    return "Okul: $name Türü: $grade Adresi: $adress Öğrenci Sayısı: $_studentCount";
  }
}