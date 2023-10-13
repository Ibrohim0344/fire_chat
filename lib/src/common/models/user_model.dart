class UserModel {
  final String uid;
  final String? username;

  const UserModel({
    required this.uid,
    this.username,
  });

  @override
  String toString() => 'UserModel(uid: $uid, username: $username)';

  Map<String, Object?> toJson() {
    return <String, Object?>{
      'uid': uid,
      'username': username,
    };
  }

  factory UserModel.fromMap(Map<String, Object?> map) {
    return UserModel(
      uid: map['uid'] as String,
      username: map['username'] != null ? map['username'] as String : null,
    );
  }
}
