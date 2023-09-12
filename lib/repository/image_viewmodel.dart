import 'package:flutter/cupertino.dart';
import 'package:food_panda/data/respone/api_respone.dart';
import 'package:food_panda/repository/restaurant_repository.dart';

class ImageViewModel extends ChangeNotifier {
  final _imageRepo = RestaurantRepository();
  dynamic response = ApiResponse.loading();

  setImageResponse(response) {
    this.response = response;
    notifyListeners();
  }

  Future<dynamic> uploadImage(file) async{
    await _imageRepo.uploadImage(file)
        .then((value) => setImageResponse(ApiResponse.completed(value)))
        .onError((error, stackTrace) =>
            setImageResponse(ApiResponse.error(stackTrace.toString()))
    );
  }
}