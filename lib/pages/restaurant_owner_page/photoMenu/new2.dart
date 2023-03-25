import 'package:flutter/material.dart';

class ImageGrid extends StatelessWidget {
  final List<String> imageUrls;

  ImageGrid({required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(imageUrls.length, (index) {
        return Image.network(imageUrls[index]);
      }),
    );
  }
}
