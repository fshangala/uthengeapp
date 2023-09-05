import 'package:flutter/material.dart';
import 'package:uthengeapp/services/delivery/includes.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});
  static const routeName = '/admin';

  @override
  State<StatefulWidget> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<DeliveryRequest> deliveryRequests = [];

  Column _renderDeliveryRequests() {
    if (deliveryRequests.isNotEmpty) {
      return Column(
          children: deliveryRequests.map((e) {
        return ListTile(
          title: Text(e.totalPrice().toString()),
          subtitle: Text(e.status),
        );
      }).toList());
    } else {
      return Column();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Uthenge - Dashboard')),
      body: Container(
        padding: const EdgeInsets.all(32),
        child: ListView(
          children: [_renderDeliveryRequests()],
        ),
      ),
    );
  }
}
