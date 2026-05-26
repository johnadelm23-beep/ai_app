import 'package:ai_app/core/services/gemini_service.dart';
import 'package:ai_app/core/widgets/custom_app_button.dart';
import 'package:ai_app/core/widgets/custom_text_foem_field.dart';
import 'package:ai_app/features/chat/data/models/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<ChatSession> chats = [];
  int currentChatIndex = 0;

  bool isTyping = false;

  @override
  void initState() {
    super.initState();
    _newChat();
  }

  void _newChat() {
    setState(() {
      chats.add(
        ChatSession(
          id: DateTime.now().toString(),
          title: "Chat ${chats.length + 1}",
          messages: [],
        ),
      );
      currentChatIndex = chats.length - 1;
    });
  }

  void _deleteChat(int index) {
    setState(() {
      chats.removeAt(index);

      if (chats.isEmpty) {
        _newChat();
      }

      currentChatIndex = (currentChatIndex - 1).clamp(0, chats.length - 1);
    });
  }

  String _generateTitle(String text) {
    return text.length > 25 ? "${text.substring(0, 25)}..." : text;
  }

  Future<void> _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    final currentChat = chats[currentChatIndex];

    if (currentChat.messages.isEmpty) {
      currentChat.title = _generateTitle(text);
    }

    setState(() {
      currentChat.messages.add({"role": "user", "text": text});
      isTyping = true;
    });

    _controller.clear();
    _scrollToBottom();

    final aiText = await GeminiService.sendMessage(text);

    setState(() {
      currentChat.messages.add({"role": "ai", "text": aiText});
      isTyping = false;
    });

    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  List<Map<String, String>> get currentMessages =>
      chats[currentChatIndex].messages;

  Widget _buildMessage(Map<String, String> msg) {
    final isUser = msg["role"] == "user";

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(12),
        constraints: const BoxConstraints(maxWidth: 280),
        decoration: BoxDecoration(
          color: isUser ? Colors.black : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          msg["text"] ?? "",
          style: TextStyle(
            color: isUser ? Colors.white : Colors.black,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "Welcome to ",
                  style: TextStyle(
                    fontSize: 27,
                    color: Colors.black,
                    fontWeight: .bold,
                  ),
                ),
                TextSpan(
                  text: "Janjony🤓",
                  style: TextStyle(
                    fontSize: 27,
                    color: Colors.amber,
                    fontWeight: .bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            "Janjony AI",
            style: TextStyle(color: Colors.black),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
        ),

        drawer: Drawer(
          backgroundColor: Colors.white,
          child: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 10),

                const Text(
                  "💬 Chats",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: CustomAppButton(text: "New Chat", onPressed: _newChat),
                ),

                const SizedBox(height: 10),
                const Divider(),

                Expanded(
                  child: ListView.builder(
                    itemCount: chats.length,
                    itemBuilder: (context, index) {
                      final chat = chats[index];

                      return ListTile(
                        leading: const Icon(
                          IconlyLight.message,
                          color: Colors.black,
                        ),
                        title: Text(
                          chat.title,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        selected: index == currentChatIndex,
                        selectedTileColor: Colors.grey.shade200,
                        onTap: () {
                          setState(() {
                            currentChatIndex = index;
                          });
                          Navigator.pop(context);
                        },
                        trailing: IconButton(
                          icon: const Icon(
                            IconlyLight.delete,
                            color: Colors.black,
                          ),
                          onPressed: () => _deleteChat(index),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),

        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: currentMessages.isEmpty
                    ? _buildEmptyState()
                    : ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.all(12),
                        itemCount: currentMessages.length,
                        itemBuilder: (context, index) {
                          return _buildMessage(currentMessages[index]);
                        },
                      ),
              ),

              if (isTyping)
                const Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text("Janjony is typing..."),
                ),

              _buildInput(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black12)],
      ),
      child: Row(
        children: [
          Expanded(
            child: CustomTextFoemField(
              text: "Type a message..",
              controller: _controller,
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: _sendMessage,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
              child: const Icon(IconlyLight.send, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
