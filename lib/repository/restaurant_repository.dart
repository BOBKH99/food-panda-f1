
import 'package:food_panda/data/network/api_service.dart';
import 'package:food_panda/model/response/RestaurantModel.dart';
import 'package:food_panda/res/app_url.dart';

import '../model/response/image.dart';

class RestaurantRepository {
  final _apiService = ApiService();

  Future<dynamic> deleteRestaurant( id) async{
    try{
      dynamic response = await _apiService.deleteApi('${AppUrl.postrestaunrant}/$id');
      return response;
    }catch(e){
      rethrow;
    }
  }

  Future<dynamic> putRestaurant(requestBody, id) async{
    try{
      dynamic response = await _apiService.puttApi('${AppUrl.postrestaunrant}/$id', requestBody);
      return response;
    }catch(e){
      rethrow;
    }
  }

  Future<dynamic> postRestaurant(requestBody) async{
    try{
      dynamic response = await _apiService.postApi(AppUrl.postrestaunrant, requestBody);
      return response;
    }catch(e){
      rethrow;
    }
  }
  
  Future<ImageResponse> uploadImage(file) async{
    try{
      dynamic response = await _apiService.uploadImageService(AppUrl.uploadImage, file);
      return response;
    }catch(e){
      rethrow;
    }
  }

  Future<RestaurantModel> getRestaurants() async{
    try{
      dynamic responses = await
          _apiService.getApiRespone(AppUrl.getAllRestaurants);
      // print('respone ${responses["data"][0]["attributes"]["name"]}');
      // print('respone in model ${RestaurantModel.fromJson(responses)}');
      return RestaurantModel.fromJson(responses);
    }catch(e){
      rethrow;
    }
  }
}