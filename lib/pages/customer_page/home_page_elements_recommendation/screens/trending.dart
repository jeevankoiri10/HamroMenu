import 'package:flutter/material.dart';
import './home.dart';
import './trending_details.dart';
import '../util/restaurants.dart';
import '../widgets/search_card.dart';
import '../widgets/trending_item.dart';

class Trending extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Trending Restaurants"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 0,
          horizontal: 10.0,
        ),
        child: ListView(
          children: <Widget>[
            SearchCard(),
            SizedBox(height: 10.0),
            ListView.builder(
              primary: false,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: restaurants == null ? 0 : restaurants.length,
              itemBuilder: (BuildContext context, int index) {
                Map restaurant = restaurants[index];

                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) =>
                                TrendingDetails(indexHere: index))));
                  },
                  child: TrendingItem(
                    img: restaurant["img"],
                    title: restaurant["title"],
                    address: restaurant["address"],
                    rating: restaurant["rating"],
                  ),
                );
              },
            ),
            SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}
