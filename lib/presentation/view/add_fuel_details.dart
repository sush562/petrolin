import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petrolin/presentation/viewmodel/add_fuel_details_viewmodel.dart';

class AddPetrolDetailsScreen extends ConsumerStatefulWidget {
  const AddPetrolDetailsScreen({super.key});

  @override
  ConsumerState<AddPetrolDetailsScreen> createState() {
    return _AddPetrolDetailsScreen();
  }
}

class _AddPetrolDetailsScreen extends ConsumerState<AddPetrolDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  DateTime _selectedDate = DateTime.now();
  late TextEditingController _dateController;
  final TextEditingController _amountEditingController =
      TextEditingController();
  late AddFuelDetailViewModel _addFuelDetailViewModel;

  void _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1990),
      lastDate: DateTime(DateTime.now().year),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _addFuelDetailViewModel = ref.read(addFuelDetailsViewModelNotifier);
    _dateController =
        TextEditingController(text: "${_selectedDate.toLocal()}".split(' ')[0]);
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
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
                controller: _amountEditingController,
                decoration:
                    const InputDecoration(hintText: 'Enter Fuel Amount'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter valid amount';
                  }
                  return null;
                },
                style: const TextStyle(fontSize: 10),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))
                ],
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true)),
            const SizedBox(height: 10),
            TextField(
              controller: _dateController,
              decoration: const InputDecoration(
                labelText: "Select Date",
                suffixIcon: Icon(Icons.calendar_today),
              ),
              readOnly: true,
              onTap: () => _pickDate(),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _submitFuelEntry(context);
                }
              },
              child: const Text('Submit'),
            )
          ],
        ),
      ),
    );
  }

  void _submitFuelEntry(BuildContext context) async {
    final int insert = await _addFuelDetailViewModel.addNewFuelEntry(
        double.parse(_amountEditingController.text), _selectedDate);
    if (insert > 0) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    }
  }
}
