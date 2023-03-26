import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../restaurant_owner_page/user/user_crud.dart';

class UploadMenuDetailsCustomer extends StatefulWidget {
  const UploadMenuDetailsCustomer({super.key});

  @override
  State<UploadMenuDetailsCustomer> createState() =>
      _UploadMenuDetailsCustomerState();
}

class _UploadMenuDetailsCustomerState extends State<UploadMenuDetailsCustomer> {
  Widget buildItem(Items item) => ListTile(
        leading: CircleAvatar(child: Text('${item.price}')),
        title: Text(item.item),
        subtitle: Text('Created On: ${item.createdOn.toIso8601String()}'),
        // trailing: IconButton(onPressed: () {}, icon: Icon(Icons.edit)),

        isThreeLine: true,
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Details')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              child: Expanded(
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection('myCollection')
                      .orderBy('timestamp', descending: false)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }

                    final documents = snapshot.data!.docs;

                    return ListView.builder(
                      itemCount: documents.length,
                      itemBuilder: (context, index) {
                        final document = documents[index];
                        final text = document['text'] as String?;
                        final timestamp = document['timestamp'] as Timestamp?;

                        return ListTile(
                          title: Image.network(text ?? ''),
                          //subtitle: Text(timestamp?.toDate().toString() ?? ''),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
            Text('Items Enlisted are: '),
            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              child: StreamBuilder<List<Items>>(
                stream: readItems(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong! ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    final users = snapshot.data!;
                    return ListView(children: users.map(buildItem).toList());
                  } else {
                    return Center(child: LinearProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
