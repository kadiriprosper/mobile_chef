import 'dart:io';

import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart' as GAI;
import 'package:recipe_on_net/model/message_model.dart';
import 'package:path/path.dart' as path;

const geminAPIToken = String.fromEnvironment("gemini_api_key");

class MessageController extends GetxController {
  final Gemini gemini = Gemini.instance;
  final geminiModel = GAI.GenerativeModel(
    model: 'gemini-1.5-flash',
    apiKey: geminAPIToken,
    systemInstruction: GAI.Content.system(
      "NOTE: You are a chef, if any of my prompts is outside the scope of food or is not a greeting, return a witty message that says prompt is out of your scope.",
    ),
    safetySettings: [
      GAI.SafetySetting(
        GAI.HarmCategory.harassment,
        GAI.HarmBlockThreshold.low,
      ),
      GAI.SafetySetting(
        GAI.HarmCategory.hateSpeech,
        GAI.HarmBlockThreshold.low,
      ),
      GAI.SafetySetting(
        GAI.HarmCategory.sexuallyExplicit,
        GAI.HarmBlockThreshold.low,
      ),
      GAI.SafetySetting(
        GAI.HarmCategory.dangerousContent,
        GAI.HarmBlockThreshold.none,
      ),
    ],
  );

  Future<GAI.DataPart> fileToPart(String mimeType, String path) async {
    return GAI.DataPart(mimeType, await File(path).readAsBytes());
  }

  Future<String?> sendChat(
    List<MessageModel> history,
    MessageModel message, {
    int retries = 0,
  }) async {
    List<GAI.Content> historyMessages = [];
    // historyMessages.add(
    //   GAI.Content.text(
    //     "NOTE: You are a chef, if any of my prompts is outside the scope of food, return a witty message that says prompt is out of your scope.",
    //   ),
    // );
    for (MessageModel element in history) {
      if (element.sender == SenderEnum.you) {
        if (element.attachmentPath == null) {
          historyMessages.add(GAI.Content.text(element.message));
        } else {
          final dataPart = fileToPart(
            'image/${path.extension(element.attachmentPath!)}',
            element.attachmentPath!,
          );
          historyMessages.add(
            GAI.Content.multi(
              [GAI.TextPart(element.message), await dataPart],
            ),
          );
        }
      } else {
        historyMessages.add(
          GAI.Content.model(
            [GAI.TextPart(element.message)],
          ),
        );
      }
    }
    try {
      final currentChat = geminiModel.startChat(history: historyMessages);
      if (message.attachmentPath != null) {
        final response = await currentChat.sendMessage(
          GAI.Content.multi([
            GAI.TextPart(message.message),
            await fileToPart(
              'image/${path.extension(message.attachmentPath!)}',
              message.attachmentPath!,
            )
          ]),
        );
        return response.text?.replaceAll('**', '').replaceAll('*', '•');
      } else {
        final response = await currentChat.sendMessage(
          GAI.Content.text(message.message),
        );
        return response.text?.replaceAll('**', '').replaceAll('*', '•');
      }
    } on GAI.GenerativeAIException catch (_) {
      if (retries < 3) {
        await sendChat(history, message, retries: ++retries);
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  Future<String?> sendMessage(String message) async {
    try {
      return (await geminiModel.generateContent(
        [
          GAI.Content.text(
            "$message. NOTE: You are a chef, if my prompt is outside the scope of cooking, return a witty message that shows this prompt is out of your scope.",
          )
        ],
      ))
          .text
          ?.replaceAll('**', '')
          .replaceAll('*', '\u8226');
    } catch (e) {
      return null;
    }
  }

  Future<String?> sendImageTextMessage(File imgFile, String? message) async {
    try {
      if (message == null) {
        return (await gemini.textAndImage(
          text:
              "You are a chef, if what is in the image is food, provide me with the name and receipe else, return a witty message that shows this prompt is out of your scope",
          images: [
            imgFile.readAsBytesSync(),
          ],
        ))
            ?.output
            ?.replaceAll('**', '')
            .replaceAll('*', '\u8226');
      } else {
        return (await gemini.textAndImage(
          text:
              "You are a chef, if what is in the image is food, $message else, return a witty message that shows this prompt is out of your scope",
          images: [
            imgFile.readAsBytesSync(),
          ],
        ))
            ?.output
            ?.replaceAll('**', '')
            .replaceAll('*', '\u8226');
      }
    } catch (e) {
      return null;
    }
  }
}
