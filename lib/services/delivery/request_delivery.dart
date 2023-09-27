import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uthengeapp/core/data_types.dart';

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
        builder: (_) {
          return Dialog(
            child: Container(
              padding: const EdgeInsets.all(32),
              child: const CircularProgressIndicator(),
            ),
          );
        });
    deliveryRequest.save(db, (saved, value) {
      if (saved) {
        Navigator.of(context).pop();
        setState(() {
          deliveryRequest = DeliveryRequest(
              from: 'across',
              to: 'across',
              detail: '',
              phone: '',
              items: <DeliveryItem>[]);
          doc = '$value Request sent! you can track it to check its status.';
        });
      } else {
        Navigator.of(context).pop();
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
        appBar: AppBar(title: const Text('Uthenge - Delivery Service')),
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
