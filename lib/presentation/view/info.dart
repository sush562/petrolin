import 'package:flutter/material.dart';
import 'package:petrolin/ui/text.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: textAppBar(
          "Info & Disclaimer",
          context,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: textSmall(
                  '''Welcome to the PetrolIn App, designed to help you record fuel fillings for your vehicle conveniently. This app allows you to track refueling instances and total costs incurred over time.

This app is lightweight and operates offline, ensuring a seamless user experience without intrusive advertisements.

Created initially for personal use to manage my vehicle's refueling history, I decided to share it with others who may find it useful.

Please note that this app is developed independently and does not represent any company. Therefore, I assume no liability for any issues that may arise from its use.

I will be constantly improving the app overtime, adding new features.

Your feedback matters! If you find the app helpful, please consider rating it on the Play Store. Your ratings and reviews contribute to my professional growth. Feel free to share your thoughts and suggestions on the Play Store as well.

Thank you for using the PetrolIn App!''',
                  context,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
