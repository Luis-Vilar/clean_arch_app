abstract class UserEntity {
  String username;
  UserEntity({required this.username});
}

final class UserLoginEntity extends UserEntity {
  String password;
  UserLoginEntity({required super.username, required this.password});
}

final class UserLoggedEntity extends UserEntity {
  int id;
  String email;
  String firstName;
  String lastName;
  String gender;
  String image;
  String accessToken;
  String refreshToken;

  UserLoggedEntity({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.image,
    required this.accessToken,
    required this.refreshToken,
    required super.username,
  });
}
