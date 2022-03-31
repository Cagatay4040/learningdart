class User {
  String? name;
  int? password;
  String? surname;
  String? username;

  User({this.name, this.password, this.surname, this.username});

  User.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    password = json['Password'];
    surname = json['Surname'];
    username = json['Username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['Password'] = this.password;
    data['Surname'] = this.surname;
    data['Username'] = this.username;
    return data;
  }
}
