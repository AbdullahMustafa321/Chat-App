import 'package:chat_app/constant/strings.dart';

class MessageModel{
  String id;
  String message;
  MessageModel({required this.message,required this.id});
  factory MessageModel.fromJson(jsonData){

    return MessageModel(message:jsonData[kMessage],id: jsonData[kId]);
  }
}