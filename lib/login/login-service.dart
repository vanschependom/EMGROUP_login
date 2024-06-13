class LoginService {
  Future<bool> login(String username, String password) async {
    await Future.delayed(Duration(seconds: 2));
    return true;
  }
}
