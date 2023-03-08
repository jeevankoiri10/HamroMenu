import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_menu_getx/animated_google_map_page.dart';
import 'package:hamro_menu_getx/pages/login_pages/login_page.dart';
import 'package:hamro_menu_getx/pages/places_list_page.dart';
import 'controller/set_location_controller.dart';
import 'set_location_main_page.dart';

double defaultPadding = 15.0;
Color scrollableButtonColor =
    Colors.white; //Color.fromRGBO(196, 196, 196, 0.6);
double? sizedBoxWidth = 15.0;
double? sizedBoxHeight = 0.0;

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  bool isLoggedIn = false;
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
    final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

    // Instantiate your class using Get.put() to make it available for all "child" routes there.
    // final controller = Get.put(MapController());
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    // New Google map Testing place

                    //For placing location information
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15, right: 5, bottom: 0),
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
                                                      child:
                                                          AnimatedGoogleMap())));
                                    },
                                    icon: Icon(Icons.dashboard)),
                                Icon(Icons.location_on),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 1.75,
                                  child: Text(
                                    (isAddressAssigned == false)
                                        ? 'Set Location'
                                        : '${latitude.toStringAsFixed(2)} Latitude and ${longitude.toStringAsFixed(2)} Longitude',
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
                                // the profile button at the right of the location
                                IconButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LogInPage()));
                                    },
                                    icon: Icon(Icons.person)),
                              ],
                            ),
                          ],
                        ),
                        // Place to show the text for the map on the homepage
                        onPressed: () async {
                          await getLocation();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => MapPage()));
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
                            // PlacesListGoogleMap(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.network(
                                'https://d27k8xmh3cuzik.cloudfront.net/wp-content/uploads/2018/09/CoverKathmanduRestoepb0310.jpg',
                                height: 200,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.network(
                                "https://www.emilyluxton.co.uk/wp-content/uploads/2017/06/abhishek-sanwa-limbu-782224-unsplash-800x534.jpg",
                                height: 200,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.network(
                                "https://holidaynepaltreks.com/wp-content/uploads/2018/12/bhojan-griha.jpg",
                                height: 200,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.network(
                                "https://b.zmtcdn.com/data/pictures/3/18426303/9a859a16bb7e2259988c65fcee21babe.jpg",
                                height: 250,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.network(
                                "https://img.freepik.com/free-vector/modern-restaurant-menu-fast-food_52683-48982.jpg",
                                height: 180,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.network(
                                "https://c8.alamy.com/comp/2EENMYP/fast-food-menu-template-for-fastfood-restaurant-or-cafe-vector-sketch-price-list-for-hot-dog-and-fries-combo-pizza-or-cheeseburger-and-hamburger-san-2EENMYP.jpg",
                                height: 200,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.network(
                                "https://media-cdn.tripadvisor.com/media/photo-p/0e/42/c8/37/the-menu.jpg",
                                height: 300,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.network(
                                "https://images.pexels.com/photos/1633578/pexels-photo-1633578.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
                                height: 300,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.network(
                                "https://images.pexels.com/photos/541216/pexels-photo-541216.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
                                height: 300,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.network(
                                "https://img.freepik.com/free-vector/burgers-restaurant-menu-template_23-2149005028.jpg?w=2000",
                                height: 250,
                              ),
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
                ), // above unscrollable stacks item
              ],
            ),
          ),
        ),
      ),
    );
  }
}
