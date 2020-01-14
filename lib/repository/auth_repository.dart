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

Future<Null> signOutFirebaseUser() async {
  await FirebaseAuth.instance.signOut();
}

Future<FirebaseUser> signInFirebaseUser(String email, String password) async {
  return await FirebaseAuth.instance
      .signInWithEmailAndPassword(email: email, password: password);
}

Future<DocumentSnapshot> getCurrentUserDataFirebase() async {
  final user = await FirebaseAuth.instance.currentUser();
  if (user == null) {
    return null;
  }

  return await Firestore.instance.collection(USERS).document(user.uid).get();
}
