import 'package:flutter/material.dart';

class GameHistory {
  final List<String> board;
  final String winner;
  final DateTime date;

  GameHistory({required this.board, required this.winner, required this.date});
}

class GameProvider with ChangeNotifier {
  List<String> _board = List.filled(9, '');
  String _currentPlayer = 'X';
  String _winner = '';
  final List<GameHistory> _history = [];

  List<String> get board => _board;
  String get currentPlayer => _currentPlayer;
  String get winner => _winner;
  List<GameHistory> get history => _history;

  void playMove(int index) {
    if (_board[index] == '' && _winner == '') {
      _board[index] = _currentPlayer;

      if (_checkWinner(_currentPlayer)) {
        _winner = _currentPlayer;
        _saveHistory();
      } else if (!_board.contains('')) {
        _winner = 'Draw';
        _saveHistory();
      } else {
        _currentPlayer = _currentPlayer == 'X' ? 'O' : 'X';
      }
      notifyListeners();
    }
  }

  void resetGame() {
    _board = List.filled(9, '');
    _currentPlayer = 'X';
    _winner = '';
    notifyListeners();
  }

  bool _checkWinner(String player) {
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
      if (_board[pattern[0]] == player &&
          _board[pattern[1]] == player &&
          _board[pattern[2]] == player) {
        return true;
      }
    }
    return false;
  }

  void _saveHistory() {
    _history.add(
      GameHistory(board: List.from(_board), winner: _winner, date: DateTime.now()),
    );
  }
}
