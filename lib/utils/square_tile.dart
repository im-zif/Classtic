import 'package:classtic/services/auth_services.dart';
import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {

  final String imagePath;
  final Function()? onTap;

  const SquareTile({super.key, required this.imagePath, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 52,
        child: Image.asset(imagePath),
      ),
    );
  }
}
