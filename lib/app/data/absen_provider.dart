import 'dart:io';

import 'package:get/get.dart';
import 'package:puu1/global.dart';
import 'package:sp_util/sp_util.dart';

class AbsenProvider extends GetConnect {
  var myHeader = {
    'Accept': 'application/json',
    // 'Authorization': 'Bearer ${SpUtil.getString('token')!}',
  };
  var authHeader = {
    'Accept': 'application/json',
    'Authorization': 'Bearer ${SpUtil.getString('token')!}',
  };
  Future<Response> getData() {
    return get('${url}/api/absen/${SpUtil.getInt('id')}', headers: authHeader);
  }

  Future<Response> storeAbsen(File file, Map<String, String> fields) {
    final formData = FormData({
      'image': MultipartFile(file, filename: file.path.split('/').last),
      'status': '${fields['status']}',
      'users_id': '${SpUtil.getInt('id')}', 
    });

    return post(
      '${url}/api/absen/store/',
      formData,
      headers: myHeader,
    );
  }

  Future<Response> getImg(int id) {
    return get('${url}/api/get/absen/$id', headers: myHeader);
  }

  Future<Response> getStats() {
    return get('${url}/api/absen/statistik/${SpUtil.getInt('id')}',
        headers: authHeader);
  }
}
