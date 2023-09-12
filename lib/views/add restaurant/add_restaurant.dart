import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_panda/repository/image_viewmodel.dart';
import 'package:food_panda/viewmodel/restaurant_viewmodel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../data/respone/status.dart';
import '../../model/request/restaurant_request.dart';
import '../../model/response/RestaurantModel.dart';

class AddRestaurant extends StatefulWidget {
  AddRestaurant({this.isUpdate, this.restaurant});
  bool? isUpdate;
  Datum? restaurant;
  @override
  State<AddRestaurant> createState() => _AddRestaurantState();
}

class _AddRestaurantState extends State<AddRestaurant> {
  var imageFile;

  var imageViewModel = ImageViewModel();
  var nameController = TextEditingController();
  var categoryController = TextEditingController();
  var discountController = TextEditingController();
  var deliveryFeeController = TextEditingController();
  var deliveryTimeController = TextEditingController();
  var pictureID ;
  var restaurantViewModel = RestaurantViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.isUpdate == true){
      nameController.text = widget.restaurant!.attributes!.name!;
      categoryController.text = widget.restaurant!.attributes!.category!;
      discountController.text = widget.restaurant!.attributes!.discount!.toString();
      deliveryTimeController.text = widget.restaurant!.attributes!.deliveryTime!.toString();
      deliveryFeeController.text = widget.restaurant!.attributes!.deliveryFee!.toString();
      pictureID = widget.restaurant!.attributes!.picture!.data!.id!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                _getImageFromSource('camera');
              },
              icon: Icon(Icons.camera_alt_outlined)
          ),
          IconButton(
              onPressed: ()=>  _getImageFromSource('gallery'),
              icon: Icon(Icons.photo))
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(

            children: [
              ChangeNotifierProvider<ImageViewModel>(
                create: (context) => imageViewModel,
                child: Consumer<ImageViewModel>(
                  builder: (context, viewModel, _) {
                    if(widget.isUpdate!){
                      return Image.network('https://cms.istad.co${widget.restaurant!.attributes!.picture!.data!.attributes!.url!}');
                    }
                    switch (viewModel.response.status){
                      case Status.LOADING:
                        return const Center(child: CircularProgressIndicator(),);
                      case Status.COMPLETED:
                          print('Image id ${viewModel.response.data}');
                          pictureID = viewModel.response.data.id;
                          return Center(
                            child: Container(
                              width: 250,
                              height: 150,
                              color: Colors.amberAccent,
                              child: Image.file(imageFile)

                            ),
                          );
                          default: return Text('error');

                    }
                  },
                ),
              ),
              SizedBox(height: 10,),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: 'Name',
                  label: Text('Name'),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(width: 3,color: Colors.blue))
                ),
              ),
              SizedBox(height: 5,),
              TextField(
                controller: categoryController,
                decoration: InputDecoration(
                    hintText: 'Category',
                    label: Text('Category'),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(width: 3,color: Colors.blue))
                ),
              ),
              SizedBox(height: 5,),
              TextField(
                controller: discountController,
                decoration: InputDecoration(
                    hintText: 'Discount',
                    label: Text('Discount'),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(width: 3,color: Colors.blue))
                ),
              ),
              SizedBox(height: 5,),
              TextField(
                controller: deliveryTimeController,
                decoration: InputDecoration(
                    hintText: 'DeliveryTime',
                    label: Text('DeliveryTime'),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(width: 3,color: Colors.blue))
                ),
              ),
              SizedBox(height: 5,),
              TextField(
                controller: deliveryFeeController,
                decoration: InputDecoration(
                    hintText: 'DeliveryFee',
                    label: Text('DeliveryFee'),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(width: 3,color: Colors.blue))
                ),
              ),
              SizedBox(height: 5,),
              ElevatedButton(
                  onPressed: (){
                    var requestBody = RestaurantRequest(
                      data: DataRequest(
                        name: nameController.text,
                        category: categoryController.text,
                        discount: int.parse(discountController.text),
                        deliveryFee: double.parse(deliveryFeeController.text),
                        deliveryTime: int.parse(deliveryTimeController.text),
                        picture: pictureID.toString()
                      )

                    );
                    restaurantViewModel.postAllRestaurant(requestBody);
                  },
                  child: ChangeNotifierProvider(
                    create: (context) => restaurantViewModel,
                      child: Consumer<RestaurantViewModel>(
                          builder: (context, viewModel, child) {
                            if(viewModel!.response!.status == Status.COMPLETED){
                              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Operation Success'))
                                );
                              });
                            }
                            return Text(widget.isUpdate!? 'Edit': 'Save');
                          },
                      )))

            ],
          ),
        ),
      ),
    );
  }

  _getImageFromSource(type) async{
    print('before picking image ');
    var pickedFile = await ImagePicker().pickImage(
      source: type == 'camera' ? ImageSource.camera : ImageSource.gallery
    );
    if(pickedFile != null){
      //print('Image is picked ${pickedFile.path}');
      setState((){
        imageFile = File(pickedFile.path);
      });
      imageViewModel.uploadImage(pickedFile.path);
    }
  }
}
