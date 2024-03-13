import 'package:flutter/material.dart';

  class NotificationIcon extends StatelessWidget {
    final IconData icon;
    final int counter;


    NotificationIcon({required this.icon, required this.counter});

    @override
    Widget build(BuildContext context) {
      return Column(
        children: [
          SizedBox(height: 6,),
          Padding(
            padding: const EdgeInsets.only(top: 0, right: 8),
            child: Center(
              child: Stack(
                children: [
                  Icon(
                    icon,
                    size: 28,
                    color: Colors.black,
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      constraints: BoxConstraints(
                        minWidth: 10,
                        minHeight: 10,
                      ),
                      child: Text(
                        counter.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Text("Notification")
        ],
      );
    }
  }