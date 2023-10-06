import 'dart:js_interop';

import 'package:cloud_firestore/cloud_firestore.dart';

List<Database> databases = [
  FirebaseDatabase(),
];

enum WhereOperator { isEqualTo, isNotEqualTo, isNull }

abstract class Database {
  static Database getDatabase() {
    return databases[0];
  }

  void setItem(String collection, Map<String, dynamic> data,
      void Function(bool saved, String value) callback) {
    throw UnimplementedError();
  }

  void getItems(String collection,
      void Function(bool success, List<Map<String, dynamic>> data) callback) {
    throw UnimplementedError();
  }

  void getWhere(
      String collection,
      String name,
      WhereOperator whereOperator,
      Object value,
      void Function(bool success, List<Map<String, dynamic>> data) callback) {
    throw UnimplementedError();
  }
}

class FirebaseDatabase extends Database {
  FirebaseFirestore instance = FirebaseFirestore.instance;

  @override
  void setItem(String collection, Map<String, dynamic> data,
      void Function(bool saved, String value) callback) {
    instance
        .collection(collection)
        .add(data)
        .then((value) => callback(true, value.id))
        .onError((error, stackTrace) => callback(false, error.toString()));
  }

  @override
  void getItems(String collection,
      void Function(bool success, List<Map<String, dynamic>> data) callback) {
    instance.collection(collection).get().then(
        (value) => callback(true, value.docs.map((e) => e.data()).toList()));
  }

  @override
  void getWhere(
      String collection,
      String name,
      WhereOperator whereOperator,
      Object value,
      void Function(bool success, List<Map<String, dynamic>> data) callback) {
    var ref = instance.collection(collection);
    Query? query;
    switch (whereOperator) {
      case WhereOperator.isEqualTo:
        query = ref.where(name, isEqualTo: value);
        break;
      default:
        break;
    }
    if (query.isNull) {
      callback(false, []);
    } else {
      query
          ?.get()
          .then((value) => callback(
              true,
              value.docs.map((e) {
                Map<String, dynamic> d = e.data() as Map<String, dynamic>;
                d['id'] = e.id;
                return d;
              }).toList()))
          .onError((error, stackTrace) => callback(false, []));
    }
  }
}
