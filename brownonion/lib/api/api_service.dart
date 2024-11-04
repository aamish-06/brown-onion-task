import 'dart:convert';
import 'dart:math';

import 'package:brownonion/consts/constant.dart';
import 'package:brownonion/models/model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<UserModel>?> getUsers() async {
    try {
      var url = Uri.parse(ApiConstant.baseUrl + ApiConstant.userEndpoints);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<UserModel> _model = userModelFromJson(response.body);
        return _model;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<bool> addComplaint(UserModel complaint) async {
    try {
      var url = Uri.parse(ApiConstant.baseUrl);
      var response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(complaint.toJson()),
      );
      return response.statusCode == 200;
    } catch (e) {
      print("Error adding complaint: ${e.toString()}");
      return false;
    }
  }
}
