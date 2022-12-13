import 'dart:convert';
import 'package:despy_app/features/core/errors/http_exception.dart';
import 'package:http/http.dart' as http;

class RepositoryCategory {
  getUrlDatabase({required String? path}) {
    String urlDatabase =
        "https://appdespy-default-rtdb.firebaseio.com/$path.json";
    return urlDatabase;
  }

  Future<Map<String, dynamic>> findAllCategories() async {
    final url = getUrlDatabase(path: "categories");
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

    final extractedData = jsonDecode(response.body) as Map<String, dynamic>?;

    if (extractedData == null) {
      return {"Empty": "Empty datas from Database"};
    } else {
      return extractedData;
    }
  }

  /*



    (POST) DATA to DATABASE AND RETURN STATUSCODE


    
  */

  Future<int> readNewCategory(Map<String, dynamic> data) async {
    final url = getUrlDatabase(path: "category");
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

  Future<int> patchCategory(String id, Map<String, dynamic> data) async {
    final url = getUrlDatabase(path: "category/$id");
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

  Future<int> deleteCategory(String id) async {
    final url = getUrlDatabase(path: "category/$id");
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
