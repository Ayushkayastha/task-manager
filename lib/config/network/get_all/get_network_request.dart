import 'package:dio/dio.dart';
import 'package:task_manager/config/network/get_all/get_all_model.dart';


class GetNetworkRequest{

  final dio = Dio();

  Future<List<GetAllModel>> getAllModel() async {
   print('bhitra chu getAllModel() ko');
    final response = await dio.get('http://localhost:3000/api/v1/tasks');

    if(response.statusCode == 200 || response.statusCode == 201)
    {
      print(response.data);
      List<GetAllModel> tasks = (response.data as List)
          .map((task) => GetAllModel.fromJson(task))
          .toList();
      return tasks;
    }
    else
    {
      throw Exception('Failed to fetch tasks');
    }

  }
}


