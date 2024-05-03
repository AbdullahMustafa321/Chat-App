import 'package:chat_app/constant/strings.dart';

class MessageModal{
  String id;
  String message;
  MessageModal({required this.message,required this.id});
  factory MessageModal.fromJson(jsonData){

    return MessageModal(message:jsonData[kMessage],id: jsonData[kId]);
  }
}