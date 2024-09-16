import 'package:uuid/uuid.dart';

class LocalUser {
  static final LocalUser _instance = LocalUser._internal();

  factory LocalUser() {
    return _instance;
  }

  LocalUser._internal();

  String? uid = Uuid().v4();
  String? email = "test@test.test";
  String? displayName = "test";
  String? profileImageUrl;

  void clearUser() {
    uid = null;
    email = null;
    displayName = null;
    profileImageUrl = null;
  }
}
