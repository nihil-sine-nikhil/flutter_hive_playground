import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/contact.dart';

class NewContactForm extends StatefulWidget {
  @override
  _NewContactFormState createState() => _NewContactFormState();
}

class _NewContactFormState extends State<NewContactForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _name = TextEditingController();
  TextEditingController _age = TextEditingController();

  var box = Hive.box('contacts');
  void addContact(Contact contact) {
    box.add(contact); // add give autoincremental keys
    // box.put(key, value) ------ put needs both key and  value
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  controller: _name,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  controller: _age,
                  decoration: InputDecoration(labelText: 'Age'),
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          ElevatedButton(
            child: Text('Add New Contact'),
            onPressed: () {
              _formKey.currentState?.save();
              final newContact = Contact(_name.text, int.parse(_age.text));
              addContact(newContact);
              _name.clear();
              _age.clear();
            },
          ),
        ],
      ),
    );
  }
}
