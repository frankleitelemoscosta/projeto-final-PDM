import 'package:flutter/material.dart';
import 'package:projeto_final/Avatar.dart';
import 'package:projeto_final/ContactsProvider.dart';
import 'package:projeto_final/Details.dart';
import 'package:provider/provider.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'dart:async';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late StreamController<double> _progressController;

  bool _permissionDenied = false;
  bool get permissionDenied => _permissionDenied;

  final CarouselController controller = CarouselController(initialItem: 1);

  @override
  void initState() {
    super.initState();
    _progressController = StreamController<double>();
    _progressController.add(0.0);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final contactsProvider = Provider.of<ContactsProvider>(context);

    Future<void> requestPermissionAndFetchContacts() async {
      _progressController.add(1.0);

      await Future.delayed(const Duration(seconds: 3));

      await contactsProvider.requestPermissionAndFetchContacts();

      _progressController.add(0.0);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lista de Contatos',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: requestPermissionAndFetchContacts,
        child: const Icon(Icons.refresh),
      ),
      body: Column(
        children: [
          if (permissionDenied)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Permissão negada. Ative as permissões de contatos nas configurações.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
            )
          else
            Expanded(
              child: Center(
                child: StreamBuilder<double>(
                  stream: _progressController.stream,
                  initialData: 0.0,
                  builder: (context, snapshot) {
                    double progress = snapshot.data ?? 0.0;

                    if (contactsProvider.contacts.isEmpty && progress == 0.0) {
                      return Center(
                        child: Text(
                          'Nenhum contato encontrado. Tente novamente.',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      );
                    }

                    if (progress == 0.0) {
                      return Column(
                        children: [
                          ConstrainedBox(
                            constraints: BoxConstraints(maxHeight: 100),
                            child: CarouselView.weighted(
                              controller: controller,
                              // itemSnapping: true,
                              // consumeMaxWeight: false,
                              flexWeights: const <int>[1, 4, 1],
                              itemSnapping: true,
                              shrinkExtent: 1000,
                              children:
                                  contactsProvider.favorites.map((
                                    Contact contact,
                                  ) {
                                    return ContactCard(contact: contact);
                                  }).toList(),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                              ),
                              itemCount: contactsProvider.contacts.length,
                              itemBuilder: (context, index) {
                                return TweenAnimationBuilder<double>(
                                  tween: Tween(begin: 0, end: 1),
                                  duration: const Duration(milliseconds: 2000),
                                  curve: Curves.easeOut,
                                  builder: (context, value, child) {
                                    return Opacity(
                                      opacity: value,
                                      child: Transform.translate(
                                        offset: Offset(0, 20 * (1 - value)),
                                        child: child,
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 12.0,
                                    ),
                                    child: ContactCard(
                                      contact: contactsProvider.contacts[index],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    }

                    return LinearProgressIndicator(
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class ContactCard extends StatelessWidget {
  final Contact contact;

  const ContactCard({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    final contactsProvider = Provider.of<ContactsProvider>(context);

    bool isFavorite = contactsProvider.favorites.contains(contact);

    return GestureDetector(
      onTap:
          () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ContactDetailsPage(contact: contact),
            ),
          ),
      child: Card(
        color: Colors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Calculate available width for content
              double availableWidth = constraints.maxWidth;
              double avatarWidth = 40; // Approximate avatar width
              double iconButtonWidth = 48; // IconButton default width
              double spacingWidth = 16; // Total spacing (8 + 4 + 4)
              double contentWidth =
                  availableWidth - avatarWidth - iconButtonWidth - spacingWidth;

              bool showAvatar =
                  availableWidth > 80; // Minimum width needed for avatar

              // Determine what to show based on available space
              bool showPhoneNumber =
                  contentWidth >
                  120; // Minimum width needed for both name and phone
              bool showIconButton =
                  availableWidth >
                  120; // Minimum width needed to show the button

              return ClipRect(
                child: Row(
                  children: [
                    if (showAvatar) ContactAvatar(contact: contact),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            contact.displayName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          if (showPhoneNumber && contact.phones.isNotEmpty) ...[
                            const SizedBox(height: 2),
                            Text(
                              contact.phones.first.number,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ],
                        ],
                      ),
                    ),
                    if (showIconButton) ...[
                      const SizedBox(width: 4),
                      SizedBox(
                        width: 40,
                        height: 40,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            contactsProvider.addToFavorites(contact);
                          },
                          icon: Icon(
                            Icons.favorite,
                            color: isFavorite ? Colors.red : Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
