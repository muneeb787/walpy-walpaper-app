import 'package:flutter/material.dart';

class FunctionalButton extends StatelessWidget {
  FunctionalButton({
    super.key,
    required this.isload,
    required this.title,
    required this.onPress,
  });

  bool isload;
  String title;
  final VoidCallback onPress;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: 55,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: isload
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : Text(
                  title,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
        ),
      ),
    );
  }
}
