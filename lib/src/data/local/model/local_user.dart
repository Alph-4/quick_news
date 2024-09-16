

class LocalUser {
  static final LocalUser _instance = LocalUser._internal();

  factory LocalUser() {
    return _instance;
  }

  LocalUser._internal();

  String? uid;
  String? email;
  String? displayName;
  String? profileImageUrl;


  void clearUser() {
    uid = null;
    email = null;
    displayName = null;
    profileImageUrl = null;

    
  }



}
