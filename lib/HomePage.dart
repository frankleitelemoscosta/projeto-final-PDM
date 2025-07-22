import 'package:flutter/material.dart';

class Contact {
  final String name;
  final String number;
  final Color color;

  Contact({required this.name, required this.number, required this.color});
}

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    // Lista de contatos de exemplo
    final contacts = [
      Contact(name: 'João Silva', number: '(11) 9999-8888', color: Colors.blue),
      Contact(
        name: 'Maria Souza',
        number: '(21) 8888-7777',
        color: Colors.green,
      ),
      Contact(
        name: 'Carlos Lima',
        number: '(31) 7777-6666',
        color: Colors.orange,
      ),
      Contact(
        name: 'Ana Costa',
        number: '(41) 6666-5555',
        color: Colors.purple,
      ),
      Contact(name: 'Pedro Rocha', number: '(51) 5555-4444', color: Colors.red),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Trabalho Final'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          // Área dos botões
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Abrir contatos
                  },
                  child: Text('Open your contacts'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Adicionar novo contato
                  },
                  child: Text('Add a new contact'),
                ),
              ],
            ),
          ),
          // Espaço reservado (antigo Container amarelo)
          SizedBox(
            height: 100,
            width: 300,
            child: Container(decoration: BoxDecoration(color: Colors.amber)),
          ),

          // Carrossel de contatos
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TweenAnimationBuilder(
                    duration: Duration(milliseconds: 500 + (index * 200)),
                    tween: Tween<double>(begin: 0, end: 1),
                    curve: Curves.easeOutBack,
                    builder: (context, double value, child) {
                      return Transform.scale(
                        scale: value,
                        child: Opacity(opacity: value, child: child),
                      );
                    },
                    child: ContactCard(contact: contacts[index]),
                  ),
                );
              },
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
    return Container(
      width: 150,
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      decoration: BoxDecoration(
        color: contact.color.withOpacity(0.7),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person, size: 50, color: Colors.white),
          SizedBox(height: 10),
          Text(
            contact.name,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 5),
          Text(
            contact.number,
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
