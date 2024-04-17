import 'package:chat_app/constant/strings.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/view/widgets/chat_text_field_widget.dart';
import 'package:chat_app/view/widgets/reciver_chat_bubble_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat_app/view/widgets/logo_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/sender_chat_bubble_widget.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  static String id = 'ChatScreen';
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollection);
  TextEditingController controller = TextEditingController();
  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return PopScope(
        canPop: false,
        child: StreamBuilder<QuerySnapshot>(
          stream: messages.orderBy(kCreatedAt,descending: true).snapshots( ),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<MessageModel> messageList=[];
              for (int i=0; i<snapshot.data!.docs.length; i++) {
                messageList.add(MessageModel.fromJson(snapshot.data!.docs[i]));
              }
              return Scaffold(
                appBar: AppBar(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        kLogo,
                        height: 50.h,
                        width: 50.w,
                      ),
                      const LogoTextWidget(),
                    ],
                  ),
                  automaticallyImplyLeading: false,
                ),
                body: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        reverse: true,
                        controller: _controller,
                        itemCount: messageList.length,
                        itemBuilder: (context, index) {
                          return messageList[index].id == email? SenderChatBubbleWidget(
                            message: messageList[index],
                          ):ReciverChatBubbleWidget(message: messageList[index]);
                        },
                      ),
                    ),
                    ChatTextFieldWidget(
                      controller: controller,
                      onSubmitted: (data) {
                        messages.add({
                          kMessage: data,
                          kCreatedAt:DateTime.now(),
                          kId:email,
                        });
                        controller.clear();
                        _controller.animateTo(
                          0,
                            duration: const Duration(seconds: 1),
                            curve: Curves.fastOutSlowIn);
                      },
                    ),
                  ],
                ),
              );
            } else {
              return const Scaffold(
                body: Center(child: Text('Loading.....')),
              );
            }
          },
        ));
  }
}
