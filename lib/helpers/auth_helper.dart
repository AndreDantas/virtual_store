import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:virtual_store/data/user.dart';
import 'package:virtual_store/repository/auth_repository.dart';

Future<User> createUser(Map<String, dynamic> userData, String password) async {
  final user = await createFirebaseUser(userData["email"], password);

  if (user == null) {
    return null;
  }
  await saveUserDataFirebase(user.uid, userData);
  return User(
      id: user.uid,
      name: userData["name"],
      email: userData["email"],
      address: userData["address"]);
}

Future<Null> signOutUser() async {
  await signOutFirebaseUser();
}

Future<User> signInUser(String email, String password) async {
  return await signInFirebaseUser(email, password).then((user) async {
    return getCurrentUserData();
  });
}

Future<User> getCurrentUserData() async {
  DocumentSnapshot userDoc = await getCurrentUserDataFirebase();
  if (userDoc != null && userDoc.data != null)
    return User(
        id: userDoc.documentID,
        name: userDoc.data["name"],
        email: userDoc.data["email"],
        address: userDoc.data["address"]);
  return null;
}
