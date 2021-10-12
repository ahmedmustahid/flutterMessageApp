import 'dart:html';

enum ChatMessageType { text, audio, image, video }
enum MessageStatus { not_sent, not_view, viewed }

class ChatMessage {
  final String text;
  final bool isSender;
  final createdAt;

  ChatMessage(
      {this.text = '', required this.isSender, required this.createdAt});
}
