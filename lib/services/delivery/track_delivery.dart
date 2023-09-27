import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uthengeapp/core/data_types.dart';

class TrackDeliveryScreen extends StatefulWidget {
  const TrackDeliveryScreen({super.key});
  static const routeName = '/delivery/track';

  @override
  State<StatefulWidget> createState() => _TrackDeliveryState();
}

class _TrackDeliveryState extends State<TrackDeliveryScreen> {
  String phone = '';
  List<DeliveryRequest> deliveryRequests = [];
  Column deliveryRequestsWidget = const Column();
  FirebaseFirestore db = FirebaseFirestore.instance;

  void _trackPhone() {
    if (phone != '') {
      db
          .collection('delivery')
          .where('phone', isEqualTo: phone)
          .get()
          .then((event) {
        setState(() {
          deliveryRequests = event.docs.map((e) {
            return DeliveryRequest.fromFirebase(e);
          }).toList();
        });
      }).onError((error, stackTrace) {
        //
      });
    }
  }

  TextButton _cancelButton(DeliveryRequest req) {
    if (req.status != 'pending') {
      return TextButton(
          onPressed: () {},
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.red),
          ));
    } else {
      return TextButton(
          onPressed: () {
            //delete this item from firebase
            _trackPhone();
          },
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.red),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (deliveryRequests.isNotEmpty) {
      deliveryRequestsWidget = Column(
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
                        padding: const EdgeInsets.all(8),
                        child: ListView(
                          children: [
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
                                const Expanded(child: Text('Detail')),
                                Text(e.detail)
                              ],
                            ),
                            Row(
                              children: [
                                const Expanded(child: Text('Phone')),
                                Text(e.phone)
                              ],
                            ),
                            Column(
                              children: e.items.map((ei) {
                                return ListTile(
                                  leading: Text(ei.price.toString()),
                                  title: Text(ei.name),
                                );
                              }).toList(),
                            ),
                            Row(
                              children: [
                                const Expanded(child: Text('Delivery Fee')),
                                Text(e.deliveryFee().toString())
                              ],
                            ),
                            Row(
                              children: [
                                const Expanded(child: Text('Total')),
                                Text(e.totalPrice().toString())
                              ],
                            ),
                            Row(
                              children: [
                                const Expanded(child: Text('Status')),
                                Text(e.status)
                              ],
                            ),
                            const Divider(),
                            Row(
                              children: [
                                TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: const Text('Close')),
                                _cancelButton(e)
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            },
          );
        }).toList(),
      );
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Uthenge - Delivery Service')),
      body: Container(
        padding: const EdgeInsets.all(32),
        child: ListView(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                        hintText: '09-- ------', labelText: 'Phone'),
                    onChanged: (value) {
                      phone = value;
                    },
                  ),
                ),
                TextButton(
                  child: const Text('Track'),
                  onPressed: () {
                    _trackPhone();
                    //_trackReference();
                  },
                )
              ],
            ),
            deliveryRequestsWidget
          ],
        ),
      ),
    );
  }

  void _trackReference() {
    if (phone != '') {
      setState(() {
        deliveryRequests.add(DeliveryRequest(
            from: 'across',
            to: 'across',
            detail: 'room 5',
            phone: '0987654',
            items: <DeliveryItem>[
              const DeliveryItem('fish', 0.0),
              const DeliveryItem('drink', 0.0),
              const DeliveryItem('bread', 0.0),
              const DeliveryItem('butter', 0.0),
            ]));
      });
    }
  }
}
