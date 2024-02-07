import 'package:flutter/material.dart';

import 'database_provider.dart';
import 'message_model.dart';


class DatabaseProviderNotifier extends ChangeNotifier {
  final DatabaseProvider databaseProvider = DatabaseProvider();

  Future<void> OnsendMessage(String groupId, bool isGroup, Message message) async {
    await databaseProvider.sendMessage(groupId, isGroup, message);
    notifyListeners();
  }

  Future<void> createDmConversation(String user1, String user2) async {

    notifyListeners();
  }

// Add other methods with notifyListeners() where appropriate
}
