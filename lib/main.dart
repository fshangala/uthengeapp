import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'services/delivery/delivery.dart';
import 'services/delivery/request_delivery.dart';
import 'services/delivery/track_delivery.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Uthenge',
      initialRoute: '/',
      routes: {
        //HomeScreen.routeName: (context) => const HomeScreen(),
        DeliveryScreen.routeName: (context) => const DeliveryScreen(),
        RequestDeliveryScreen.routeName: (context) =>
            const RequestDeliveryScreen(),
        TrackDeliveryScreen.routeName: (context) => const TrackDeliveryScreen()
      },
    );
  }
}
