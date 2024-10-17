import 'package:dio/dio.dart';
import 'package:task_manager/config/network/update/update_model.dart';

class UpdateNetworkRequest{
  
  final dio =Dio();
  
  Future <UpdateModel> updateModel(String id,String Name,bool Completed) async{
    
    final response= await dio.patch(
      'http://localhost:3000/api/v1/tasks/$id',
      data:{
        'name':Name,
        'completed':Completed
      }
    );

    if (response.statusCode == 200 || response.statusCode == 201)
    {
      print('Task created successfully: ${response.data}');
      return response.data;
    }
    else
    {
      throw Exception('Failed to post tasks');
    }
  }
  
}