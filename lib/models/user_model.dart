class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String address;


  UserModel({required this.id, required this.name, required this.email, required this.phone, this.address=''});
}
