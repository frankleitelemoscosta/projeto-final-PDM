import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class ContactsProvider extends ChangeNotifier {
  List<Contact> _contacts = [];
  List<Contact> get contacts => _contacts;

  final Map<String, File> _contactImages = {};

  List<Contact> _favorites = [];
  List<Contact> get favorites => _favorites;

  Future<void> requestPermissionAndFetchContacts() async {
    _contacts = await FlutterContacts.getContacts();

    notifyListeners();
  }

  File? getImageForContact(String contactId) {
    return _contactImages[contactId];
  }

  void setImageForContact(String contactId, File image) {
    _contactImages[contactId] = image;
    notifyListeners();
  }

  void addToFavorites(Contact contact) {
    if (!_favorites.contains(contact)) {
      _favorites.add(contact);
      notifyListeners();
    } else {
      _favorites.remove(contact);
      notifyListeners();
    }
  }
}
