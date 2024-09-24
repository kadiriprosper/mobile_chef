import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:recipe_on_net/model/message_model.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messages = <MessageModel>[];
  String? attachmentPath;
  bool chatEmpty = true;
  TextEditingController messageController = Get.put(
    TextEditingController(),
    tag: 'Chat Message Controller',
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 3,
        //TODO: Let there be a color animation when the ai is responding
        shadowColor: Colors.blue,
        title: Row(
          children: [
            CircleAvatar(
              // radius: 30,
              backgroundColor: Colors.transparent,
              child: Text(
                '🤖',
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
            ),
            const SizedBox(width: 2),
            Text('AI chef'),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 10),
              itemCount: messages.length,
              reverse: true,
              itemBuilder: (context, index) {
                final instantMessage = messages.reversed.toList()[index];
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: InkWell(
                    onLongPress: () {},
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.5,
                      ),
                      margin:
                          const EdgeInsets.all(10).copyWith(top: 0, bottom: 5),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: instantMessage.sender == SenderEnum.you
                            ? Colors.deepOrange.shade500
                            : Colors.purple,
                        borderRadius: BorderRadius.circular(8).copyWith(
                          bottomLeft: instantMessage.sender == SenderEnum.you
                              ? const Radius.circular(8)
                              : const Radius.circular(0),
                          bottomRight: instantMessage.sender == SenderEnum.you
                              ? const Radius.circular(0)
                              : const Radius.circular(8),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            instantMessage.message,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            instantMessage.timeSent,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    onChanged: (value) {
                      setState(() {
                        if (value.isEmpty) {
                          chatEmpty = true;
                        } else {
                          chatEmpty = false;
                        }
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Write your message',
                      suffixIcon: IconButton(
                        onPressed: () {
                          //TODO: Select photo attachment
                        },
                        icon: const Icon(Icons.attachment_outlined),
                        color: Colors.white,
                      ),
                      fillColor: Colors.black26,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.orange),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.deepOrange),
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                IconButton.filled(
                  onPressed: () {
                    if (!chatEmpty && messageController.text.isNotEmpty) {
                      MessageModel newMessage = MessageModel(
                        message: messageController.text,
                        sender: SenderEnum.you,
                        attachmentPath: attachmentPath,
                        timeSent: DateFormat(DateFormat.YEAR_MONTH_DAY).format(
                          DateTime.now(),
                        ),
                      );
                      //TODO: Send message
                      messages.add(newMessage);
                      messageController.clear();
                      chatEmpty = true;
                      setState(() {});
                    }
                  },
                  iconSize: 30,
                  padding: const EdgeInsets.all(12),
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      Colors.orange.shade800,
                    ),
                  ),
                  icon: chatEmpty
                      ? const Icon(Iconsax.microphone_2_bold)
                      : const Icon(Iconsax.send_1_bold),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
