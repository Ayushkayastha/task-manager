import 'package:dio/dio.dart';

class DeleteNetworkRequest{

  final dio=Dio();

  Future <bool> deteleModel(String id) async{

    Response response=await dio.delete('http://localhost:3000/api/v1/tasks/$id');
    if(response.statusCode==200 ||response.statusCode==201)
      {
        return true;
      }
    else
      return false;
  }

}