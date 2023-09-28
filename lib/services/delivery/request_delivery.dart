import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uthengeapp/core/data_types.dart';
import 'package:uthengeapp/core/function.dart';

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
  var doc = '';

  void _submitRequest() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return Dialog(
            child: Container(
              padding: const EdgeInsets.all(32),
              child: const Center(child: CircularProgressIndicator()),
            ),
          );
        });
    deliveryRequest.save((saved, value) {
      if (saved) {
        Navigator.pushNamed(context, RequestDeliveryScreen.routeName);
      } else {
        setState(() {
          doc = value;
        });
      }
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
        appBar: appBar('Request Delivery'),
        body: Container(
          padding: const EdgeInsets.all(32),
          child: ListView(
            children: [
              Row(
                children: [
                  const Expanded(child: Text('Delivery Fee')),
                  Text(deliveryRequest.deliveryFee().toString())
                ],
              ),
              Row(
                children: [
                  const Expanded(child: Text('Delivery from:')),
                  DropdownButton(
                    value: deliveryRequest.from,
                    items: deliveryRequest.locations.map((String item) {
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
                    items: deliveryRequest.locations.map((String item) {
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
              TextField(
                decoration: const InputDecoration(
                    hintText: '+260',
                    labelText: 'Phone',
                    border: UnderlineInputBorder()),
                onChanged: (value) => deliveryRequest.phone = value,
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
