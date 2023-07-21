import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

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

  ListView _buildListView() {
    var contactsBox = Hive.box('contacts');

    return ListView.builder(
      itemBuilder: (ctx, index) {
        Contact contact = contactsBox.get(
            index); // to get by key name, but since our keys are autoincremental we just pass index
        // Contact contact = contactsBox.getAt(index); to get by index number
        return ListTile(
          title: Text(contact.name),
          subtitle: Text('${contact.age}'),
        );
      },
      itemCount: contactsBox.length,
    );
  }
}
