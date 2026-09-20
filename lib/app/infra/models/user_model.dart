import 'package:clean_arch_app/app/domain/entities/user_entity.dart';

final class UserLoggedModel extends UserEntity {
  int id;
  String email;
  String firstName;
  String lastName;
  String gender;
  String image;
  String accessToken;
  String refreshToken;

  UserLoggedModel({
    required super.username,
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.image,
    required this.accessToken,
    required this.refreshToken,
  });

  factory UserLoggedModel.fromMap(Map<String, dynamic> map) {
    return UserLoggedModel(
      username: map['username'],
      id: map['id'] as int,
      email: map['email'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      gender: map['gender'] as String,
      image: map['image'] as String,
      accessToken: map['accessToken'] as String,
      refreshToken: map['refreshToken'] as String,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'gender': gender,
      'image': image,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }

  UserLoggedEntity toEntity() => UserLoggedEntity(
    username: username,
    id: id,
    email: email,
    lastName: lastName,
    firstName: firstName,
    gender: gender,
    image: image,
    accessToken: accessToken,
    refreshToken: refreshToken,
  );

  factory UserLoggedModel.fromEntity(UserLoggedEntity user) => UserLoggedModel(
    username: user.username,
    id: user.id,
    email: user.email,
    firstName: user.firstName,
    lastName: user.lastName,
    gender: user.gender,
    image: user.image,
    accessToken: user.accessToken,
    refreshToken: user.refreshToken,
  );

  @override
  String toString() =>
      'UserLoggedModel(username: $username id: $id, email: $email, '
      'firstName: $firstName, lastName: $lastName, gender: $gender, '
      'image: $image)';
}
