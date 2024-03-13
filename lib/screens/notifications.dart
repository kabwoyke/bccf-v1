import 'package:bccf/main.dart';
import 'package:bccf/services/cache/NotificationDatabase.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final  announcements = supabase.from("announcements").stream(primaryKey: ["id"]);
  final notObj = NotificationDatabase();
  Future<bool> _checkNetConnection() async{
    bool result = await InternetConnection().hasInternetAccess;
    return result;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<NotificationDatabase>().fetchNotification();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    //    notObj.fetchNotification();
    // });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
      ),
      body:
        StreamBuilder(
          stream: InternetConnection().onStatusChange,
          builder: (context , snapshot) {
            if(snapshot.hasError){
              return Center(
                child: Text("${snapshot.error}"),
              );
            }

              if(snapshot.data == InternetStatus.disconnected){
                  Text("no internet detected, please enable for latest notification");
              }

            return Consumer<NotificationDatabase>(
              builder: (context, value , child) {
                return Text(value.announcements.toString());
              }
            );
            })

      );
  }
}
