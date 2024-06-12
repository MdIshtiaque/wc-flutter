import 'package:flutter/material.dart';
import 'package:sarra/services/department_service.dart';
import 'package:sarra/services/district_service.dart';
import 'package:sarra/widgets/custom_dropdown.dart';
import 'package:sarra/widgets/custom_text_field.dart';
import 'package:sarra/models/inventory_form_data.dart';

import '../models/dropdown_item.dart';
import '../services/division_service.dart';
import '../services/range_service.dart';

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
  List<DropdownItem> _departments = [];
  String? _selectedDepartment;
  List<DropdownItem> _divisions = [];
  String? _selectedDivision;
  List<DropdownItem> _districts = [];
  String? _selectedDistrict;
  List<DropdownItem> _ranges = [];
  String? _selectedRange;
  bool _isLoading = true;
  bool _isRangeLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchDepartments();
    _fetchDivisions();
    _fetchDistricts();
  }

  @override
  void dispose() {
    _ngoNameController.dispose();
    _waterSourceNameController.dispose();
    super.dispose();
  }

  Future<void> _fetchDepartments() async {
    try {
      List<DropdownItem> departments =
          await DepartmentApiService().fetchDepartments();
      setState(() {
        _departments = departments;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchDivisions() async {
    try {
      List<DropdownItem> divisions =
          await DivisionApiService().fetchDivisions();
      setState(() {
        _divisions = divisions;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchDistricts() async {
    try {
      List<DropdownItem> districts =
          await DistrictApiService().fetchDistricts();
      setState(() {
        _districts = districts;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchRanges(int divisionId) async {
    setState(() {
      _isRangeLoading = true;
      _ranges = [];
    });

    try {
      List<DropdownItem> ranges =
          await RangeApiService().fetchRanges(divisionId);
      setState(() {
        _ranges = ranges;
        _isRangeLoading = false;
      });
    } catch (e) {
      setState(() {
        _isRangeLoading = false;
      });
    }
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
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : CustomDropdown(
                        label: 'Department',
                        items: _departments.map((item) => item.name).toList(),
                        value: _selectedDepartment,
                        validator: (value) => value == null || value.isEmpty
                            ? 'This field is required'
                            : null,
                        onChanged: (value) => setState(() {
                          _selectedDepartment = value;
                          _inventoryFormData.department = value;
                        }),
                      ),
                if (_selectedDepartment == 'NGO')
                  CustomTextField(
                    label: 'NGO Name',
                    controller: _ngoNameController,
                    isRequired: true,
                  ),
                _selectedDepartment == 'Van Vibhag'
                    ? Column(
                        children: [
                          CustomDropdown(
                            label: 'Division',
                            items: _divisions.map((item) => item.name).toList(),
                            value: _selectedDivision,
                            validator: (value) => value == null || value.isEmpty
                                ? 'This field is required'
                                : null,
                            onChanged: (value) => setState(() {
                              _selectedDivision = value;
                              _inventoryFormData.division = value;
                              if (value != null) {
                                final division = _divisions.firstWhere(
                                    (element) => element.name == value);
                                _fetchRanges(division.id);
                              }
                            }),
                          ),
                          _isRangeLoading
                              ? const Center(child: CircularProgressIndicator())
                              : CustomDropdown(
                                  label: 'Range',
                                  items: _ranges.map((item) => item.name).toList(),
                                  value: _selectedRange,
                                  validator: (value) =>
                                      value == null || value.isEmpty
                                          ? 'This field is required'
                                          : null,
                                  onChanged: (value) => setState(() {
                                    _selectedRange = value;
                                    _inventoryFormData.range = value;
                                  }),
                                ),
                        ],
                      )
                    : Column(
                        children: [
                          _isLoading
                              ? const Center(child: CircularProgressIndicator())
                              : CustomDropdown(
                            label: 'District',
                            items: _districts.map((item) => item.name).toList(),
                            value: _selectedDistrict,
                            validator: (value) => value == null || value.isEmpty
                                ? 'This field is required'
                                : null,
                            onChanged: (value) => setState(() {
                              _selectedDistrict = value;
                              _inventoryFormData.district = value;
                              // if (value != null) {
                              //   final division = _districts.firstWhere(
                              //           (element) => element.name == value);
                              //   _fetchRanges(division.id);
                              // }
                            }),
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
                            onChanged: (value) =>
                                _inventoryFormData.village = value,
                          ),
                        ],
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
                  items: ['Perennial', 'Seasonal'],
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
