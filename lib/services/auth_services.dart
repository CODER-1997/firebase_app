import 'package:firebase_app/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  MyUser _userFromFirebase(User? user) {
    return  user != null ?MyUser(userId: user.uid):MyUser(userId: 'no user');
  }

  Stream<MyUser> get usersData{
    return _auth.authStateChanges().map((User? user)=> _userFromFirebase(user));
  }


  Future signInAnon() async {
    try {
      UserCredential userCredential = await _auth.signInAnonymously();
      User? user = userCredential.user;
      return _userFromFirebase(user);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
