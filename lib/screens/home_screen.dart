import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/game_provider.dart';
import '../widgets/tic_tac_toe_board.dart';
import 'history_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final game = Provider.of<GameProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          "Tic Tac Toe",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: [
            // Top player box
            _playerBox("Player 1 (X)", game.currentPlayer == 'X'),
    
            const SizedBox(height: 12),
    
            // Middle area (board, status, buttons) - make this expand and scroll if needed
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (game.winner == '')
                      Text(
                        "Current Turn: ${game.currentPlayer}",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    else if (game.winner == 'Draw')
                      const Text(
                        "It's a Draw!",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      )
                    else
                      Column(
                        children: [
                          const Icon(Icons.emoji_events,
                              color: Colors.amber, size: 80),
                          const SizedBox(height: 8),
                          Text(
                            game.winner == 'X'
                                ? "Player 1 Wins!"
                                : "Player 2 Wins!",
                            style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                        ],
                      ),
                    const SizedBox(height: 18),
                    // Board
                    const TicTacToeBoard(),
                    const SizedBox(height: 18),
    
                    // Restart / Play again and History buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: game.resetGame,
                          icon:
                              const Icon(Icons.refresh, color: Colors.white),
                          label: const Text(
                            "Restart",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        if (game.winner != '')
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const HistoryScreen(),
                                ),
                              );
                            },
                            icon: const Icon(Icons.history,
                                color: Colors.white),
                            label: const Text(
                              "See History",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 12,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 18),
                  ],
                ),
              ),
            ),
    
            // Bottom player box
            _playerBox("Player 2 (O)", game.currentPlayer == 'O'),
            SizedBox(height: MediaQuery.of(context).padding.bottom + 8)
          ],
        ),
      ),
    );
  }

  Widget _playerBox(String name, bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: isActive ? Colors.blue.shade50 : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isActive ? Colors.blue : Colors.grey.shade400,
          width: 1.8,
        ),
      ),
      child: Center(
        child: Text(
          name,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isActive ? Colors.blue.shade700 : Colors.black87,
          ),
        ),
      ),
    );
  }
}
