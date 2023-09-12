import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

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

class DeliveryItem {
  final String name;
  final double price;
  const DeliveryItem(this.name, this.price);

  Map<String, dynamic> itemData() {
    return {"name": name, "price": price};
  }
}

class DeliveryRequest {
  String from;
  String to;
  String detail;
  String phone;
  List<DeliveryItem> items;

  List<String> fromItems = ['across', 'down-school', 'up-school'];
  List<String> toItems = ['across', 'down-school', 'up-school'];

  DeliveryRequest(
      {required this.from,
      required this.to,
      required this.detail,
      required this.phone,
      required this.items});

  Map<String, dynamic> requestData() {
    return {
      "from": from,
      "to": to,
      "detail": detail,
      "phone": phone,
      "items": items.map((e) => e.itemData())
    };
  }
  //const DeliveryRequest( this.from, this.to, this.detail, this.phone, this.items);
}

class RequestDeliveryScreen extends StatefulWidget {
  const RequestDeliveryScreen({super.key});

  static const routeName = '/delivery/request';

  @override
  State<StatefulWidget> createState() {
    return _RequestDeliveryState();
  }
}

class _RequestDeliveryState extends State<RequestDeliveryScreen> {
  var db = FirebaseFirestore.instance;
  DeliveryRequest deliveryRequest = DeliveryRequest(
      from: 'across',
      to: 'across',
      detail: '',
      phone: '',
      items: <DeliveryItem>[]);

  var addItem = '';
  var doc = 'New';

  void _submitRequest() {
    db.collection("delivery").add(deliveryRequest.requestData()).then((value) {
      setState(() {
        doc = value.path;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> listDeliveryItems = deliveryRequest.items.map((item) {
      return ListTile(
        title: Text(item.name),
      );
    }).toList();
    return Scaffold(
        appBar: deliveryAppBar,
        body: Container(
          padding: const EdgeInsets.all(32),
          child: ListView(
            children: [
              Row(
                children: [
                  const Expanded(child: Text('Delivery from:')),
                  DropdownButton(
                    value: deliveryRequest.from,
                    items: deliveryRequest.fromItems.map((String item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        deliveryRequest.from = value!;
                      });
                    },
                  )
                ],
              ),
              Row(
                children: [
                  const Expanded(child: Text('Delivery to:')),
                  DropdownButton(
                    value: deliveryRequest.to,
                    items: deliveryRequest.toItems.map((String item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        deliveryRequest.to = value!;
                      });
                    },
                  )
                ],
              ),
              TextField(
                decoration: const InputDecoration(
                    hintText: 'Whitehouse Apartment 1, room 16',
                    labelText: 'Location Detail',
                    border: UnderlineInputBorder()),
                onChanged: (value) => deliveryRequest.detail = value,
              ),
              Column(children: listDeliveryItems),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                          hintText: 'Enter item',
                          labelText: 'Enter item',
                          border: UnderlineInputBorder()),
                      onChanged: (value) {
                        addItem = value;
                      },
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        if (addItem != '') {
                          deliveryRequest.items.add(DeliveryItem(addItem, 0.0));
                        }
                      });
                    },
                    child: const Text('Add'),
                  )
                ],
              ),
              Container(
                padding: const EdgeInsets.all(32),
                child: TextButton(
                  onPressed: () {
                    _submitRequest();
                  },
                  child: const Text('Submit request'),
                ),
              ),
              Text(doc)
            ],
          ),
        ));
  }
}

class TrackDeliveryScreen extends StatefulWidget {
  const TrackDeliveryScreen({super.key});
  static const routeName = '/delivery/track';

  @override
  State<StatefulWidget> createState() => _TrackDeliveryState();
}

class _TrackDeliveryState extends State<TrackDeliveryScreen> {
  var reference = '';
  DeliveryRequest? deliveryRequest;
  Column deliveryRequestWidget = const Column();

  @override
  Widget build(BuildContext context) {
    if (deliveryRequest != null) {
      deliveryRequestWidget = Column(
        children: [
          Row(
            children: [
              const Expanded(child: Text('From')),
              Text(deliveryRequest!.from)
            ],
          ),
          Row(
            children: [
              const Expanded(child: Text('To')),
              Text(deliveryRequest!.to)
            ],
          ),
          Row(
            children: [
              const Expanded(child: Text('Detail')),
              Text(deliveryRequest!.detail)
            ],
          ),
          Row(
            children: [
              const Expanded(child: Text('Phone')),
              Text(deliveryRequest!.phone)
            ],
          ),
          Column(
            children: deliveryRequest!.items.map((e) {
              return ListTile(
                title: Text(e.name),
                subtitle: Text(e.price.toString()),
              );
            }).toList(),
          )
        ],
      );
    }
    return Scaffold(
      appBar: deliveryAppBar,
      body: Container(
        padding: const EdgeInsets.all(32),
        child: ListView(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                        hintText: 'Enter reference', labelText: 'Reference'),
                    onChanged: (value) {
                      reference = value;
                    },
                  ),
                ),
                TextButton(
                  child: const Text('Track'),
                  onPressed: () {
                    _trackReference();
                  },
                )
              ],
            ),
            deliveryRequestWidget
          ],
        ),
      ),
    );
  }

  void _trackReference() {
    if (reference != '') {
      setState(() {
        deliveryRequest = DeliveryRequest(
            from: 'across',
            to: 'across',
            detail: 'room 5',
            phone: '0987654',
            items: <DeliveryItem>[
              const DeliveryItem('fish', 0.0),
              const DeliveryItem('drink', 0.0),
              const DeliveryItem('bread', 0.0),
              const DeliveryItem('butter', 0.0),
            ]);
      });
    }
  }
}
