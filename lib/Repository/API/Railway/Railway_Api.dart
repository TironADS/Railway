import 'dart:convert';

import 'package:http/http.dart';
import 'package:railway/Repository/Model_class/RailwayModel.dart';

import '../api_client.dart';

class RailwayApi{
  ApiClient apiClient = ApiClient();
  Future<RailwayModel>getRailway({required String location})async{
    String path  = 'https://irctc1.p.rapidapi.com/api/v1/searchStation?query=${location}';
    var body={};
    Response response = await apiClient.invokeAPI(path, 'GET', body);
    return RailwayModel.fromJson(jsonDecode(response.body));
  }
}