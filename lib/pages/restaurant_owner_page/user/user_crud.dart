import 'package:cloud_firestore/cloud_firestore.dart';

//CRUD operations are here

// main functions are:
Future createItem({required String item, required int price}) async {
  // reference to document
  // final docUser =
  //     FirebaseFirestore.instance.collection('users').doc('my-id1');

  // for the user class model
  final docItem = FirebaseFirestore.instance.collection('items').doc();

  // adding the data to be stored here in map
  //
  final user = Items(
    id: docItem.id,
    item: item,
    price: price,
    createdOn: DateTime.now(),
  );

  // create document and write data to Firebase
  // await docUser.set(json);
  await docItem.set(user.toJson());
}

class Items {
  // create .json of these all fields to convert a model to a json s
  String id;
  final String item;
  final int price;
  final DateTime createdOn;

  Items(
      {this.id = '',
      required this.item,
      required this.price,
      required this.createdOn});

  // model to json conversion and use toJson to access it.
  Map<String, dynamic> toJson() =>
      {'id': id, 'item': item, 'price': price, 'createdOn': createdOn};

  // added for the read operation
  static Items fromJson(Map<String, dynamic> json) => Items(
        id: json['id'],
        item: json['item'],
        price: json['price'],
        createdOn: (json['createdOn'] as Timestamp).toDate(),
      );
}

// Now for the read operations
Stream<List<Items>> readItems() => FirebaseFirestore.instance
    .collection('items')
    .snapshots()
    .map((snapshot) => snapshot.docs
        .map((doc) => Items.fromJson(doc.data()))
        .toList()); // snapshot gives the json data so convert it to model type

// readUsers() for only one users with FutureBuilder
Future<Items?> readUserOne() async {
  // get documents by id
  final docUser = FirebaseFirestore.instance.collection('users').doc('my-id');
  final snapshot = await docUser.get();
  if (snapshot.exists) {
    return Items.fromJson(snapshot.data()!);
  }
}


// Updatiing the user via UI only 