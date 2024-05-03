
import 'package:chat_app/models/message_model.dart';

abstract class ChatState {}

final class ChatInitial extends ChatState {}
final class ChatSuccess extends ChatState {
  List<MessageModal> messages = [];

  ChatSuccess({required this.messages});
}
