import 'package:get/get.dart';
import 'package:puu1/global.dart';
import 'package:sp_util/sp_util.dart';

class TaskProvider extends GetConnect {
  var myHeader = {
    'Accept': 'application/json',
  };
  var authHeader = {
    'Accept': 'application/json',
    'Authorization': 'Bearer ${SpUtil.getString("token")}',
  };
  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<Response> getTask() {
    return get('${url}/api/get/task/${SpUtil.getInt("id")}',
        headers: authHeader); // API diakses berdasarkan ID
  }

  Future<Response> getTask1() {
    return get('${url}/api/get/task1/${SpUtil.getInt("id")}',
        headers: authHeader); // API diakses berdasarkan ID
  }

  Future<Response> addTask(var data) {
    return post('${url}/api/task/add', data,
        headers: myHeader); // API diakses tanpa ID
  }

  Future<Response> deleteTask(int id) {
    return delete('${url}/api/task/delete/${id}',
        headers: authHeader); // API diakses tanpa ID
  }
}
