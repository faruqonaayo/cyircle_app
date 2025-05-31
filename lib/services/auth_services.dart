import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  Future<Map<String, String>> login(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return {"status": "success", "message": "Login Sucessfull"};
    } on FirebaseAuthException catch (e) {
      return {"status": "failure", "message": e.message ?? "An error occured"};
    } catch (e) {
      return {"status": "failure", "message": e.toString()};
    }
  }

  Future<Map<String, String>> signup(
    String firstName,
    String lastName,
    String email,
    String password,
  ) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await FirebaseFirestore.instance.collection("users").add({
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
      });

      return {"status": "success", "message": "User Created Sucessfully"};
    } on FirebaseAuthException catch (e) {
      return {"status": "failure", "message": e.code};
    } catch (e) {
      return {"status": "failure", "message": e.toString()};
    }
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
