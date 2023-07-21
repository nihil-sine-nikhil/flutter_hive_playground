import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'models/contact.dart';
import 'new_contact_form.dart';

class ContactPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Hive Tutorial'),
        ),
        body: Column(
          children: <Widget>[
            Expanded(child: _buildListView()),
            NewContactForm(),
          ],
        ));
  }

  Widget _buildListView() {
    // contactsBox.watch().listen((event) {});
    // can us watch("keyName") to listen t oa specific key
    return WatchBoxBuilder(
        box: Hive.box('contacts'),
        builder: (ctx, contactsBox) {
          return ListView.builder(
            itemBuilder: (ctx, index) {
              // to get by key name, but since our keys are autoincremental we just pass index
              Contact contact = contactsBox.get(index);
              // Contact contact = contactsBox.getAt(index); to get by index number
              return ListTile(
                title: Text(contact.name),
                subtitle: Text('${contact.age}'),
              );
            },
            itemCount: contactsBox.length,
          );
        });
  }
}
