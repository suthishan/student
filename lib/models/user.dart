class User {
  String _name;
  String _username;
  String _password;
  // String _flaglogged;
  String _age;
  String _degree;
  String _university;

  User(this._name, this._username, this._password, this._age, this._degree,
      this._university);

  User.map(dynamic obj) {
    this._name = obj['name'];
    this._username = obj['username'];
    this._password = obj['password'];
    // this._flaglogged = obj['flaglogged'];
    this._age = obj['age'];
    this._degree = obj['degree'];
    this._university = obj['university'];
  }

  String get name => _name;
  String get username => _username;
  String get password => _password;
  // String get flaglogged => _flaglogged;
  String get age => _age;
  String get degree => _degree;
  String get university => _university;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["name"] = _name;
    map["username"] = _username;
    map["password"] = _password;
    // map["flaglogged"] = _flaglogged;
    map["age"] = _age;
    map["degree"] = _degree;
    map["university"] = _university;
    return map;
  }
}
