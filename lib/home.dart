import 'package:flutter/material.dart';
import 'services/delivery/delivery.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Uthenge - Services'),
        ),
        body: ListView(
          children: [
            Image.asset(
              'images/photo.jpg',
              fit: BoxFit.cover,
            ),
            Container(
              padding: const EdgeInsets.all(32),
              child: ListTile(
                title: const Text('Delivery'),
                onTap: () =>
                    Navigator.pushNamed(context, DeliveryScreen.routeName),
              ),
            )
          ],
        ));
  }
}
