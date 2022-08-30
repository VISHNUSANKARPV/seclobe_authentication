class UserModel {
  String? name;
  String? email;
  String? id;
  String? accessToken;

  UserModel({this.name, this.email, this.id, this.accessToken});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    id = json['id'];
    accessToken = json['access_token'];
  }

}