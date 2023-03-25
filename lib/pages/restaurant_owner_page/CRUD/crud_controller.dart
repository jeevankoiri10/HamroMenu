import 'package:cloud_firestore/cloud_firestore.dart';

class Restaurant {
  final String id;
  final String name;
  final String location;
  final List<String> items;
  final String URL;
  final List<String> orderedBy;
  final Map<String, int> orders;

  Restaurant({
    required this.id,
    required this.name,
    required this.location,
    required this.items,
    required this.URL,
    required this.orderedBy,
    required this.orders,
  });

  // Convert Firestore document to Restaurant object
  factory Restaurant.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Restaurant(
      id: doc.id,
      name: data['name'],
      location: data['location'],
      items: List<String>.from(data['items']),
      URL: data['URL'],
      orderedBy: List<String>.from(data['orderedBy']),
      orders: Map<String, int>.from(data['orders']),
    );
  }

  // Convert Restaurant object to Firestore document
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'location': location,
      'items': items,
      'URL': URL,
      'orderedBy': orderedBy,
      'orders': orders,
    };
  }
}

class RestaurantService {
  final CollectionReference RestaurantsCollection =
      FirebaseFirestore.instance.collection('Restaurants');

  // Add a new Restaurant to Firestore
  Future<void> addRestaurant(Restaurant Restaurant) async {
    await RestaurantsCollection.doc(Restaurant.id)
        .set(Restaurant.toFirestore());
  }

  // Get a Restaurant from Firestore by ID
  Future<Restaurant?> getRestaurantById(String id) async {
    DocumentSnapshot snapshot = await RestaurantsCollection.doc(id).get();
    if (snapshot.exists) {
      return Restaurant.fromFirestore(snapshot);
    } else {
      return null;
    }
  }

  // Get a list of all Restaurants in Firestore
  Future<List<Restaurant>> getAllRestaurants() async {
    QuerySnapshot snapshot = await RestaurantsCollection.get();
    return snapshot.docs.map((doc) => Restaurant.fromFirestore(doc)).toList();
  }

  // Update an existing Restaurant in Firestore
  Future<void> updateRestaurant(Restaurant Restaurant) async {
    await RestaurantsCollection.doc(Restaurant.id)
        .update(Restaurant.toFirestore());
  }

  // Delete a Restaurant from Firestore
  Future<void> deleteRestaurant(String id) async {
    await RestaurantsCollection.doc(id).delete();
  }

  // get Restaurant stream
  Stream<List<Restaurant>> getRestaurantsStream() {
    return RestaurantsCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Restaurant.fromFirestore(doc);
      }).toList();
    });
  }

  void addRestaurantItem(String itemName) async {
    try {
      DocumentReference docRef = RestaurantsCollection.doc('Restaurant1');
      await docRef.update({
        'items': FieldValue.arrayUnion([itemName])
      });
      print('Item added to Restaurant1');
    } catch (e) {
      print('Error adding item to Restaurant1: $e');
    }
  }

  //

}

// void main() async {
//   RestaurantService RestaurantService = RestaurantService();

//   // Add a new Restaurant to Firestore
//   Restaurant Restaurant1 = Restaurant(
//     id: 'Restaurant1',
//     name: 'Restaurant 1',
//     location: 'Location 1',
//     items: ['Item 1', 'Item 2', 'Item 3'],
//     URL: 'Measurement details 1',
//     orderedBy: ['User 1', 'User 2'],
//     orders: {'Item 1': 5, 'Item 2': 3},
//   );
//   await RestaurantService.addRestaurant(Restaurant1);

//   // Get a Restaurant from Firestore by ID
//   Restaurant? Restaurant2 = await RestaurantService.getRestaurantById('Restaurant1');
//   if (Restaurant2 != null) {
//     print(Restaurant2.name);
//   }

//   // Update an existing Restaurant in Firestore
//   Restaurant2?.name = 'Updated Restaurant 1';
//   await RestaurantService.updateRestaurant(Restaurant2!);

//   // Delete a Restaurant from Firestore
//   await RestaurantService.deleteRestaurant('Restaurant1');

//   // Get a list of all Restaurants in Firestore
//   List<Restaurant> Restaurants = await RestaurantService.getAllRestaurants();
//   for (Restaurant Restaurant in Restaurants) {
//     print('${Restaurant.id}: ${Restaurant.name}');
//   }
// }

// //   // Update an existing Restaurant in Firestore
