import 'package:get/get.dart';

class UserController extends GetxController {
  // final _box = GetStorage();

  // ignore: non_constant_identifier_names
  final login_key = 'userKey';

  getUserID() => 1;
  // getUserID() => _box.read(login_key) ?? false;
  // saveUserId(int value) => _box.write(login_key, value);

  RxString name = 'xxx'.obs;
  RxString email = 'xxx@gmail.com'.obs;
  RxString image =
      'https://lh3.googleusercontent.com/a/ACg8ocI5SL5XCQO4EArybQ1127wXGS6x5kvrG2hNVpXBCfFsflY'
          .obs;
}
