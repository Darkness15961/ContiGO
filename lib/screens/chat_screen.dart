import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/mock_repository.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import 'meeting_screen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key,
    required this.repo,
    required this.connection,
  });

  final MockRepository repo;
  final TeamConnection connection;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _input = TextEditingController();

  @override
  void dispose() {
    _input.dispose();
    super.dispose();
  }

  List<ChatMessage> get _messages =>
      widget.repo.chats[widget.connection.id] ?? [];

  void _send() {
    final text = _input.text.trim();
    if (text.isEmpty) return;
    setState(() {
      widget.repo.addMessage(widget.connection.id, text);
      _input.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final me = widget.repo.currentUser.id;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          widget.connection.project.codeName,
          style: displayStyle(size: 20),
        ),
        actions: [
          IconButton(
            tooltip: 'Proponer reunión',
            onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => MeetingScreen(
                    repo: widget.repo,
                    connection: widget.connection,
                  ),
                ),
              );
              if (mounted) setState(() {});
            },
            icon: const Icon(Icons.event_outlined, color: AppColors.violet),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              itemCount: _messages.length,
              itemBuilder: (_, i) {
                final m = _messages[i];
                final mine = m.fromId == me;
                final author = widget.connection.members.firstWhere(
                  (s) => s.id == m.fromId,
                  orElse: () => widget.repo.currentUser,
                );
                return Align(
                  alignment: mine ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.sizeOf(context).width * 0.78,
                    ),
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: mine ? AppColors.violet : AppColors.bgSoft,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (!mine)
                          Text(
                            author.name.split(' ').first,
                            style: GoogleFonts.dmSans(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: AppColors.violetDeep,
                            ),
                          ),
                        Text(
                          m.text,
                          style: GoogleFonts.dmSans(
                            fontSize: 14,
                            height: 1.4,
                            color: mine ? AppColors.white : AppColors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const Divider(height: 1),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _input,
                      decoration: const InputDecoration(
                        hintText: 'Escribe un mensaje...',
                      ),
                      onSubmitted: (_) => _send(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton.filled(
                    onPressed: _send,
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.violet,
                      foregroundColor: AppColors.white,
                    ),
                    icon: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
