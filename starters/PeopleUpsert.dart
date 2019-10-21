import 'package:flutter/material.dart';

class PeopleUpsert extends StatefulWidget {
  @override
  _PeopleUpsertState createState() => _PeopleUpsertState();
}

class _PeopleUpsertState extends State<PeopleUpsert> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  //DocumentSnapshot _person;
  dynamic _person;
  dynamic _localPerson;

  @override
  void didChangeDependencies() {
    _person = ModalRoute.of(context).settings.arguments;
    if (_localPerson == null) {
      if (_person == null)
        _localPerson = {'name': {}, "email": '', 'cell': ''};
      else
        _localPerson = _person.data;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Maintain a person"),
      ),
      body: body,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: () {
          savePerson(_localPerson);
          Navigator.pop(context);
        },
      ),
    );
  }

  Widget get body {
    return Form(
        key: _key,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'First name'),
              initialValue: _localPerson['name']['first'],
              onChanged: (val) => _localPerson['name']['first'] = val,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Last name'),
              initialValue: _localPerson['name']['last'],
              onChanged: (val) => _localPerson['name']['last'] = val,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'cell'),
              initialValue: _localPerson['cell'],
              onChanged: (val) => _localPerson['cell'] = val,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'email'),
              initialValue: _localPerson['email'],
              onChanged: (val) => _localPerson['email'] = val,
            ),
          ],
        ));
  }

  savePerson(personMap) {
    // If you provide a null documentID, Firestore will create
    // a new record. But if you provide an existing documentID,
    // Firestore will update it.
  }
}