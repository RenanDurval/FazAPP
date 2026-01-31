import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:idea_forge/builder/drag_drop_engine.dart';
import 'package:idea_forge/builder/blocos_flutter.dart';
import 'package:animate_do/animate_do.dart';

class AppBuilderVisual extends StatelessWidget {
  const AppBuilderVisual({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("App Builder Pro"),
        actions: [
          IconButton(
            icon: const Icon(Icons.smart_toy, color: Colors.purpleAccent),
            onPressed: () => _showAIPrompt(context),
            tooltip: "Gerar com IA",
          ),
          IconButton(
            icon: const Icon(Icons.play_arrow, color: Colors.green),
            onPressed: () {
              // TODO: Navigate to Live Preview
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Preview em breve!")),
              );
            },
          ),
        ],
      ),
      body: Row(
        children: [
          // Palette
          Container(
            width: 80,
            color: Colors.black26,
            child: ListView(
              children: BlockType.values
                  .map((type) => _buildPaletteItem(context, type))
                  .toList(),
            ),
          ),
          // Canvas
          Expanded(
            child: Consumer<DragDropEngine>(
              builder: (context, engine, child) {
                if (engine.blocks.isEmpty) {
                  return Center(
                    child: FadeInUp(
                      child: const Text(
                        "Arraste blocos ou peça para a IA!",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  );
                }
                return ReorderableListView.builder(
                  itemCount: engine.blocks.length,
                  onReorder: engine.reorderBlocks,
                  itemBuilder: (context, index) {
                    final block = engine.blocks[index];
                    return Dismissible(
                      key: ValueKey(block.id),
                      onDismissed: (_) => engine.removeBlock(block.id),
                      child: BlockRenderer(block: block),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaletteItem(BuildContext context, BlockType type) {
    return InkWell(
      onTap: () {
        Provider.of<DragDropEngine>(context, listen: false).addBlock(type);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          children: [
            Icon(AppBlock.getIcon(type), color: Colors.white70),
            const SizedBox(height: 4),
            Text(
              AppBlock.getLabel(type).split(' ').first,
              style: const TextStyle(fontSize: 10, color: Colors.white54),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _showAIPrompt(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("IdeaForge IA"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: "Ex: App de delivery..."),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              Provider.of<DragDropEngine>(
                context,
                listen: false,
              ).generateAppFromPrompt(controller.text);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("IA trabalhando...")),
              );
            },
            child: const Text("Gerar"),
          ),
        ],
      ),
    );
  }
}
