import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class DBController extends GetxController {
  final _box = GetStorage();

  final loginKey = 'userKey';

  getUserID() => _box.read(loginKey) ?? false;
  saveUserId(int value) => _box.write(loginKey, value);

  final token = 'token';

  String getToken() => _box.read(token) ?? '';
  saveToken(String value) => _box.write(token, value);
}

class GoogleSignInApi {
  static final _googleSignIn = GoogleSignIn();
  static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();
  static Future<GoogleSignInAccount?> signOut() => _googleSignIn.signOut();
}
