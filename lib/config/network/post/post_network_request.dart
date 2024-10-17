import 'package:dio/dio.dart';
import 'package:task_manager/config/network/post/post_model.dart';

class PostNetworkRequest {
  final dio = Dio();

  Future<PostModel> postModel(String name, bool completed) async {

      final response = await dio.post(
        'http://localhost:3000/api/v1/tasks',
        data: {
          'name': name,
          'completed': completed,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Task created successfully: ${response.data}');
        return response.data;
      } else {
        throw Exception('Failed to post tasks');
      }

  }
}
