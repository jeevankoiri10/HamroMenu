import 'package:flutter/material.dart';

import '../util/restaurants.dart';
import '../widgets/search_card.dart';
import '../widgets/trending_item.dart';

class TrendingDetails extends StatefulWidget {
  const TrendingDetails({Key? key, required this.indexHere}) : super(key: key);
  final int indexHere;

  @override
  State<TrendingDetails> createState() => _TrendingDetailsState();
}

class _TrendingDetailsState extends State<TrendingDetails> {
  @override
  Widget build(BuildContext context) {
    setState(() {});
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
              itemCount: 1, //restaurants == null ? 0 : restaurants.length,
              itemBuilder: (BuildContext context, int indexHere) {
                Map restaurant = restaurants[indexHere];

                return TrendingItem(
                  img: restaurant["img"],
                  title: restaurant["title"],
                  address: restaurant["address"],
                  rating: restaurant["rating"],
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
