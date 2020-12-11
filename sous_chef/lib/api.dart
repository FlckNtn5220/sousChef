import 'package:dio/dio.dart';

class Sous_ChefApi {
  final _dio = Dio(BaseOptions(baseUrl: 'http://localhost:8081/'));

  Future<List> getRecipe() async {
    final response = await _dio.get('');
    return response.data['Recipes'];
  }

  Future<List> createUser(String user, String pwd) async {
    final response = await _dio.post('', data: {'user': user, 'pwd': pwd});
    return response.data;
  }
}
