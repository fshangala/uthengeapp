import 'package:cloud_firestore/cloud_firestore.dart';

List<Database> databases = [
  FirebaseDatabase(),
];

abstract class Database {
  static Database getDatabase() {
    return databases[0];
  }

  void setItem(String collection, Map<String, dynamic> data,
      void Function(bool saved, String value) callback) {
    throw UnimplementedError();
  }

  void getItems(String collection,
      void Function(bool success, List<Map<String, dynamic>> value) callback) {
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
      void Function(bool success, List<Map<String, dynamic>> value) callback) {
    instance.collection(collection).get().then(
        (value) => callback(true, value.docs.map((e) => e.data()).toList()));
  }
}
