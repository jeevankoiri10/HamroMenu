import 'package:flutter/material.dart';
import 'package:hamro_menu_getx/pages/customer_page/upload_details_customer.dart';

class RestaurantsAroundMe extends StatefulWidget {
  RestaurantsAroundMe({Key? key}) : super(key: key);

  _RestaurantsAroundMeState createState() => _RestaurantsAroundMeState();
}

class _RestaurantsAroundMeState extends State<RestaurantsAroundMe> {
  final TextStyle dropdownMenuItem =
      TextStyle(color: Colors.black, fontSize: 18);

  final primary = Color(0xff696b9e);
  final secondary = Color(0xfff29a94);

  final List<Map> schoolLists = [
    {
      "name": "Chiya Adda",
      "location": "Baneshwor, Kathmandu",
      "type": "Distance: 1 km",
      "logoText":
          "https://cdn.pixabay.com/photo/2017/03/16/21/18/logo-2150297_960_720.png"
    },
    {
      "name": "Sherpa Bakeries",
      "location": "Chakupat, Lalitpur",
      "type": "Distance: 400m",
      "logoText":
          "https://cdn.pixabay.com/photo/2016/06/09/18/36/logo-1446293_960_720.png"
    },
    {
      "name": "Mello Restaurant",
      "location": "Chakupat, Lalitpur",
      "type": "Distance: 200m",
      "logoText":
          "https://cdn.pixabay.com/photo/2017/03/16/21/18/logo-2150297_960_720.png"
    },
    {
      "name": "Himalayan Hotel",
      "location": "Chakupat Lalitpur",
      "type": "Distance: 200m",
      "logoText":
          "https://cdn.pixabay.com/photo/2017/01/31/13/14/animal-2023924_960_720.png"
    },
    {
      "name": "Dee's Restaurant",
      "location": "Chakupat, Lalitpur",
      "type": "Distance: 150m",
      "logoText":
          "https://cdn.pixabay.com/photo/2017/01/13/01/22/rocket-1976107_960_720.png"
    },
    {
      "name": "Dolakha Tea Shop",
      "location": "Chakupat, Lalitpur",
      "type": "Distance: 100m",
      "logoText":
          "https://cdn.pixabay.com/photo/2017/01/31/13/14/animal-2023924_960_720.png"
    },
    {
      "name": "Hotel Tarasara",
      "location": "Pulchowk, lalitpur",
      "type": "Distance: 100m",
      "logoText":
          "https://cdn.pixabay.com/photo/2017/01/13/01/22/rocket-1976107_960_720.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Feedbacks Boutique'),
      // ),
      backgroundColor: Color(0xfff0f0f0),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('Restaurants Around Me', textScaleFactor: 1.4),
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: <Widget>[
                    Container(
                      // color: Colors.black,
                      padding: EdgeInsets.only(top: 0),
                      height: MediaQuery.of(context).size.height,
                      width: double.infinity,
                      child: ListView.builder(
                          itemCount: schoolLists.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                                onTap: () {
                                  print('item clicked');
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              UploadMenuDetailsCustomer()));
                                },
                                child: buildList(context, index));
                          }),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildList(BuildContext context, int index) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
      ),
      width: double.infinity,
      height: 110,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 50,
            height: 50,
            margin: EdgeInsets.only(right: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(width: 3, color: secondary),
              image: DecorationImage(
                  image: NetworkImage(schoolLists[index]['logoText']),
                  fit: BoxFit.fill),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  schoolLists[index]['name'],
                  style: TextStyle(
                      color: primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.location_on,
                      color: secondary,
                      size: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(schoolLists[index]['location'],
                        style: TextStyle(
                            color: primary, fontSize: 13, letterSpacing: .3)),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.arrow_right,
                      color: secondary,
                      size: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(schoolLists[index]['type'],
                        style: TextStyle(
                            color: primary, fontSize: 13, letterSpacing: .3)),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
