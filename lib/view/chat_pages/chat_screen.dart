import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:recipe_on_net/controller/controllers.dart' as controller;

import 'package:recipe_on_net/model/message_model.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, this.chatIndex});

  final int? chatIndex;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<MessageModel> messages = <MessageModel>[];
  ChatModel? chatModel;
  String? attachmentPath;
  File? selectedImage;
  bool chatEmpty = true;
  Widget? chatTitle;

  String title = 'AI chat';

  TextEditingController messageController = Get.put(
    TextEditingController(),
    tag: 'Chat Message Controller',
  );

  @override
  void initState() {
    String date = DateTime.now().toString();
    if (widget.chatIndex != null) {
      messages = controller
          .userController.userModel.value.savedChats![widget.chatIndex!].chats!;
      title = controller
          .userController.userModel.value.savedChats![widget.chatIndex!].title;
      chatTitle = Text(title);
      date = controller
          .userController.userModel.value.savedChats![widget.chatIndex!].date;
    }
    chatModel = ChatModel(date: date, title: title);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 3,
        //TODO: Let there be a color animation when the ai is responding
        titleSpacing: 0,
        shadowColor: Colors.blue,
        title: Row(
          children: [
            Image.asset(
              'assets/illustrations/chef.png',
              width: 30,
            ),
            const SizedBox(width: 2),
            Expanded(child: chatTitle ?? const Text('AI chef')),
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
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  instantMessage.message,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              instantMessage.attachmentPath != null
                                  ? InkWell(
                                      onTap: () {
                                        Get.dialog(
                                          ImageDialogOverlay(
                                            imagePath:
                                                instantMessage.attachmentPath!,
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width: 46,
                                        height: 46,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.black,
                                              blurRadius: 1,
                                            ),
                                            BoxShadow(
                                              color: Colors.grey,
                                              blurRadius: 1,
                                            ),
                                          ],
                                          image: DecorationImage(
                                            image: FileImage(
                                              File(
                                                instantMessage.attachmentPath!,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : const SizedBox(),
                            ],
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
          Column(
            children: [
              selectedImage == null
                  ? const SizedBox()
                  : Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.orangeAccent,
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.image_outlined),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              selectedImage?.path ?? 'No selected image',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                selectedImage = null;
                                attachmentPath = null;
                              });
                            },
                            padding: const EdgeInsets.all(0),
                            visualDensity: VisualDensity.compact,
                            icon: const Icon(Icons.cancel_outlined),
                          ),
                        ],
                      ),
                    ),
              Container(
                padding: const EdgeInsets.all(12).copyWith(top: 2),
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
                            onPressed: () async {
                              final imgPath = await ImagePicker().pickImage(
                                source: ImageSource.gallery,
                              );
                              if (imgPath != null) {
                                setState(() {
                                  selectedImage = File(imgPath.path);
                                  attachmentPath = selectedImage?.path;
                                });
                              }
                            },
                            icon: const Icon(Icons.image_search_outlined),
                            color: Colors.black,
                          ),
                          fillColor: Colors.black26,
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.orange),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.deepOrange),
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    IconButton.filled(
                      onPressed: () async {
                        if (!chatEmpty && messageController.text.isNotEmpty) {
                          MessageModel newMessage = MessageModel(
                            message: messageController.text,
                            sender: SenderEnum.you,
                            attachmentPath: attachmentPath,
                            timeSent:
                                DateFormat(DateFormat.YEAR_MONTH_DAY).format(
                              DateTime.now(),
                            ),
                          );

                          messages.add(newMessage);
                          messageController.clear();
                          chatEmpty = true;
                          title = newMessage.message;
                          chatTitle ??= AnimatedTextKit(
                            animatedTexts: [
                              TypewriterAnimatedText(newMessage.message)
                            ],
                            isRepeatingAnimation: false,
                          );
                          selectedImage = null;
                          attachmentPath = null;
                          setState(() {});
                          final geminiResponse =
                              await controller.messageController.sendChat(
                            messages,
                            newMessage,
                          );
                          // newMessage.attachmentPath == null
                          //     ? await chatController
                          //         .sendMessage(newMessage.message)
                          //     : await chatController.sendImageTextMessage(
                          //         tempImg!,
                          //         newMessage.message,
                          //       );
                          if (geminiResponse != null) {
                            messages.add(
                              MessageModel(
                                message: geminiResponse,
                                sender: SenderEnum.chef,
                                timeSent: DateFormat(DateFormat.YEAR_MONTH_DAY)
                                    .format(
                                  DateTime.now(),
                                ),
                              ),
                            );
                          }
                          chatModel!.chats = messages;
                          await controller.userController
                              .updateChats(chatModel!);
                          setState(() {});
                        }
                      },
                      iconSize: 30,
                      padding: const EdgeInsets.all(12),
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          chatEmpty ? Colors.grey : Colors.orange.shade800,
                        ),
                      ),
                      icon: chatEmpty
                          ? Icon(
                              Iconsax.send_1_bold,
                              color: Colors.orange.shade100,
                            )
                          : const Icon(Iconsax.send_1_bold),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ImageDialogOverlay extends StatelessWidget {
  const ImageDialogOverlay({
    required this.imagePath,
    super.key,
  });

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black45,
      insetPadding: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      child: InkWell(
        onTap: () => Get.back(),
        child: Stack(
          children: [
            Positioned(
              top: 10,
              left: 10,
              child: IconButton.filled(
                onPressed: () {
                  Get.back();
                },
                style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.orange),
                ),
                icon: const Icon(
                  Icons.close,
                  color: Colors.black,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: AspectRatio(
                // width: MediaQuery.of(context).size.width,
                // height: MediaQuery.of(context).size.height / 2,
                aspectRatio: 5 / 4,
                child: Image.file(
                  File(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
