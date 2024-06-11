import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddPetrolDetailsScreen extends StatefulWidget {
  const AddPetrolDetailsScreen({super.key});

  @override
  State<AddPetrolDetailsScreen> createState() {
    return _AddPetrolDetailsScreen();
  }
}

class _AddPetrolDetailsScreen extends State<AddPetrolDetailsScreen> {
  DateTime? _selectedDate;

  void _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime(DateTime.now().year),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          "Add Petrol Details",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          getPetrolInput('Enter Amount',
              const TextInputType.numberWithOptions(decimal: true),
              isDecimal: true)
        ],
      ),
    );
  }

  Widget getPetrolInput(String title, TextInputType textInputType,
      {bool? isDecimal}) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 10),
        ),
        const SizedBox(width: 10),
        TextField(
          keyboardType: textInputType,
          style: const TextStyle(fontSize: 10),
          inputFormatters: isDecimal == null
              ? null
              : [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))],
        ),
      ],
    );
  }
}
