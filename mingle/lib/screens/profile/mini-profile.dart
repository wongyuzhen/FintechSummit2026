import 'package:flutter/material.dart';

class MiniProfile extends StatelessWidget {
  final Map<String, dynamic> profile;

  const MiniProfile({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center, // center the profiles
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            profile["photo"],
            width: 64,
            height: 64,
            fit: BoxFit.cover,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          profile["name"],
          textAlign: TextAlign.center, //center name
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
