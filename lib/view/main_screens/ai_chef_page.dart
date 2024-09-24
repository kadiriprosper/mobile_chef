import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:recipe_on_net/view/chat_pages/chat_screen.dart';

class AiChefPage extends StatefulWidget {
  const AiChefPage({super.key});

  @override
  State<AiChefPage> createState() => _AiChefPageState();
}

class _AiChefPageState extends State<AiChefPage> {
  bool chatEmpty = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text(
          'AI Chef',
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: chatEmpty
          ? const Align(
              alignment: Alignment.center,
              child: Text(
                'Click the start chat button\nto start a new chat',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          : ListView.separated(
              itemBuilder: (context, index) => ListTile(
                onTap: () {
                  //TODO: Go to the chat screen
                  print('Hello world');
                },
                title: Text(
                  'How to cook brother wine',
                ),
                leading: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.blue.shade100,
                  child: Text(
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
                subtitle: Text(
                  DateFormat.MMMEd().format(
                    DateTime.now(),
                  ),
                ),
                trailing: Text(
                  DateFormat(DateFormat.HOUR_MINUTE).format(
                    DateTime.now(),
                  ),
                ),
              ),
              separatorBuilder: (context, index) => const SizedBox(
                height: 12,
              ),
              itemCount: 20,
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
    );
  }
}
