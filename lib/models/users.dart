part of'models.dart';

class Users extends Equatable{
  final String uid;
  final String name;
  final String phone;
  final String email;
  final String password;
  final String createdAt;
  final String updateAt;

  Users(
    this.uid,
    this.name,
    this.phone,
    this.email,
    this.password,
    this.createdAt,
    this.updateAt,
    );

  @override
  // TODO: implement props
  List<Object> get props => [
    uid,
    name,
    phone,
    email,
    password,
    createdAt,
    updateAt,
  ];
}