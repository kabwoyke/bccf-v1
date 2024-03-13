import 'dart:async';

import 'package:bccf/components/appbar.dart';
import 'package:flutter/material.dart';

class Mypledge extends StatefulWidget {
  const Mypledge({super.key});

  @override
  State<Mypledge> createState() => _MypledgeState();
}

class _MypledgeState extends State<Mypledge> {
  int remainingTime = 60; // Initial time in seconds
  late Timer timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
   void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (remainingTime > 0) {
          remainingTime--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Custom_appbar()),

      body: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (ctx , index){
                        return Card(
                          child: ListTile(
                            leading: Icon(Icons.notifications),
                            trailing: Icon(Icons.arrow_right),
                            title: Text("Pledge days"),
                            subtitle: Text("Amount"),
                          ),
                        );
                      }
                  ),
    );
  }
}
