import 'package:note_cubit_grid/database/db.dart';

class UserModel {
  String user_name;
  String user_email;
  String user_password;
  int user_id;

  UserModel({
    required this.user_name,
    required this.user_email,
    required this.user_password,
    required this.user_id,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      user_name: map[AppDataBase.userName],
      user_email: map[AppDataBase.userEmail],
      user_password: map[AppDataBase.userPassword],
      user_id: map[AppDataBase.userId],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      AppDataBase.userName: user_name,
      AppDataBase.userEmail: user_email,
      AppDataBase.userPassword: user_password,
    };
  }
}
