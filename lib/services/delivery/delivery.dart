import 'package:flutter/material.dart';
import 'request_delivery.dart';
import 'track_delivery.dart';

AppBar deliveryAppBar = AppBar(title: const Text('Uthenge - Delivery Service'));

class DeliveryScreen extends StatelessWidget {
  const DeliveryScreen({super.key});
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: deliveryAppBar,
      body: ListView(
        children: [
          Image.asset(
            'images/photo.jpg',
            width: 600,
            height: 240,
            fit: BoxFit.cover,
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: ListTile(
              leading: const Icon(Icons.send),
              title: const Text('Request Delivery'),
              onTap: () =>
                  Navigator.pushNamed(context, RequestDeliveryScreen.routeName),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: ListTile(
              leading: const Icon(Icons.location_pin),
              title: const Text('Track Delivery'),
              onTap: () =>
                  Navigator.pushNamed(context, TrackDeliveryScreen.routeName),
            ),
          )
        ],
      ),
    );
  }
}
