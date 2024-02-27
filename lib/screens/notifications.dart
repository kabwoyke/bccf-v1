import 'package:bccf/main.dart';
import 'package:bccf/models/EventModel.dart';
import 'package:bccf/state/NotificationProvider.dart';
import 'package:loading_indicator/loading_indicator.dart';
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

  Future<bool> _checkNetConnection() async{
    bool result = await InternetConnection().hasInternetAccess;
    return result;
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
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.signal_wifi_off_outlined),
                      Text("No internet, please enable your internet connection"),
                    ],
                  ),
                );
              }


            return Consumer<NotificationProvider>(builder: (ctx,value,child){
              return StreamBuilder
                (
                stream: announcements,
                builder: (context, snapshot) {
                  if (snapshot.hasError){
                    return Center(child:Text("${snapshot.error}"));
                  }
                  if(!snapshot.hasData){
                    return Center(
                        child: Container(
                          width: 100,
                          height: 100,
                          child: LoadingIndicator(
                            indicatorType: Indicator.ballClipRotateMultiple,
                            colors:  [Colors.blue.shade600],
                          ),
                        )
                    );
                  }

                  return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (ctx , index){
                        return Card(
                          child: ListTile(
                            leading: Icon(Icons.notifications),
                            trailing: Icon(Icons.arrow_right),
                            title: Text("${snapshot.data![index]['title']}"),
                            subtitle: Text("${snapshot.data![index]['content']}"),
                          ),
                        );
                      }
                  );
                }
            );
          }
            );
            })

      );
  }
}
