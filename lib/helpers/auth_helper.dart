import 'package:virtual_store/data/user.dart';
import 'package:virtual_store/repository/auth_repository.dart';

Future<User> createUser(Map<String, dynamic> userData, String password) async {
  createFirebaseUser(userData["email"], password).then((user) async {
    await saveUserDataFirebase(user.uid, userData);
    return User(
        id: user.uid, name: userData["name"], address: userData["address"]);
  }).catchError((e) {
    return null;
  });

  return null;
}
