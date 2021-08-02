class User {
  final String bearerToken;
  String name;
  String lastName;
  final String email;
  final String accountType;
  final int id;
  //List specializations;
  String specializations;

  User({
    this.bearerToken,
    this.name,
    this.lastName,
    this.email,
    this.accountType,
    this.id,
    this.specializations,
  });
  factory User.fromJson(
      Map<String, dynamic> header, Map<String, dynamic> body) {
    return User(
        bearerToken: header['authorization'],
        name: body['name'],
        lastName: body['lastname'],
        email: body['email'],
        accountType: body['account_type'],
        id: body['id']);
  }
  factory User.fromJsonRegister(Map<String, dynamic> header, String name,
      String lastName, String email, String accountType, String specializations) {
    return User(
      bearerToken: header['authorization'],
      name: name,
      lastName: lastName,
      email: email,
      accountType: accountType,
      specializations: specializations,
    );
  }
}
