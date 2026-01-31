import 'package:flutter/material.dart';
import 'blocos_flutter.dart';

class DragDropEngine extends ChangeNotifier {
  final List<AppBlock> _blocks = [];

  List<AppBlock> get blocks => List.unmodifiable(_blocks);

  void addBlock(BlockType type) {
    _blocks.add(AppBlock.create(type));
    notifyListeners();
  }

  void removeBlock(String id) {
    _blocks.removeWhere((b) => b.id == id);
    notifyListeners();
  }

  void reorderBlocks(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final AppBlock item = _blocks.removeAt(oldIndex);
    _blocks.insert(newIndex, item);
    notifyListeners();
  }

  // Simulation of "AI Generation"
  Future<void> generateAppFromPrompt(String prompt) async {
    // Mock latency to simulate AI thinking
    await Future.delayed(const Duration(seconds: 2));

    _blocks.clear();

    if (prompt.toLowerCase().contains('delivery') ||
        prompt.toLowerCase().contains('ifood')) {
      _blocks.add(
        AppBlock.create(BlockType.header)..data['title'] = 'Fast Delivery',
      );
      _blocks.add(AppBlock.create(BlockType.login));
      _blocks.add(
        AppBlock.create(BlockType.feed)..data['source'] = 'Restaurantes',
      );
      _blocks.add(
        AppBlock.create(BlockType.button)..data['label'] = 'Pedir Agora',
      );
    } else if (prompt.toLowerCase().contains('insta') ||
        prompt.toLowerCase().contains('social')) {
      _blocks.add(
        AppBlock.create(BlockType.header)..data['title'] = 'Social Connect',
      );
      _blocks.add(AppBlock.create(BlockType.feed));
      _blocks.add(AppBlock.create(BlockType.feed));
      _blocks.add(AppBlock.create(BlockType.chat));
    } else {
      // Default Generic
      _blocks.add(
        AppBlock.create(BlockType.header)..data['title'] = 'Meu Novo App',
      );
      _blocks.add(AppBlock.create(BlockType.feed));
    }
    notifyListeners();
  }
}
