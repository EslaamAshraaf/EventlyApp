class UserModel {
  String id;
  String username;
  String email;
  String phone;

  UserModel(this.id, this.username, this.email, this.phone);

  UserModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        username = json['username'],
        email = json['email'],
        phone = json['phone'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'phone': phone,
    };
  }
}
