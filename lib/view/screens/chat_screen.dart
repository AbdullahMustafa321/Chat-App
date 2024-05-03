import 'package:chat_app/constant/strings.dart';
import 'package:chat_app/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app/cubits/chat_cubit/chat_state.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/view/widgets/chat_text_field_widget.dart';
import 'package:chat_app/view/widgets/reciver_chat_bubble_widget.dart';
import 'package:chat_app/view/widgets/logo_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/sender_chat_bubble_widget.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({super.key});

  static String id = 'ChatScreen';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController controller = TextEditingController();

  final _controller = ScrollController();


  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return PopScope(
        canPop: false,
        child: Scaffold(
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
                child: BlocBuilder<ChatCubit, ChatState>(
                  builder: (context, state) {
                    var messageList = BlocProvider.of<ChatCubit>(context).messagesList;
                    return ListView.builder(
                      reverse: true,
                      controller: _controller,
                      itemCount: messageList.length,
                      itemBuilder: (context, index) {
                        return messageList[index].id == email
                            ? SenderChatBubbleWidget(
                                message: messageList[index],
                              )
                            : ReciverChatBubbleWidget(
                                message: messageList[index]);
                      },
                    );
                  },
                ),
              ),
              ChatTextFieldWidget(
                controller: controller,
                onSubmitted: (data) {
                  BlocProvider.of<ChatCubit>(context).sendMessage(
                      data: data, email: email.toString().trim());
                  controller.clear();
                  _controller.animateTo(0,
                      duration: const Duration(seconds: 1),
                      curve: Curves.fastOutSlowIn);
                },
              ),
            ],
          ),
        ));
  }
}
