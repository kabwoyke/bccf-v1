class UserModel {
  UserModel
      ({
    required this.email ,
    required this.first_name,
    required this.last_name,
    required this.phone_number,
    required this.gender,
    required this.password ,
   });
  String first_name;
  String last_name;
  String phone_number;
  String gender;
  String email;
  String password;
}