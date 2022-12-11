import 'dart:async';
import 'dart:convert';
import 'package:despy_app/features/core/errors/http_exception.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class DataService with ChangeNotifier {
  DataService({required this.uid});

  final String uid;

  getUrlDatabase({required String? path}) {
    String urlDatabase =
        "https://appdespy-default-rtdb.firebaseio.com/$path.json";
    return urlDatabase;
  }

  /*

    -REPOSITORY-

    (GET) DATA FROM DATABASE AND RETURN TO CONTROLLER

    => Load Transaction

  */

  Future<Map<String, dynamic>> fetchData() async {
    Map<String, dynamic>? datasFromDatabase = {};
    final url = getUrlDatabase(path: "transaction");
    final response = await http.get(Uri.parse(url));

    if (response.statusCode >= 400) {
      throw HttpException(
        msg: "Fetch data failed by Client. Try again",
        statusCode: response.statusCode,
      );
    }

    if (response.statusCode >= 500) {
      throw HttpException(
        msg: "Fetch data failed by Server. Try again",
        statusCode: response.statusCode,
      );
    }

    datasFromDatabase = jsonDecode(response.body);

    if (datasFromDatabase == null) {
      return {
        "Empty": "Empty datas from Database",
      };
    } else {
      return datasFromDatabase;
    }
  }

  /*

    -REPOSITORY-

    (POST) DATA to DATABASE AND RETURN STATUSCODE

    => Create Transaction
    
  */

  Future<int> createData(Map<String, dynamic> data) async {
    final url = getUrlDatabase(path: "transaction");
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode(data),
    );

    if (response.statusCode >= 400) {
      throw HttpException(
        msg: "Create data failed by Client. Try again",
        statusCode: response.statusCode,
      );
    }

    if (response.statusCode >= 500) {
      throw HttpException(
        msg: "Create data failed by Server. Try again",
        statusCode: response.statusCode,
      );
    }

    return response.statusCode;
  }

  /*

    -REPOSITORY-

    (PATCH) DATA TO DATABASE AND RETURN STATUSCODE

    => Patch Transaction
    
  */

  Future<int> patchData(String id, Map<String, dynamic> data) async {
    final url = getUrlDatabase(path: "transaction/$id");
    final response = await http.patch(
      Uri.parse(url),
      body: data,
    );

    if (response.statusCode >= 400) {
      throw HttpException(
        msg: "Create data failed by Client. Try again",
        statusCode: response.statusCode,
      );
    }

    if (response.statusCode >= 500) {
      throw HttpException(
        msg: "Create data failed by Server. Try again",
        statusCode: response.statusCode,
      );
    }

    return response.statusCode;
  }

  /*

    -REPOSITORY-

    (DELETE) DATA TO DATABASE AND RETURN TO STATUSCODE

    => Delete Transaction
    
  */

  Future<int> deleteData(String id) async {
    final url = getUrlDatabase(path: "transaction/$id");
    final response = await http.delete(Uri.parse(url));

    if (response.statusCode >= 400) {
      throw HttpException(
        msg: "Create data failed by Client. Try again",
        statusCode: response.statusCode,
      );
    }

    if (response.statusCode >= 500) {
      throw HttpException(
        msg: "Create data failed by Server. Try again",
        statusCode: response.statusCode,
      );
    }

    return response.statusCode;
  }
}
