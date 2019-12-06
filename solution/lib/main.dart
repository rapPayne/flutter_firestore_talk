import 'package:flutter/material.dart';
import 'PeopleList.dart';
import 'PeopleUpsert.dart';

void main() => runApp(PeopleMaintenance());

class PeopleMaintenance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "People Maintenance",
      routes: {
        "/": (_) => PeopleList(),
        "/upsert": (_) => PeopleUpsert(),
      }
    );
  }
}