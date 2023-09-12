
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_panda/model/response/RestaurantModel.dart';
import 'package:food_panda/viewmodel/restaurant_viewmodel.dart';
import 'package:food_panda/views/add%20restaurant/add_restaurant.dart';
import 'package:food_panda/views/home/widgets/app_bar.dart';
import 'package:food_panda/views/home/widgets/restaurant_card.dart';
import 'package:food_panda/views/search/search_screen.dart';
import 'package:provider/provider.dart';

import 'data/respone/status.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.pink
      )
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      themeMode: ThemeMode.system,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.pink,
        ),
        useMaterial3: true,
        primaryColor: Colors.pink,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.pink,
          foregroundColor: Colors.white
        ),
        scaffoldBackgroundColor: Colors.grey.shade100,
        textTheme: Theme.of(context).textTheme.apply(
          fontFamily: 'Poppins'),
      ),
      darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
          // useMaterial3: true,
          scaffoldBackgroundColor: Colors.grey.shade100,
          textTheme: Theme.of(context).textTheme.apply(
              fontFamily: 'Poppins',)
      ),
      home: const MyHomePage(title: 'Flutter Demo Home '),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
      with SingleTickerProviderStateMixin{
  
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key
  final _restaurantViewModel = RestaurantViewModel();
  late final AnimationController animationController;

  var cardStyle = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15)
  );
  @override
  void initState() {
    super.initState();
    _restaurantViewModel.getAllRestaurant();
    animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 2000))..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: MyAppBar(key: _key),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: 60,
            flexibleSpace: FlexibleSpaceBar(
              // title: Text('Flexible Space Bar'),
              background: Container(
                padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 5, bottom: 5
                ),
                color: Colors.pinkAccent,
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                      MaterialPageRoute(
                          builder: (context) => SearchScreen())
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30)
                    ),
                    child: const Row(
                      children: [
                        SizedBox(width: 15,),
                        Icon(Icons.search),
                        SizedBox(width: 10,),
                        Text('Search for shops & restaurants '),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                width: double.infinity,
                height: 180,
                decoration: cardStyle,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                        top: 10,
                        left: 10
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Food delivery',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25
                            ),
                          ),
                          Text('Order food you love')
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        verticalDirection: VerticalDirection.up,
                        children: [
                          SizedBox(
                              width: 120,
                              height: 120,
                              child: Image.asset('assets/images/burger.png'))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 300,
                    margin: const EdgeInsets.only(left: 15),
                    decoration: cardStyle,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Shops',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25
                              ),
                            ),
                              Text('Groceries and more')],
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                                width: 120,
                                height: 80,
                                child: Image.asset('assets/images/chicken.png')),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 300,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Container(
                            color: Colors.amber,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            color: Colors.lightBlue,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
                margin: const EdgeInsets.only(
                  left: 15, top: 15
                ),
                child: const Text('Recommended for you',
                    style: TextStyle(fontWeight: FontWeight.bold,
                      fontSize: 20
                    ),
                )),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 350,
              margin: const EdgeInsets.only(
                  left: 15, right: 15, top: 15, ),
              child: ChangeNotifierProvider(
                create: (context) => _restaurantViewModel,
                child: Consumer<RestaurantViewModel>(
                  builder: (context, viewModel, _){
                    print('result ${viewModel.response.status}');
                    switch(viewModel.response.status){
                      // case Status.LOADING:
                      //   return AnimatedSkeleton(
                      //     listenable: animationController,
                      //     child: Container(
                      //       width: MediaQuery.of(context).size.width * .75,
                      //       height: 250,
                      //       color: Colors.grey.withBlue(50),
                      //     ),
                      //   );
                      case Status.COMPLETED:
                        RestaurantModel? restaurantModel = viewModel.response.data;
                        return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: restaurantModel?.data!.length,
                            itemBuilder: (context, index) {
                              print('Index = $index, ${restaurantModel?.data![index]}');
                              print('total: ${restaurantModel?.data!.length}');
                              return RestaurantCard(restaurant: restaurantModel?.data![index],);
                            }
                        );
                      case Status.ERROR:
                        return Text('Hello this is a Error ');
                      default: return Text('Default');
                    }

                  }
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.only(left: 15, right: 15),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(width: 1, color: Colors.black12)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Become a pro',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                      Text('get exclusive deals')
                    ],
                  ),
                  Transform.rotate(
                    angle: -0.1,
                    child: Image.network('https://malaysiafreebies.com/wp-content/uploads/2022/01/image001-767x483.png',
                        width: 110,
                        height: 90,
                    ),
                  )
                ],
              ),
            ),
          )
          // SliverList(
          //     delegate: SliverChildBuilderDelegate(
          //         (context, index) => ListTile(
          //           tileColor: (index % 2 == 0) ? Colors.greenAccent : Colors.blueAccent,
          //           title: Text('Index $index',
          //             style: const TextStyle(fontWeight: FontWeight.bold),
          //           ),
          //         ),
          //       childCount: 30
          //     )
          // )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => AddRestaurant(isUpdate: false,)));},
          child: const Icon(Icons.add),
      ),
    );
  }
}

