import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class DetailsFavourite extends StatelessWidget {
  DetailsFavourite({required this.indexSent});
  int indexSent;
  List<String> ItemsDetails = [
    'String 1',
    'String 2',
    'String 3',
    'String 4',
    'String 5',
    'String 6',
    'String 7',
    'String 8',
    'String 9',
    'String 10',
    'String 11',
    'String 12',
    'String 13',
    'String 14',
    'String 15',
    'String 16',
    'String 17',
    'String 18',
    'String 19',
    'String 20',
    'String 21',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Details Favourite Page'),
        ),
        body: Text(
            'This is the details favourite page of index ${this.indexSent} and data is ${ItemsDetails[indexSent]}'));
  }
}
