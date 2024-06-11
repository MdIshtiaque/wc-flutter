import 'package:flutter/material.dart';
import 'package:sarra/widgets/custom_dropdown.dart';
import 'package:sarra/widgets/custom_text_field.dart';
import 'package:sarra/models/inventory_form_data.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key}) : super(key: key);

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _inventoryFormData = InventoryFormData();
  final _ngoNameController = TextEditingController();
  final _waterSourceNameController = TextEditingController();

  @override
  void dispose() {
    _ngoNameController.dispose();
    _waterSourceNameController.dispose();
    super.dispose();
  }

  void _pickLocation() {
    // Placeholder for location picking functionality
    setState(() {
      _inventoryFormData.latitude = 12.9715987;
      _inventoryFormData.longitude = 77.5945627;
      _inventoryFormData.elevation = 920.0;
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Handle form submission
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Form submitted successfully')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Inventory Form',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomDropdown(
                  label: 'Department',
                  items: ['Dept1', 'Dept2', 'Dept3'],
                  validator: (value) => value == null || value.isEmpty
                      ? 'This field is required'
                      : null,
                  onChanged: (value) => _inventoryFormData.department = value,
                ),
                CustomTextField(
                  label: 'NGO Name',
                  controller: _ngoNameController,
                  isRequired: true,
                ),
                CustomDropdown(
                  label: 'Division',
                  items: ['Division1', 'Division2', 'Division3'],
                  validator: (value) => value == null || value.isEmpty
                      ? 'This field is required'
                      : null,
                  onChanged: (value) => _inventoryFormData.division = value,
                ),
                CustomDropdown(
                  label: 'District',
                  items: ['District1', 'District2', 'District3'],
                  validator: (value) => value == null || value.isEmpty
                      ? 'This field is required'
                      : null,
                  onChanged: (value) => _inventoryFormData.district = value,
                ),
                CustomDropdown(
                  label: 'Development Block',
                  items: ['Block1', 'Block2', 'Block3'],
                  validator: (value) => value == null || value.isEmpty
                      ? 'This field is required'
                      : null,
                  onChanged: (value) =>
                      _inventoryFormData.developmentBlock = value,
                ),
                CustomDropdown(
                  label: 'Gram Panchayat',
                  items: ['Panchayat1', 'Panchayat2', 'Panchayat3'],
                  validator: (value) => value == null || value.isEmpty
                      ? 'This field is required'
                      : null,
                  onChanged: (value) =>
                      _inventoryFormData.gramPanchayat = value,
                ),
                CustomDropdown(
                  label: 'Village',
                  items: ['Village1', 'Village2', 'Village3'],
                  validator: (value) => value == null || value.isEmpty
                      ? 'This field is required'
                      : null,
                  onChanged: (value) => _inventoryFormData.village = value,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ElevatedButton.icon(
                    onPressed: _pickLocation,
                    icon: const Icon(Icons.location_on),
                    label: const Text(
                      'Pick Location',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                if (_inventoryFormData.latitude != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'Lat: ${_inventoryFormData.latitude}, Long: ${_inventoryFormData.longitude}, Elevation: ${_inventoryFormData.elevation}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                CustomTextField(
                  label: 'Water Source Name',
                  controller: _waterSourceNameController,
                  isRequired: true,
                ),
                CustomDropdown(
                  label: 'Water Source Type',
                  items: ['Type1', 'Type2', 'Type3'],
                  validator: (value) => value == null || value.isEmpty
                      ? 'This field is required'
                      : null,
                  onChanged: (value) =>
                      _inventoryFormData.waterSourceType = value,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
