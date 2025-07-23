import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:projeto_final/ContactsProvider.dart';
import 'package:provider/provider.dart';

class ContactAvatar extends StatefulWidget {
  final Contact contact;

  const ContactAvatar({super.key, required this.contact});

  @override
  State<ContactAvatar> createState() => _ContactAvatarState();
}

class _ContactAvatarState extends State<ContactAvatar> {
  @override
  Widget build(BuildContext context) {
    final contactsProvider = Provider.of<ContactsProvider>(context);

    final backgroundImage = contactsProvider.getImageForContact(
      widget.contact.id,
    );

    final initial =
        widget.contact.displayName.isNotEmpty
            ? widget.contact.displayName[0].toUpperCase()
            : '?';

    return CircleAvatar(
      radius: 20,
      backgroundColor: Colors.white,
      backgroundImage:
          backgroundImage != null ? FileImage(backgroundImage) : null,
      child:
          backgroundImage == null
              ? Center(
                child: Text(
                  initial,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
              : null,
    );
  }
}
