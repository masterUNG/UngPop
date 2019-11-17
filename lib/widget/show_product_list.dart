import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShowProductList extends StatefulWidget {
  @override
  _ShowProductListState createState() => _ShowProductListState();
}

class _ShowProductListState extends State<ShowProductList> {
  // Field
  List<String> names = [];
  List<String> details = List();
  List<String> pictures = List();

  // Method
  @override
  void initState() {
    super.initState();
    readDataThread();
  }

  Future<void> readDataThread() async {
    Firestore firestore = Firestore.instance;
    CollectionReference collectionReference = firestore.collection('Product');
    await collectionReference.snapshots().listen((querySnapshot) {
      List<DocumentSnapshot> snapshots = querySnapshot.documents;
      for (var snapshot in snapshots) {
        print('Name = ${snapshot.data['Name']}');

        setState(() {
          names.add(snapshot.data['Name']);
          details.add(snapshot.data['Detail']);
          pictures.add(snapshot.data['Picture']);
        });
      }
    });
  }

  Widget showPicture(int index) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      child: Image.network(pictures[index]),
    );
  }

  Widget showText(int index) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,height: MediaQuery.of(context).size.width*0.5,
      child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[Text(names[index]), Text(details[index])],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: names.length,
        itemBuilder: (BuildContext context, int index) {
          return Row(
            children: <Widget>[
              showPicture(index),
              showText(index),
            ],
          );
        },
      ),
    );
  }
}
