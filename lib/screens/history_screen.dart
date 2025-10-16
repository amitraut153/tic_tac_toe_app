import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/game_provider.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final history =
        Provider.of<GameProvider>(context).history.reversed.toList();

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          "Game History",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: history.isEmpty
          ? const Center(
              child: Text("No previous games yet!",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: history.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final gameItem = history[index];
                final winnerLabel = gameItem.winner == 'Draw'
                    ? 'Draw'
                    : 'Winner: ${gameItem.winner}';
                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    leading: const Icon(Icons.history, color: Colors.blue),
                    title: Text(
                      winnerLabel,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      gameItem.date.toLocal().toString().split('.')[0],
                      style: const TextStyle(fontSize: 13),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.visibility, color: Colors.blue),
                      onPressed: () {
                        _showBoardDialog(context, gameItem);
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }

  void _showBoardDialog(BuildContext context, GameHistory game) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
            game.winner == 'Draw' ? "Draw Game" : "Winner: ${game.winner}"),
        content: SizedBox(
          width: 260,
          height: 260,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            itemCount: 9,
            itemBuilder: (_, i) => Container(
              margin: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: Colors.grey.shade300,
                ),
              ),
              child: Center(
                child: Text(
                  game.board[i],
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          )
        ],
      ),
    );
  }
}
