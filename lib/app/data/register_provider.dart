import 'package:get/get.dart';
import 'package:puu1/global.dart';

class RegisterProvider extends GetConnect {
  Future<Response> addUser(var data) =>
      post('${url}/api/register', data, headers: myHeader);
}
