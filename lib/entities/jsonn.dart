class JSONN {
  String profile;
  String username;
  String email;
  int balance;
  String behavior;

  JSONN(this.profile, this.username, this.email, this.balance, this.behavior);

  JSONN.fromJson(Map<String, dynamic> json) {
    profile = json['profile'];
    username = json['username'];
    email = json['email'];
    balance = json['balance'];
    behavior = json['behavior'];
  }
}
