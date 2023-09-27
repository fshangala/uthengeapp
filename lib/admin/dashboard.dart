import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uthengeapp/core/data_types.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});
  static const routeName = '/admin';

  @override
  State<StatefulWidget> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool init = false;
  List<DeliveryRequest> deliveryRequests = [];
  DeliveryFilter deliveryFilter = DeliveryFilter('status', 'pending');

  FirebaseFirestore db = FirebaseFirestore.instance;

  Column _renderDeliveryRequests() {
    if (deliveryRequests.isNotEmpty) {
      return Column(
          children: deliveryRequests.map((e) {
        return ListTile(
          title: Text(e.totalPrice().toString()),
          subtitle: Text(e.status),
          onTap: () {
            showDialog(
                context: context,
                builder: (_) {
                  return Dialog(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      child: Column(children: [
                        Row(
                          children: [
                            const Expanded(child: Text('From')),
                            Text(e.from)
                          ],
                        ),
                        Row(
                          children: [
                            const Expanded(child: Text('To')),
                            Text(e.to)
                          ],
                        ),
                        Row(
                          children: [
                            const Expanded(child: Text('detail')),
                            Text(e.detail)
                          ],
                        ),
                        Row(
                          children: [
                            const Expanded(child: Text('phone')),
                            Text(e.phone)
                          ],
                        ),
                        Column(
                            children: e.items
                                .map((ei) => Row(children: [
                                      Expanded(child: Text(ei.name)),
                                      Text(ei.price.toString())
                                    ]))
                                .toList()),
                        Row(
                          children: [
                            const Expanded(child: Text('Total Price')),
                            Text(e.totalPrice().toString())
                          ],
                        )
                      ]),
                    ),
                  );
                });
          },
        );
      }).toList());
    } else {
      return const Column(
        children: [Text('No items to show')],
      );
    }
  }

  void _fetchDeliveries() {
    db
        .collection('/delivery')
        .where(deliveryFilter.name, isEqualTo: deliveryFilter.value)
        .get()
        .then((event) {
      setState(() {
        deliveryRequests =
            event.docs.map((e) => DeliveryRequest.fromFirebase(e)).toList();
        init = true;
      });
    }).onError((error, stackTrace) {
      init = true;
    });
  }

  void _initialize() {
    if (!init) {
      _fetchDeliveries();
    }
  }

  @override
  Widget build(BuildContext context) {
    _initialize();
    return Scaffold(
      appBar: AppBar(title: const Text('Uthenge - Dashboard')),
      body: Container(
        padding: const EdgeInsets.all(32),
        child: ListView(
          children: [
            Row(
              children: [
                const Expanded(child: Text('Filter Status')),
                DropdownButton(
                    items: ['pending', 'processing']
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        deliveryFilter = DeliveryFilter('status', value!);
                      });
                    })
              ],
            ),
            _renderDeliveryRequests()
          ],
        ),
      ),
    );
  }
}
