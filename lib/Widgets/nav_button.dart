import 'package:flutter/material.dart';

Widget navButton(Icon buttonIcon, poping()) {
  return GestureDetector(
    onTap: () => poping(),
    child: Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: const Color(0xFFCACACA).withOpacity(0.4),
      ),
      child: Center(child: buttonIcon),
    ),
  );
}
