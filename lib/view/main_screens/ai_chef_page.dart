import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:recipe_on_net/controller/user_controller.dart';
import 'package:recipe_on_net/view/chat_pages/chat_screen.dart';

class AiChefPage extends StatefulWidget {
  const AiChefPage({super.key});

  @override
  State<AiChefPage> createState() => _AiChefPageState();
}

class _AiChefPageState extends State<AiChefPage> {
  bool chatEmpty = false;
  UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: const Text(
            'AI Chef',
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [
            userController.chatIndexToDelete.isNotEmpty
                ? IconButton(
                    onPressed: () async {
                      await userController.batchChatDelete();
                    },
                    icon: const Icon(Icons.delete_outline),
                    color: Colors.black,
                  )
                : const SizedBox()
          ],
        ),
        body: userController.userModel.value.savedChats?.isEmpty ?? true
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AspectRatio(
                      aspectRatio: 3 / 2,
                      child: SvgPicture.asset(
                        'assets/illustrations/robot_write.svg',
                        // color: Colors.orange,
                        fit: BoxFit.contain,
                        alignment: Alignment.center,
                        // colorFilter: const ColorFilter.mode(
                        //   Colors.orangeAccent,
                        //   BlendMode.srcIn,
                        // ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Text(
                    //   '',
                    //   textAlign: TextAlign.center,
                    //   style: TextStyle(
                    //     color: Colors.orange.shade800,
                    //     fontFamily: 'Klasik',
                    //     fontSize: 20,
                    //   ),
                    // ),
                    const SizedBox(height: 10),
                    Text(
                      'You don\'t have any chat history yet',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.orange.shade800,
                        fontSize: 18,
                        fontFamily: 'Klasik',
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Start a conversation',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.orange.shade800,
                        fontSize: 18,
                        fontFamily: 'Klasik',
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              )
            : Obx(
                () => ListView.separated(
                  itemBuilder: (context, index) => ListTile(
                    onLongPress: () {
                      userController.chatIndexToDelete.add(index);
                    },
                    enabled: true,
                    selectedColor: Colors.black,
                    selectedTileColor: const Color.fromARGB(135, 255, 60, 0),
                    selected: userController.chatIndexToDelete.contains(index),
                    onTap: () {
                      if (userController.chatIndexToDelete.contains(index)) {
                        userController.chatIndexToDelete.remove(index);
                      } else if (userController.chatIndexToDelete.isNotEmpty) {
                        userController.chatIndexToDelete.add(index);
                      } else {
                        Get.to(() => ChatScreen(
                              chatIndex: index,
                            ));
                      }
                    },
                    title: Text(
                      'Chef chat $index',
                    ),
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.blue.shade100,
                      child: const Text(
                        '🤖',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    titleTextStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Colors.grey.shade800,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(
                          () => Text(
                            '${userController.userModel.value.savedChats![index].chats?.last.sender.toString().replaceAll('SenderEnum.', '').capitalize ?? ''} : ${userController.userModel.value.savedChats![index].chats?.last.message ?? ''} ',
                            maxLines: 1,
                          ),
                        ),
                        Obx(
                          () => Text(
                            DateFormat.MMMEd().format(
                              DateTime.tryParse(userController.userModel.value
                                      .savedChats![index].date) ??
                                  DateTime.now(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    isThreeLine: true,
                    trailing: Obx(
                      () => Text(
                        DateFormat(DateFormat.HOUR_MINUTE).format(
                          DateTime.tryParse(userController
                                  .userModel.value.savedChats![index].date) ??
                              DateTime.now(),
                        ),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 0,
                  ),
                  itemCount: userController.userModel.value.savedChats!.length,
                ),
              ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Get.to(() => const ChatScreen());
          },
          backgroundColor: Colors.black,
          foregroundColor: Colors.orange.shade500,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12).copyWith(
              topLeft: Radius.zero,
              bottomLeft: Radius.zero,
            ),
          ),
          label: const Row(
            children: [
              Text('Start Chat'),
              SizedBox(width: 6),
              Icon(Iconsax.message_2_bold),
            ],
          ),
        ),
      ),
    );
  }
}
