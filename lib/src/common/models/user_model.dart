class UserModel {
  final String uid;
  final String? username;

  const UserModel({
    required this.uid,
    this.username,
  });

  @override
  String toString() => 'UserModel(uid: $uid, username: $username)';
}
