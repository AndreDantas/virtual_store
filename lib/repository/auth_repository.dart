import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

const USERS = "users";
Future<FirebaseUser> createFirebaseUser(String email, String password) async {
  FirebaseUser firebaseUser;
  await FirebaseAuth.instance
      .createUserWithEmailAndPassword(email: email, password: password)
      .then((user) {
    if (user != null) firebaseUser = user;
  }).catchError((e) {
    firebaseUser = null;
  });

  return firebaseUser;
}

Future<Null> saveUserDataFirebase(
    String userId, Map<String, dynamic> userData) async {
  await Firestore.instance.collection(USERS).document(userId).setData(userData);
}

Future<Null> signOutFirebaseUser() async {
  await FirebaseAuth.instance.signOut();
}

Future<FirebaseUser> signInFirebaseUser(String email, String password) async {
  FirebaseUser firebaseUser;
  await FirebaseAuth.instance
      .signInWithEmailAndPassword(email: email, password: password)
      .then((user) {
    if (user != null) firebaseUser = user;
  }).catchError((e) {
    firebaseUser = null;
  });

  return firebaseUser;
}

Future<DocumentSnapshot> getCurrentUserDataFirebase() async {
  final user = await FirebaseAuth.instance.currentUser();
  if (user == null) {
    return null;
  }

  return await Firestore.instance.collection(USERS).document(user.uid).get();
}
