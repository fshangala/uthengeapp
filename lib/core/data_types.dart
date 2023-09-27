import 'package:cloud_firestore/cloud_firestore.dart';

class DeliveryItem {
  final String name;
  final double price;
  const DeliveryItem(this.name, this.price);

  Map<String, dynamic> itemData() {
    return {"name": name, "price": price};
  }
}

class DeliveryRequest {
  String? id;
  String from;
  String to;
  String detail;
  String phone;
  List<DeliveryItem> items;
  double unitPrice = 10.0;
  String status = "pending";

  List<String> locations = [
    'across',
    'down-school',
    'up-school',
    'manos-king-george'
  ];
  Map<String, int> locationValues = {
    'across': 5,
    'down-school': 6,
    'up-school': 7,
    'manos-king-george': 4
  };

  DeliveryRequest(
      {this.id,
      required this.from,
      required this.to,
      required this.detail,
      required this.phone,
      required this.items});

  double deliveryFeeValue() {
    double a = (locationValues[from]! - locationValues[to]!) / 2;
    if (a < 0) {
      a = (-1) * a;
    }
    return a + 1;
  }

  double deliveryFee() {
    return deliveryFeeValue() * unitPrice;
  }

  double totalPrice() {
    double total = deliveryFee();
    for (DeliveryItem item in items) {
      total += item.price;
    }
    return total;
  }

  Map<String, dynamic> requestData() {
    return {
      "from": from,
      "to": to,
      "detail": detail,
      "phone": phone,
      "items": items.map((e) => e.itemData())
    };
  }

  void save(FirebaseFirestore firestore, void Function(bool, String) callback) {
    firestore
        .collection("delivery")
        .add(requestData())
        .then((value) => callback(true, value.id))
        .onError((error, stackTrace) => callback(false, error.toString()));
  }

  static DeliveryRequest fromFirebase(
          QueryDocumentSnapshot<Map<String, dynamic>> snapshot) =>
      DeliveryRequest(
          id: snapshot.id,
          from: snapshot.data()['from'],
          to: snapshot.data()['to'],
          detail: snapshot.data()['detail'],
          phone: snapshot.data()['phone'],
          items: snapshot
              .data()['items']
              .map((Map<String, dynamic> e) =>
                  DeliveryItem(e['name'], e['price']))
              .toList());
  //const DeliveryRequest( this.from, this.to, this.detail, this.phone, this.items);
}

class DeliveryFilter {
  String name;
  String value;
  DeliveryFilter(this.name, this.value);
}
