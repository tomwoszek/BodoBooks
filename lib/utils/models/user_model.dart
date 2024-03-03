class BodoboxUser {
  BodoboxUser(
      {this.name,
      this.email,
      this.uid,
      this.password,
      this.deviceOneId,
      this.deviceTwoId,
      this.deviceOneName,
      this.deviceTwoName,
      this.masterUser,
      this.owningBooks,
      this.shareMode});
  String? name;
  String? email;
  String? password;
  String? uid;
  String? deviceOneId;
  String? deviceTwoId;
  String? deviceOneName;
  String? deviceTwoName;
  List? owningBooks;
  bool? masterUser;
  bool? shareMode;
}
