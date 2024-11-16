import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  static final UserRepository _userRepository = UserRepository._internal();

  factory UserRepository() {
    return _userRepository;
  }

  UserRepository._internal();

  Future<User?> getCurrentUser() async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final User? user = auth.currentUser;

      if (user != null) {
        return user;
      }

      return null;
    } catch (e) {
      print(e);

      return null;
    }
  }
}
