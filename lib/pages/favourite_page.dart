import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hamro_menu_getx/pages/details_favourite_page.dart';

class FavouritePage extends StatelessWidget {
  FavouritePage({super.key});
  List Items = [7, 16, 17, 40];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                  // autofocus: true,
                  autocorrect: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.red,
                    ),
                    prefixIconColor: Colors.red,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(2.0)),
                    ),
                    hintText: 'Search favorite',
                  ),
                  onChanged: (value) {}),
            ),
            Container(
              child: SingleChildScrollView(
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: Items.length,
                    itemBuilder: (context, index) {
                      return Card(
                          child: ListTile(
                        title: Text('Favourite ${Items[index]}'),
                        // iconColor: Colors.blue,
                        leading: const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                        minLeadingWidth: 5,
                        trailing: const Icon(Icons.arrow_forward_ios),
                        horizontalTitleGap: 10,
                        onTap: () {
                          print('Item ${Items[index]}');
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                DetailsFavourite(indexSent: index),
                          ));
                        },
                        subtitle: Text('Subtitile: ${Items[index]}'),
                      ));
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyPhotoes extends StatelessWidget {
  const MyPhotoes({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
