import 'package:flutter/material.dart';

class RestaurantDatesPage extends StatelessWidget {
  const RestaurantDatesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox.expand(
          child: Text("Dates n the restaurant")
        ),
      ),
    );
  }
}