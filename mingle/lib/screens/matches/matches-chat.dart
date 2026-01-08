import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mingle/styles/Colors.dart';
import 'package:mingle/styles/widget-styles.dart';

/// =======================
/// Message Model
/// =======================
class ChatMessageModel {
  final String id;
  final String content;
  final bool isMe;
  final MessageType type;
  final DateTime timestamp;

  ChatMessageModel({
    required this.id,
    required this.content,
    required this.isMe,
    required this.type,
    required this.timestamp,
  });
}

enum MessageType { text, system }

/// =======================
/// Matches Chat Page
/// =======================
class MatchesChat extends StatefulWidget {
  final String matchName;
  final String matchAvatar;

  const MatchesChat({
    super.key,
    required this.matchName,
    required this.matchAvatar,
  });

  @override
  State<MatchesChat> createState() => _MatchesChatState();
}

class _MatchesChatState extends State<MatchesChat> {
  final TextEditingController _msgCtrl = TextEditingController();
  final List<ChatMessageModel> messages = [];

  @override
  void initState() {
    super.initState();

    /// Dating-app system intro
    messages.add(
      ChatMessageModel(
        id: _genId(),
        content: "✨ You matched with ${widget.matchName}!",
        isMe: false,
        type: MessageType.system,
        timestamp: DateTime.now(),
      ),
    );
  }

  void _sendMessage() {
    final text = _msgCtrl.text.trim();
    if (text.isEmpty) return;

    setState(() {
      messages.add(
        ChatMessageModel(
          id: _genId(),
          content: text,
          isMe: true,
          type: MessageType.text,
          timestamp: DateTime.now(),
        ),
      );
    });

    _msgCtrl.clear();

    /// Fake reply for demo realism
    Future.delayed(const Duration(milliseconds: 900), () {
      if (!mounted) return;
      setState(() {
        messages.add(
          ChatMessageModel(
            id: _genId(),
            content: _autoReply(),
            isMe: false,
            type: MessageType.text,
            timestamp: DateTime.now(),
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        titleSpacing: 0,
        title: Row(
          children: [
            const SizedBox(width: 8),
            CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage(widget.matchAvatar),
            ),
            const SizedBox(width: 10),
            Text(
              widget.matchName,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 12),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ChatBubble(msg: messages[index]);
              },
            ),
          ),
          _inputBar(),
        ],
      ),
    );
  }

  Widget _inputBar() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _msgCtrl,
                decoration: textFieldDeco.copyWith(
                  hintText: "Send a message…",
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send, color: secondary),
              onPressed: _sendMessage,
            ),
          ],
        ),
      ),
    );
  }

  String _genId() => Random().nextInt(9999999).toString();

  String _autoReply() {
    const replies = [
      "Haha that's cute 😂",
      "Tell me more 👀",
      "Omg same",
      "That sounds fun!",
      "I was thinking the same",
      "You’re funny ngl",
    ];
    return replies[Random().nextInt(replies.length)];
  }
}

/// =======================
/// Chat Bubble Widget
/// =======================
class ChatBubble extends StatelessWidget {
  final ChatMessageModel msg;

  const ChatBubble({super.key, required this.msg});

  @override
  Widget build(BuildContext context) {
    if (msg.type == MessageType.system) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Center(
          child: Text(
            msg.content,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black45,
            ),
          ),
        ),
      );
    }

    return Align(
      alignment: msg.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: msg.isMe ? secondary : Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: msg.isMe ? secondary : const Color(0xFFD4C6FD),
          ),
        ),
        child: Text(
          msg.content,
          style: TextStyle(
            color: msg.isMe ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
