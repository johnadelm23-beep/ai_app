class ChatSession {
  final String id;
  String title;
  final List<Map<String, String>> messages;

  ChatSession({required this.id, required this.title, required this.messages});
}
