import 'package:get/get.dart';
import 'package:puu1/global.dart';

class LoginProvider extends GetConnect {
  Future<Response> postUser(var data) =>
      post('${url}/api/login', data, headers: myHeader);
}
