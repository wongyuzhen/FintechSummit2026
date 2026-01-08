import 'package:flutter/material.dart';
import 'package:mingle/screens/profile/mini-profile.dart';

class UserDatesCard extends StatelessWidget {
  final Map<String, dynamic> match;

  const UserDatesCard({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    final DateTime date =
        DateTime.parse(match["dateTime"]);

    TextEditingController keyController = TextEditingController();

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
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),

            const SizedBox(height: 16),

            ///Restaurant
            Text(
              "At: ${match["restaurant"] ?? "Unknown"}",
              style: const TextStyle(fontSize: 16),
            ),


            /// Key Input Field
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: TextField(
                controller: keyController,
                decoration: InputDecoration(
                  labelText: "Enter the Key here",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      // Replace with logic from entering key
                      print("Entered key for ${match["matchId"]}: ${keyController.text}");
                                  print("Match object: $match");
print("Restaurant key: ${match["restaurant"]}");
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
