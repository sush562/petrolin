import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petrolin/data/entity/fuel_types.dart';
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
  String _selectedFuelType = petrol;
  late TextEditingController _dateController;
  final TextEditingController _amountEditingController =
      TextEditingController();
  final TextEditingController _amountFuelPriceLiterEditingController =
      TextEditingController();
  late AddFuelDetailViewModel _addFuelDetailViewModel;
  bool _isLoading = true;
  double _fuelPricePerLiter = 0.0;

  @override
  void initState() {
    super.initState();
    _addFuelDetailViewModel = ref.read(addFuelDetailsViewModelNotifier);
    _dateController =
        TextEditingController(text: "${_selectedDate.toLocal()}".split(' ')[0]);
    setState(() {
      _isLoading = true;
    });
    if (widget.id > 0) {
      _loadExistingEntry(widget.id);
    } else {
      _loadFuelCosts();
    }
  }

  void _loadFuelCosts() async {
    await _addFuelDetailViewModel.loadDefaultFuelCosts();
    if (_addFuelDetailViewModel.petrolPerLiterPrice != null) {
      _fuelPricePerLiter =
          _addFuelDetailViewModel.petrolPerLiterPrice!.fuelPerLiterCost;
    }
    setState(() {
      _amountFuelPriceLiterEditingController.text =
          _fuelPricePerLiter.toString();
      _isLoading = false;
    });
  }

  void _loadExistingEntry(int id) async {
    final existingEntry = await _addFuelDetailViewModel.getFuelEntryById(id);
    if (existingEntry != null) {
      setState(() {
        _amountEditingController.text = existingEntry.fuelCost.toString();
        _selectedDate = existingEntry.entryTime;
        _dateController.text = "${_selectedDate.toLocal()}".split(' ')[0];
        _selectedFuelType = existingEntry.fuelType;
        _fuelPricePerLiter = existingEntry.fuelPerLiterCost;
        _amountFuelPriceLiterEditingController.text =
            _fuelPricePerLiter.toString();
        _isLoading = false;
      });
    }
  }

  void _switchFuelType(String fuelType) {
    print(fuelType);
    setState(() {
      _selectedFuelType = fuelType;
      _fuelPricePerLiter =
          _addFuelDetailViewModel.getFuelPrice(_selectedFuelType);
      _amountFuelPriceLiterEditingController.text =
          _fuelPricePerLiter.toString();
    });
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
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          widget.id > 0 ? "Update Fuel Details" : "Add Fuel Details",
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
          : Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextFormField(
                        controller: _amountEditingController,
                        decoration: const InputDecoration(
                            labelText: 'Enter Fuel Amount'),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              double.parse(value) <= 0.0) {
                            return 'Please enter valid amount';
                          }
                          return null;
                        },
                        style: const TextStyle(fontSize: 18),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d*\.?\d{0,2}'))
                        ],
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true)),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _dateController,
                      decoration: const InputDecoration(
                        labelText: "Select Date",
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                      readOnly: true,
                      onTap: () => _pickDate(),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                        controller: _amountFuelPriceLiterEditingController,
                        decoration: const InputDecoration(
                            labelText: 'Enter Fuel Price Per Liter'),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              double.parse(value) <= 0.0) {
                            return 'Please enter valid amount';
                          }
                          return null;
                        },
                        style: const TextStyle(fontSize: 18),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d*\.?\d{0,2}'))
                        ],
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true)),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Text('Fuel Type: '),
                        const SizedBox(width: 16),
                        DropdownButton(
                            value: _selectedFuelType,
                            items: fuelTypes.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              _switchFuelType(newValue!);
                            }),
                      ],
                    ),
                    const Spacer(),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _submitFuelEntry(context);
                          }
                        },
                        child: Text(widget.id > 0 ? 'Update' : 'Submit'),
                      ),
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
          _selectedFuelType,
          double.parse(_amountFuelPriceLiterEditingController.text));
    } else {
      await _addFuelDetailViewModel.addNewFuelEntry(
          double.parse(_amountEditingController.text),
          _selectedDate,
          _selectedFuelType,
          double.parse(_amountFuelPriceLiterEditingController.text));
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
