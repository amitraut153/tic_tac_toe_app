import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/game_provider.dart';

class TicTacToeBoard extends StatelessWidget {
  const TicTacToeBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final game = Provider.of<GameProvider>(context);

    return LayoutBuilder(builder: (context, constraints) {
      final double maxSide = min(constraints.maxWidth, 420);
      final double boardSize = maxSide * 0.95;

      return Center(
        child: SizedBox(
          width: boardSize,
          height: boardSize,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            itemCount: 9,
            itemBuilder: (context, index) {
              final value = game.board[index];
              final isWinning = _isWinningIndex(game, index);

              return GestureDetector(
                onTap: () => game.playMove(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  margin: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: value == ''
                        ? Colors.yellow.shade300
                        : value == 'X'
                            ? Colors.lightBlue.shade100
                            : Colors.pink.shade100,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: isWinning
                        ? [
                            BoxShadow(
                              color: Colors.yellow,
                              blurRadius: 10,
                              spreadRadius: 3,
                            ),
                          ]
                        : [],
                  ),
                  child: Center(
                    child: AnimatedScale(
                      scale: value == '' ? 0 : 1,
                      duration: const Duration(milliseconds: 180),
                      child: Text(
                        value,
                        style: TextStyle(
                          fontSize: boardSize / 6.5,
                          fontWeight: FontWeight.bold,
                          color:
                              value == 'X' ? Colors.blue.shade700 : Colors.pink,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );
    });
  }

  bool _isWinningIndex(GameProvider game, int index) {
    if (game.winner == '' || game.winner == 'Draw') return false;
    const winPatterns = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];
    for (var pattern in winPatterns) {
      if (game.board[pattern[0]] == game.winner &&
          game.board[pattern[1]] == game.winner &&
          game.board[pattern[2]] == game.winner &&
          pattern.contains(index)) {
        return true;
      }
    }
    return false;
  }
}
