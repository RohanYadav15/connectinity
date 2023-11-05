class CurrentUser {
  final bool isOrg;
  final String id;
  final String? userName;
  final String? profileUrl;
  final String? phoneNumber;
  final String email;
  final List<String>? major;

  CurrentUser(
      {this.profileUrl,
      required this.phoneNumber,
      required this.email,
      required this.major,
      required this.isOrg,
      required this.id,
      this.userName,
      required});

  factory CurrentUser.fromMap(Map<String, dynamic> map) {
    return CurrentUser(
      phoneNumber: map['phoneNumber'],
      email: map['email'],
      major: map['major'],
      isOrg: map['isOrg'],
      id: map['id'],
      userName: map['username'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'phoneNumber': this.phoneNumber,
      'email': this.email,
      'major': this.major ?? [],
      'isOrg': this.isOrg,
      'id': id,
      'username': userName
    };
  }
}
