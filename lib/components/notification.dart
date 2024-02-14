import 'package:flutter/material.dart';

  class NotificationIcon extends StatelessWidget {
    final IconData icon;
    final int counter;

    NotificationIcon({required this.icon, required this.counter});

    @override
    Widget build(BuildContext context) {
      return Stack(
        children: [
          Icon(
            icon,
            size: 32,
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
                minWidth: 15,
                minHeight: 15,
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
      );
    }
  }