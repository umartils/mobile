import 'dart:io';

import 'package:get/get.dart';
import 'package:puu1/global.dart';
import 'package:sp_util/sp_util.dart';

class UserProvider extends GetConnect {
  var myHeader = {
    'Accept': 'application/json',
  };
  var authHeader = {
    'Accept': 'application/json',
    'Authorization': 'Bearer ${SpUtil.getString("token")}',
  };
  Future<Response> getUser() {
    return get('${url}/api/users/${SpUtil.getInt("id")}',
        headers: authHeader); // API diakses berdasarkan ID
  }

  Future<Response> getTime() {
    return get('${url}/api/users/getTime/${SpUtil.getInt("id")}',
        headers: authHeader); // API diakses berdasarkan ID
  }

  Future<Response> getLocation() {
    return get('${url}/api/users/getLocation/${SpUtil.getInt("id")}',
        headers: authHeader); // API diakses berdasarkan ID
  }

  Future<Response> updateUser(var data) {
    return put('${url}/api/users/update/${SpUtil.getInt("id")}', data,
        headers: authHeader); // API diakses berdasarkan ID
  }

  Future<Response> updateImg(File file) {
    final formData = FormData({
      'image': MultipartFile(file, filename: file.path.split('/').last),
    });
    return post('${url}/api/users/updateImg/${SpUtil.getInt("id")}', formData,
        headers: authHeader); // API diakses berdasarkan ID
  }

  Future<Response> getTask() {
    return get('${url}/api/get/task/${SpUtil.getInt("id")}',
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
