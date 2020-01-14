import 'package:scoped_model/scoped_model.dart';
import 'package:virtual_store/data/user.dart';
import 'package:virtual_store/helpers/auth_helper.dart';

class UserModel extends Model {
  bool isLoading = false;

  User _user;

  User getUser() {
    if (_user == null)
      return null;
    else
      return User.fromMap(_user.toMap());
  }

  @override
  void addListener(listener) {
    super.addListener(listener);
    _loadCurrentUser();
  }

  void signUp(Map<String, dynamic> userData, String password,
      void Function() onSuccess, void Function() onFailed) async {
    _startLoading();
    _user = await createUser(userData, password);

    if (_user != null) {
      onSuccess();
    } else {
      onFailed();
    }
    _stopLoading();
  }

  void signIn(String email, String password, void Function() onSuccess,
      void Function() onFailed) async {
    _startLoading();

    _user = await signInUser(email, password);

    if (_user != null)
      onSuccess();
    else
      onFailed();

    _stopLoading();
  }

  void signOut() async {
    _startLoading();
    await signOutUser();
    _user = null;
    _stopLoading();
  }

  void _startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void _stopLoading() {
    isLoading = false;
    notifyListeners();
  }

  void recoverPass() {}

  bool isLoggedIn() {
    return _user != null;
  }

  Future<Null> _loadCurrentUser() async {
    _startLoading();
    _user = await getCurrentUserData();
    _stopLoading();
  }
}
