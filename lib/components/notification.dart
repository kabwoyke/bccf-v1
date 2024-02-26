import 'package:flutter/material.dart';

  class NotificationIcon extends StatelessWidget {
    final IconData icon;
    final int counter;

    NotificationIcon({required this.icon, required this.counter});

    @override
    Widget build(BuildContext context) {
      return Column(
        children: [
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.only(top: 8, right: 8),
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
                        minWidth: 14,
                        minHeight: 14,
                      ),
                      child: Text(
                        counter.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
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