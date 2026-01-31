import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

enum BlockType { header, login, feed, chat, payment, map, button }

class AppBlock {
  final String id;
  final BlockType type;
  Map<String, dynamic> data;

  AppBlock({String? id, required this.type, this.data = const {}})
    : id = id ?? const Uuid().v4();

  // Factory to create mock blocks
  static AppBlock create(BlockType type) {
    switch (type) {
      case BlockType.header:
        return AppBlock(type: type, data: {'title': 'Meu App Incrível'});
      case BlockType.login:
        return AppBlock(type: type, data: {'provider': 'Google + Email'});
      case BlockType.feed:
        return AppBlock(type: type, data: {'source': 'Public Posts'});
      case BlockType.chat:
        return AppBlock(type: type, data: {'room': 'Geral'});
      case BlockType.payment:
        return AppBlock(
          type: type,
          data: {'price': 99.90, 'item': 'Curso Pro'},
        );
      case BlockType.map:
        return AppBlock(type: type, data: {'lat': -23.55, 'lng': -46.63});
      case BlockType.button:
        return AppBlock(
          type: type,
          data: {'label': 'Clique Aqui', 'action': 'navigate'},
        );
    }
  }

  // Helper to get Icon for the palette
  static IconData getIcon(BlockType type) {
    switch (type) {
      case BlockType.header:
        return Icons.title;
      case BlockType.login:
        return Icons.login;
      case BlockType.feed:
        return Icons.dynamic_feed;
      case BlockType.chat:
        return Icons.chat_bubble;
      case BlockType.payment:
        return Icons.attach_money;
      case BlockType.map:
        return Icons.map;
      case BlockType.button:
        return Icons.smart_button;
    }
  }

  static String getLabel(BlockType type) {
    switch (type) {
      case BlockType.header:
        return 'Cabeçalho';
      case BlockType.login:
        return 'Tela Login';
      case BlockType.feed:
        return 'Feed Social';
      case BlockType.chat:
        return 'Chat Real-Time';
      case BlockType.payment:
        return 'Botão Pagamento';
      case BlockType.map:
        return 'Mapa GPS';
      case BlockType.button:
        return 'Botão Ação';
    }
  }
}

// Widget renderer based on block type (Mock preview)
class BlockRenderer extends StatelessWidget {
  final AppBlock block;

  const BlockRenderer({super.key, required this.block});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 4,
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    switch (block.type) {
      case BlockType.header:
        return Text(
          block.data['title'],
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        );
      case BlockType.login:
        return Column(
          children: [
            const Icon(Icons.lock_outline, size: 40, color: Colors.blue),
            const SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[800],
                hintText: 'Email',
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Entrar com Google"),
            ),
          ],
        );
      case BlockType.feed:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(backgroundColor: Colors.grey),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Usuário Exemplo",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "2 min atrás",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              height: 100,
              color: Colors.grey[800],
              child: const Center(child: Icon(Icons.image, size: 50)),
            ),
            const SizedBox(height: 10),
            const Text("Postagem de exemplo no feed do app."),
          ],
        );
      case BlockType.payment:
        return ListTile(
          leading: const Icon(Icons.payment, color: Colors.green),
          title: Text("Compra: ${block.data['item']}"),
          trailing: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            onPressed: () {},
            child: Text("R\$ ${block.data['price']}"),
          ),
        );
      default:
        return ListTile(
          leading: Icon(AppBlock.getIcon(block.type), color: Colors.white),
          title: Text(AppBlock.getLabel(block.type)),
          subtitle: Text("Config: ${block.data.toString()}"),
        );
    }
  }
}
