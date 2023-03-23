import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MenuPageHome extends StatelessWidget {
  const MenuPageHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Text(
                'List of Menus',
                textScaleFactor: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
