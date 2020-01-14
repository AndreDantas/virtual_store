import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

const USERS = "users";
Future<FirebaseUser> createFirebaseUser(String email, String password) async {
  return await FirebaseAuth.instance
      .createUserWithEmailAndPassword(email: email, password: password);
}

Future<Null> saveUserDataFirebase(
    String userId, Map<String, dynamic> userData) async {
  await Firestore.instance.collection(USERS).document(userId).setData(userData);
}
