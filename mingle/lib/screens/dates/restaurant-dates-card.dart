import 'package:flutter/material.dart';
import 'package:mingle/screens/profile/mini-profile.dart';

class RestaurantDateCard extends StatelessWidget {
  final Map<String, dynamic> match;

  const RestaurantDateCard({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    final DateTime date =
        DateTime.parse(match["dateTime"]);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// A & B profiles
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MiniProfile(profile: match["a"]),
                const SizedBox(width: 32),
                MiniProfile(profile: match["b"]),
              ],
            ),

            const SizedBox(height: 16),

            /// Date & Time
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.calendar_today, size: 16),
                const SizedBox(width: 8),
                Text(
                  "${date.day}/${date.month}/${date.year} • "
                  "${date.hour}:${date.minute.toString().padLeft(2, '0')}",
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),

            const SizedBox(height: 16),

            /// Generate Key Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // to be replaced with actual key(SSID) generation function
                  print("Generate key for ${match["matchId"]}");
                },
                child: const Text("Generate Key"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
