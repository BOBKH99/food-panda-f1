import 'package:flutter/cupertino.dart';
import 'package:food_panda/data/respone/api_respone.dart';
import 'package:food_panda/repository/restaurant_repository.dart';

import '../model/response/RestaurantModel.dart';

class RestaurantViewModel extends ChangeNotifier{
  final _restaurantRepo = RestaurantRepository();

  dynamic response = ApiResponse.loading();
  dynamic removeRespone = ApiResponse();

  setRemoveResponse(response) {
    removeRespone = response;
    notifyListeners();
  }

  Future<dynamic> deleteRestaurant(id) async {
    await _restaurantRepo.deleteRestaurant(id)
        .then((isDeleted) => setRemoveResponse(ApiResponse.completed(isDeleted)))
        .onError((error, stackTrace) => setRemoveResponse(ApiResponse.error(stackTrace.toString())));
  }

  setRestaurantList(respone){
    this.response = respone;
    notifyListeners();
  }
  Future<dynamic?> putAllRestaurant(requestBody,id) async{
    await _restaurantRepo.putRestaurant(requestBody,id)
        .then((restaurants) {
      // print('respone in viewmodel ${restaurants.data!.length}');
      setRestaurantList(ApiResponse.completed(restaurants));})
        .onError((error, stackTrace) => setRestaurantList(ApiResponse.error(stackTrace.toString())));
  }
  Future<dynamic?> postAllRestaurant(requestBody) async{
    await _restaurantRepo.postRestaurant(requestBody)
        .then((restaurants) {
      // print('respone in viewmodel ${restaurants.data!.length}');
      setRestaurantList(ApiResponse.completed(restaurants));})
        .onError((error, stackTrace) => setRestaurantList(ApiResponse.error(stackTrace.toString())));
  }
  Future<RestaurantModel?> getAllRestaurant() async{
    await _restaurantRepo.getRestaurants()
        .then((restaurants) {
         // print('respone in viewmodel ${restaurants.data!.length}');
          setRestaurantList(ApiResponse.completed(restaurants));})
        .onError((error, stackTrace) => setRestaurantList(ApiResponse.error(stackTrace.toString())));
  }
}