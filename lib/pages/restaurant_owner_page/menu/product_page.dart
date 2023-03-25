// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:kapaas/pages/boutique_owner/pages/controllers/crud_firebase/controller_CRUD_Restaurants.dart';

// import '../CRUD/crud_controller.dart';

// class ProductPageOld extends StatelessWidget {
//   ProductPageOld({super.key});
//   TextEditingController _nameController = TextEditingController();

//   TextEditingController editNameController = TextEditingController();
//   Widget buildRestaurant(Restaurant Restaurant) => ListTile(
//         leading: CircleAvatar(child: Text('${Restaurant.id}')),
//         title: Text(Restaurant.name),
//         // subtitle: Text(Restaurant.birthday.toIso8601String()),
//       );

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             Text(
//               'Mahalaxmi Boutique',
//               textScaleFactor: 1.3,
//             ),
//             Text('Kupandole, Lalitpur'),
//             SizedBox(height: 10),
//             TextFormField(
//                 controller: _nameController,
//                 // onChanged: ((value) {}),
//                 decoration: new InputDecoration(
//                   labelText: "Enter Name",
//                   fillColor: Colors.white,
//                   border: new OutlineInputBorder(
//                     borderRadius: new BorderRadius.circular(25.0),
//                     borderSide: new BorderSide(),
//                   ),
//                 )),
//             ElevatedButton(
//                 onPressed: () async {
//                   await createRestaurant(name: _nameController.text);
//                   print('${_nameController.text}');
//                 },
//                 child: Text('Upload')),
//             Text('Items Enlisted are: '),
//             SizedBox(
//               height: 500,
//               child: StreamBuilder<List<Restaurant>>(
//                 stream: readRestaurants(),
//                 builder: (context, snapshot) {
//                   if (snapshot.hasError) {
//                     return Text('Something went wrong! ${snapshot.error}');
//                   } else if (snapshot.hasData) {
//                     final Restaurants = snapshot.data!;
//                     return ListView(
//                         children: Restaurants.map(buildRestaurant).toList());
//                   } else {
//                     return Center(child: LinearProgressIndicator());
//                   }
//                 },
//               ),

//               // new where we cannot change the UI of the app using the flutter
//               //
//               //     FutureBuilder<List<Restaurant>>(
//               //   future: readRestaurants().first,
//               //   builder: ((context, snapshot) {
//               //     if (snapshot.hasError) {
//               //       return Text('Something went Wrong! ${snapshot.error}');
//               //     } else if (snapshot.hasData) {
//               //       final Restaurants = snapshot.data!;

//               //       // change here
//               //       return ListView(children: Restaurants.map(buildRestaurant).toList());
//               //     } else {
//               //       return Center(child: LinearProgressIndicator());
//               //     }
//               //   }),
//               // ),
// //
//               // to show a single Restaurant with the cerain id
//               //     FutureBuilder<Restaurant?>(
//               //   future: readRestaurantOne(),
//               //   builder: ((context, snapshot) {
//               //     if (snapshot.hasError) {
//               //       return Text('Something went Wrong! ${snapshot.error}');
//               //     } else if (snapshot.hasData) {
//               //       final Restaurant = snapshot.data!;

//               //       // change here
//               //       return Restaurant == null
//               //           ? Center(
//               //               child: Text('No Restaurant'),
//               //             )
//               //           : buildRestaurant(
//               //               Restaurant); //ListView(children: Restaurants.map(buildRestaurant).toList());
//               //     } else {
//               //       return Center(child: CircularProgressIndicator());
//               //     }
//               //   }),
//               // ),
//               //
//               //
//             ),
//             Divider(),
//             TextFormField(
//                 controller: editNameController,
//                 // onChanged: ((value) {}),
//                 decoration: new InputDecoration(
//                   labelText: "Enter Name to update",
//                   fillColor: Colors.white,
//                   border: new OutlineInputBorder(
//                     borderRadius: new BorderRadius.circular(25.0),
//                     borderSide: new BorderSide(),
//                   ),
//                 )),
//             ElevatedButton(
//                 onPressed: () {
//                   // code for updating a particular Restaurant on the database
//                   final docRestaurant = FirebaseFirestore.instance
//                       .collection('Restaurants')
//                       .doc('my-id');

// // one way to update the data
//                   // docRestaurant.update({
//                   //   'name': editNameController.text,
//                   // });
// // to delete a field
//                   // docRestaurant.update({
//                   //   'name': FieldValue.delete(),
//                   // });

//                   docRestaurant.set({
//                     'name': 'James',
//                   });
//                 },
//                 child: Text('Update')),
//             ElevatedButton(
//                 onPressed: () {
//                   // code for updating a particular Restaurant on the database
//                   final docRestaurant = FirebaseFirestore.instance
//                       .collection('Restaurants')
//                       .doc('my-id');
//                   docRestaurant.delete();
//                 },
//                 child: Text('Delete a document')),
//           ],
//         ),
//       ),
//     );
//   }
// }
