import 'dart:async';
import 'dart:convert';
import 'package:despy_app/features/core/errors/http_exception.dart';
import 'package:http/http.dart' as http;

class RepositoryTransaction {
  RepositoryTransaction({required this.uid});

  final String uid;

  getUrlDatabase({required String? path}) {
    String urlDatabase =
        "https://appdespy-default-rtdb.firebaseio.com/$path.json";
    return urlDatabase;
  }

  /*



    (GET) DATA FROM DATABASE AND RETURN TO CONTROLLER



  */

  Future<Map<String, dynamic>> findAllTransaction() async {
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



    (POST) DATA to DATABASE AND RETURN STATUSCODE


    
  */

  Future<int> readNewTransaction(Map<String, dynamic> data) async {
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

    

    (PATCH) DATA TO DATABASE AND RETURN STATUSCODE

    
    
  */

  Future<int> patchTransaction(String id, Map<String, dynamic> data) async {
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

    

    (DELETE) DATA TO DATABASE AND RETURN TO STATUSCODE

    
    
  */

  Future<int> deleteTransaction(String id) async {
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
