import 'package:flutter/material.dart';
import 'package:food_panda/viewmodel/restaurant_viewmodel.dart';
import 'package:food_panda/views/add%20restaurant/add_restaurant.dart';
import 'package:provider/provider.dart';

import '../../../data/respone/status.dart';
import '../../../model/response/RestaurantModel.dart';

class RestaurantCard extends StatelessWidget {

  Datum? restaurant;
  bool? isUpdate;
  var restaurantViewModel = RestaurantViewModel();
  bool isRemoving = false;
  RestaurantCard({
    this.restaurant
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: (){
        showDialog(context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Are you sure to delete?'),
                content: Text('The action can be reversed'),
                actions: [
                  TextButton(onPressed: (){
                    Navigator.pop(context);
                  }, child: Text('No')),
                  TextButton(onPressed: (){
                    restaurantViewModel.deleteRestaurant(restaurant!.id);
                  }, child: ChangeNotifierProvider(
                    create: (context) => restaurantViewModel,
                    child: Consumer<RestaurantViewModel>(
                      builder: (context,viewModel, _){
                        if(viewModel.removeRespone.status == Status.COMPLETED){
                          Navigator.pop(context);
                          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Remove Succes'))
                            );
                          });

                      }
                        return Text('Yes');
                     },
                    ),
                  )),
                ],
              );
            });
      },
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => AddRestaurant(isUpdate:true,restaurant: restaurant)));
      },
      child: Container(
        margin: const EdgeInsets.only(right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width * .75,
                    height: 250,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network('https://cms.istad.co${restaurant!.attributes!.picture!.data!.attributes!.url!}',
                          fit: BoxFit.cover,
                        ))),
                Positioned(
                    top: 10,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              bottomRight: Radius.circular(15))
                      ),
                      child: Text('Discount ${restaurant!.attributes!.discount!}%'),
                    )),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(25))
                    ),
                    child: Text('${restaurant!.attributes!.deliveryTime!}mn'),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10,),
            SizedBox(
              width: MediaQuery.of(context).size.width * .75,
              child: Text('${restaurant!.attributes!.name!}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1),
            ),
            Text(restaurant!.attributes!.category!),
            Text('\$\$ ${restaurant!.attributes!.deliveryFee!}'),
          ],
        ),
      ),
    );
  }
}


