import 'package:bccf/main.dart';
import 'package:flutter/material.dart';
class NotificationProvider extends ChangeNotifier{
  int notificationCount = 0;

  get count => this.notificationCount;

  void fetchNotificationCount() async {
    var results = await supabase.from("announcements").select();
    notificationCount = results.length;
    notifyListeners();
  }
}