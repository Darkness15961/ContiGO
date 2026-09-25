import 'package:flutter/material.dart';

import '../data/mock_repository.dart';
import 'ideas_feed_screen.dart';
import 'matches_screen.dart';
import 'profile_screen.dart';
import '../theme/app_theme.dart';

class ShellScreen extends StatefulWidget {
  const ShellScreen({super.key, required this.repo});

  final MockRepository repo;

  @override
  State<ShellScreen> createState() => _ShellScreenState();
}

class _ShellScreenState extends State<ShellScreen> {
  int _index = 0;

  void _refresh() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final pages = [
      IdeasFeedScreen(repo: widget.repo, onChanged: _refresh),
      MatchesScreen(repo: widget.repo),
      ProfileScreen(repo: widget.repo),
    ];

    return Scaffold(
      body: IndexedStack(index: _index, children: pages),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: AppColors.paper,
          border: Border(top: BorderSide(color: AppColors.line)),
        ),
        child: SafeArea(
          child: BottomNavigationBar(
            currentIndex: _index,
            onTap: (i) => setState(() => _index = i),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.lightbulb_outline),
                activeIcon: Icon(Icons.lightbulb),
                label: 'Ideas',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border),
                activeIcon: Icon(Icons.favorite),
                label: 'Matches',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                activeIcon: Icon(Icons.person),
                label: 'Perfil',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
