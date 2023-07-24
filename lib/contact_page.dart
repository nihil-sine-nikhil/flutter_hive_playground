import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'models/contact.dart';
import 'new_contact_form.dart';

class ContactPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            child: Icon(
              Icons.account_circle_outlined,
              color: Theme.of(context).primaryColorDark,
            ),
            onPressed: () async {
              await showModalBottomSheet(
                  context: context,
                  builder: (ctx) {
                    return StatefulBuilder(builder: (context, setState) {
                      return Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                        child: NewContactForm(),
                      );
                    });
                  });
            }),
        appBar: AppBar(
          title: Text('Hive Tutorial'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Column(
            children: <Widget>[
              Expanded(child: _buildListView()),
            ],
          ),
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
                trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                  IconButton(
                    onPressed: () {
                      contactsBox.putAt(
                          index, Contact("name", contact.age + 1));
                    },
                    icon: Icon(
                      Icons.refresh,
                      color: Colors.green,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      contactsBox.deleteAt(index);
                    },
                    icon: Icon(
                      Icons.restore_from_trash,
                      color: Colors.red,
                    ),
                  ),
                ]),
              );
            },
            itemCount: contactsBox.length,
          );
        });
  }
}
