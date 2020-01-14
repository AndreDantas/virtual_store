import 'package:scoped_model/scoped_model.dart';
import 'package:virtual_store/data/user.dart';
import 'package:virtual_store/helpers/auth_helper.dart';

class UserModel extends Model {
  bool isLoading = false;

  User user;

  void signUp(Map<String, dynamic> userData, String password,
      void Function() onSuccess, void Function() onFailed) async {
    _startLoading();
    user = await createUser(userData, password);
    if (user != null) {
      onSuccess();
    } else {
      onFailed();
    }
    _stopLoading();
  }

  void signIn() async {}

  void _startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void _stopLoading() {
    isLoading = false;
    notifyListeners();
  }

  void recoverPass() {}

  // bool isLoggedIn() {}
}
