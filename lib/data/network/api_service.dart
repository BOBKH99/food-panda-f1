import 'dart:convert';
import 'dart:io';
import 'package:food_panda/model/response/image.dart';
import 'package:http/http.dart'as http;
import 'package:food_panda/data/app_exception.dart';

class ApiService {
  dynamic responeJson;

  Future<dynamic> deleteApi(url) async{
    var request = http.Request('DELETE', Uri.parse(url));
    var response = await request.send();

    if(response.statusCode == 200){
      return true;
    }else{
      return false;
    }
  }

  Future<dynamic> puttApi(url, requestBody) async{
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('PUT', Uri.parse(url));
    request.body = json.encode(requestBody);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return true;
    }
    else {
      return false;
    }

  }

  Future<dynamic> postApi(url, requestBody) async{
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(url));
    request.body = json.encode(requestBody);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return true;
    }
    else {
      return false;
    }

  }

  Future<dynamic> uploadImageService(url, file) async{
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('files', file));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var res = await response.stream.bytesToString();
      var images = imageResponseFromJson(res);
      print('image in api_service ${images[0].id}');
      return images[0];
    }
    else {
      print(response.reasonPhrase);
    }

  }

  Future<dynamic> getApiRespone(String url) async {
    try{
      var respone = await http.get(Uri.parse(url));
      responeJson = returnRespone(respone);
    }on SocketException{
      throw FetchDataException('No internet connection please check your internet');
    }
    return responeJson;
  }

  dynamic returnRespone(http.Response respone) {
    switch(respone.statusCode){
      case 200:
        //print('jsonDecode ${jsonDecode(respone.body)}');
        return jsonDecode(respone.body);
      case 500:
        throw BadRequestException('please check your request body');
    }
  }
}