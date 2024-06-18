import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petrolin/presentation/viewmodel/add_fuel_details_viewmodel.dart';

class AddPetrolDetailsScreen extends ConsumerStatefulWidget {
  final int id;

  const AddPetrolDetailsScreen({super.key, this.id = 0});

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
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _addFuelDetailViewModel = ref.read(addFuelDetailsViewModelNotifier);
    _dateController =
        TextEditingController(text: "${_selectedDate.toLocal()}".split(' ')[0]);
    if (widget.id > 0) {
      _loadExistingEntry(widget.id);
    } else {
      _isLoading = false;
    }
  }

  void _loadExistingEntry(int id) async {
    final existingEntry = await _addFuelDetailViewModel.getFuelEntryById(id);
    if (existingEntry != null) {
      setState(() {
        _amountEditingController.text = existingEntry.fuelCost.toString();
        _selectedDate = existingEntry.entryTime;
        _dateController.text = "${_selectedDate.toLocal()}".split(' ')[0];
        _isLoading = false;
      });
    }
  }

  void _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          widget.id > 0 ? "Update Petrol Details" : "Add Petrol Details",
          style: const TextStyle(color: Colors.white),
        ),
        actions: widget.id > 0
            ? [
                IconButton(
                    onPressed: () {
                      _showDeleteConfirmationDialog(context);
                    },
                    icon: const Icon(Icons.delete))
              ]
            : [],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                        controller: _amountEditingController,
                        decoration: const InputDecoration(
                            labelText: 'Enter Fuel Amount'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter valid amount';
                          }
                          return null;
                        },
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'^\d*\.?\d{0,2}'),
                          )
                        ],
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true)),
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
                      child: Text(widget.id > 0 ? 'Update' : 'Submit'),
                    )
                  ],
                ),
              ),
            ),
    );
  }

  void _submitFuelEntry(BuildContext context) async {
    if (widget.id > 0) {
      await _addFuelDetailViewModel.updateFuelEntry(
        widget.id,
        double.parse(_amountEditingController.text),
        _selectedDate,
      );
    } else {
      await _addFuelDetailViewModel.addNewFuelEntry(
        double.parse(_amountEditingController.text),
        _selectedDate,
      );
    }
    Navigator.pop(context);
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Entry'),
          content: const Text('Are you sure you want to delete this entry?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _deleteEntry(widget.id, context);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _deleteEntry(int id, BuildContext context) async {
    await _addFuelDetailViewModel.deleteEntry(id);
    Navigator.pop(context);
  }
}
