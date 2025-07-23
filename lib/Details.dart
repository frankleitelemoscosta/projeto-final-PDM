import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:projeto_final/Avatar.dart';
import 'package:projeto_final/ContactsProvider.dart';
import 'package:provider/provider.dart';

class ContactDetailsPage extends StatefulWidget {
  final Contact contact;

  const ContactDetailsPage({super.key, required this.contact});

  @override
  State<ContactDetailsPage> createState() => _ContactDetailsPageState();
}

class _ContactDetailsPageState extends State<ContactDetailsPage> {
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final contactsProvider = Provider.of<ContactsProvider>(context);

    Future<void> takePhoto() async {
      final XFile? photo = await _picker.pickImage(source: ImageSource.camera);

      if (photo != null) {
        contactsProvider.setImageForContact(
          widget.contact.id,
          File(photo.path),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.contact.displayName,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        iconTheme: IconThemeData(
          color: Colors.white, // This changes the back icon color
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: takePhoto,
        child: const Icon(Icons.camera_alt),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: ContactAvatar(contact: widget.contact, radius: 60)),
            const SizedBox(height: 24),
            Text(
              'Name',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              widget.contact.displayName,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              'Phone Numbers',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            ...widget.contact.phones.map(
              (phone) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(phone.number, style: const TextStyle(fontSize: 16)),
              ),
            ),
            const SizedBox(height: 16),
            if (widget.contact.emails.isNotEmpty) ...[
              Text(
                'Emails',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              ...widget.contact.emails.map(
                (email) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    email.address,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
