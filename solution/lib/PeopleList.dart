import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PeopleList extends StatefulWidget {
  @override
  _PeopleListState createState() => _PeopleListState();
}

class _PeopleListState extends State<PeopleList> {
  final String _placeholderImage = 'http://sunfieldfarm.org/wp-content/uploads/2014/02/profile-placeholder.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('People List'),
      ),
      body: body,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, "/upsert");
        },
      ),
    );
  }

  Widget get body {
    return StreamBuilder<QuerySnapshot>(
        stream: getPeople(),
        builder: (ctx, snapshot) {
          if (snapshot.hasError) return Text("Oh noes!");
          if (!snapshot.hasData) return Text("No data ... not yet.");
          TextStyle style =
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold);
          List<Widget> tiles = snapshot.data.documents
              .map((person) => GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/upsert', arguments:person),
                    child: Stack(children: [
                      Image.network(
                        (person['picture']==null) ? _placeholderImage : person['picture']['large'],
                        width: 300,
                        fit: BoxFit.cover,
                      ),
                      Text(
                        '${person['name']['first']} ${person['name']['last']}',
                        style: style.copyWith(fontSize: 20),
                      ),
                      Positioned(
                          bottom: 20,
                          child: Text(person['email'], style: style)),
                      Positioned(
                          bottom: 0, child: Text(person['cell'], style: style)),
                      Positioned(
                        right: 0,
                        child: GestureDetector(
                          onTap: () => deletePerson(person.documentID),
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ]),
                  ))
              .toList();
          return GridView.extent(
            maxCrossAxisExtent: 300,
            children: tiles,
          );
        });
  }

  Stream getPeople() {
    return Firestore.instance.collection('people').limit(100).snapshots();
  }

  void deletePerson(String documentID) {
    Firestore.instance.collection('people').document(documentID).delete();
  }
}
