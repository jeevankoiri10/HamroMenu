import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MenuUploadPage extends StatefulWidget {
  const MenuUploadPage({super.key});

  @override
  State<MenuUploadPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuUploadPage> {
  String name = "";
  List<Map<String, dynamic>> data = [
    {
      'id': '1',
      'name': 'Pulchowk Campus Canteen',
      'image': 'https://pub.dev/static/hash-7ce71c4e/img/pub-dev-logo-2x.png',
      'email': 'jeevankoirima@gmail.com',
    },
    {
      'id': '2',
      'name': 'Pulchowk Ground Canteen',
      'image': 'https://pub.dev/static/hash-7ce71c4e/img/pub-dev-logo-2x.png',
      'email': 'jeevankoirima@gmail.com',
    }
  ];

  @override
  void initState() {
    super.initState();
    var count =
        FirebaseFirestore.instance.collection('MenuLinksNearby').count();
    print(count);
    // addData();
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              child: TextField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search), hintText: 'Search ..'),
                onChanged: ((value) {
                  name = value;
                  setState(() {});
                }),
              ),
            ),
            SizedBox(
              height: 600,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('MenuLinksNearby')
                    .snapshots(),
                builder: (context, snapshot) {
                  return ((snapshot.connectionState) == ConnectionState.waiting)
                      ? Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: ((context, index) {
                            var data = snapshot.data!.docs[index].data()
                                as Map<String, dynamic>;

                            //
                            if (name.isEmpty) {
                              return ListTile(
                                title: Text(
                                  data['name'],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  data['email'],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(data['image']),
                                ),
                              );
                            }

                            // Very important we can use startswith or contains
                            if (data['name']
                                .toString()
                                .startsWith(name.toLowerCase())) {
                              return ListTile(
                                title: Text(
                                  data['name'],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  data['email'],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(data['image']),
                                ),
                              );
                            }
                            return Container(); // to remove the error
                          }));
                  // return Container();
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  addData() async {
    for (var element in data) {
      FirebaseFirestore.instance.collection('MenuLinksNearby').add(element);
    }
    print('all data added');
  }
}
