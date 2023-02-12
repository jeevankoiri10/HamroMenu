import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hamro_menu_getx/models/open_location.dart';
import 'package:hamro_menu_getx/pages/animated_google_map/screens/home_page_map.dart';
import '../controller/map_controller.dart';

double defaultPadding = 15.0;
Color scrollableButtonColor =
    Colors.white; //Color.fromRGBO(196, 196, 196, 0.6);
double? sizedBoxWidth = 15.0;
double? sizedBoxHeight = 0.0;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //
  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want to exit an App'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    setState(() {});
    List<int> ListOfItems = [1, 2];

    // Instantiate your class using Get.put() to make it available for all "child" routes there.
    final controller = Get.put(MapController());
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Obx(() {
        return new Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                Container(
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      // New Google map Testing place

                      //For placing location information
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 5, bottom: 0),
                        child: TextButton(
                          child: Row(
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ProviderScope(
                                                        child: HomePageMap())));
                                      },
                                      icon: Icon(Icons.dashboard)),
                                  Icon(Icons.location_on),
                                  SizedBox(
                                    width: 300,
                                    child: Text(
                                      //{controller.Address}.toString()
                                      (controller.Address.toString() == '')
                                          ? 'Set Location'
                                          : controller.Address.toString(),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      softWrap: false,
                                      style: TextStyle(
                                        fontSize: 13.0,
                                        fontFamily: 'Rubik',
                                        color: new Color(0xFF212121),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          onPressed: () async {
                            MyMap m1 = MyMap();
                            await m1.getLocation();
                            controller.setLalitudeAndLongitude(m1.lat, m1.long);
                            Navigator.pushNamed(context, '/mapPage');
                          },
                        ),
                      ),
                      // search box and the favorite button
                      Padding(
                        padding: EdgeInsets.only(
                            left: defaultPadding,
                            right: defaultPadding,
                            top: 0,
                            bottom: 5),
                        child: Row(
                          // implementation of input field and favourite button
                          children: [
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: Colors.blue,
                                  ),
                                  prefixIconColor: Colors.blue,
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                  ),
                                  hintText: 'Search Menu of nearby Restaurants',
                                  alignLabelWithHint: true,
                                ),
                                onTap: () =>
                                    Navigator.pushNamed(context, '/searchPage'),
                              ),
                            ),
                            SizedBox(
                              width: sizedBoxWidth,
                            ),
                            // favorite button
                            SizedBox(
                              height: 60,
                              child: ElevatedButton(
                                child: Icon(
                                  Icons.favorite_border_outlined,
                                ),
                                onPressed: () =>
                                    Navigator.pushNamed(context, '/favorite'),
                              ),
                            )
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          // Implementation of filters of the list shown below

                          children: [
                            MaterialButton(
                              onPressed: () {},
                              child: Row(
                                children: [
                                  Icon(Icons.sort_by_alpha),
                                  Text('Sort By'),
                                ],
                              ),
                              color: scrollableButtonColor,
                            ),
                            SizedBox(
                              width: sizedBoxWidth,
                            ),
                            MaterialButton(
                              onPressed: () {},
                              child: Row(
                                children: [
                                  Icon(Icons.sort),
                                  Text('Filter'),
                                ],
                              ),
                              color: scrollableButtonColor,
                            ),
                            SizedBox(
                              width: sizedBoxWidth,
                            ),
                            MaterialButton(
                              onPressed: () {},
                              child: Row(
                                children: [
                                  Icon(Icons.star),
                                  Text('Above 4'),
                                ],
                              ),
                              color: scrollableButtonColor,
                            ),
                            SizedBox(
                              width: sizedBoxWidth,
                            ),
                            MaterialButton(
                              onPressed: () {},
                              child: Row(
                                children: [
                                  Icon(Icons.sort),
                                  Text('Menu Only'),
                                ],
                              ),
                              color: scrollableButtonColor,
                            )
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 10,
                        color: Color.fromARGB(153, 231, 231, 231),
                      ),
                      Container(
                        height: 70 / 100 * MediaQuery.of(context).size.height,
                        child: SingleChildScrollView(
                          // scrollDirection: Axis.vertical,
                          child: Column(
                            children: [
                              Image.network(
                                "https://previews.123rf.com/images/winnond/winnond2008/winnond200800004/152889333-find-nearby-restaurants-that-open-for-food-delivery-or-search-location-of-the-restaurant-for-a-meal-.jpg",
                                height: 200,
                              ),
                              Image.network(
                                "https://previews.123rf.com/images/winnond/winnond2008/winnond200800004/152889333-find-nearby-restaurants-that-open-for-food-delivery-or-search-location-of-the-restaurant-for-a-meal-.jpg",
                                height: 200,
                              ),
                              Image.network(
                                "https://img.freepik.com/free-vector/modern-restaurant-menu-fast-food_52683-48982.jpg",
                                height: 200,
                              ),
                              Image.network(
                                "https://previews.123rf.com/images/winnond/winnond2008/winnond200800004/152889333-find-nearby-restaurants-that-open-for-food-delivery-or-search-location-of-the-restaurant-for-a-meal-.jpg",
                                height: 200,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        thickness: 10,
                        color: Color.fromARGB(153, 231, 231, 231),
                      ),

                      // SingleChildScrollView(
                      //   child: ListView.builder(
                      //       itemCount: ListOfItems.length,
                      //       itemBuilder: (context, index) {
                      //         final item = ListOfItems[index];

                      //         return ListTile(
                      //           title:
                      //               SizedBox(height: 4, child: Text('new title')),
                      //           subtitle: Text('new subtitle'),
                      //         );
                      //       }),
                      // ),
                    ],
                  ),
                ), // above unscrollable stacks item
              ],
            ),
          ),
        );
      }),
    );
  }
}

Widget func(BuildContext context, int i) {
  return Text('new $i');
}
