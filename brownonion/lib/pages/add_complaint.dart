import 'package:brownonion/consts/app_colors.dart';
import 'package:flutter/material.dart';

class AddComplaint extends StatefulWidget {
  const AddComplaint({super.key});

  @override
  State<AddComplaint> createState() => _AddComplaintState();
}

class _AddComplaintState extends State<AddComplaint> {
  final _formKey = GlobalKey<FormState>();

  String? _selectedCategory;
  String _details = '';
  List<String> _categories = ['Category 1', 'Category 2', 'Category 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.pink),
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.pink),
                  padding: const EdgeInsets.all(4),
                  child: const Text(
                    'New Complaint',
                    style: TextStyle(color: AppColors.white, fontSize: 14),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.close)),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Payment',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: 'Complaint Category',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppColors.pink),
                        ),
                      ),
                      icon: const Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: AppColors.pink,
                        size: 15,
                      ),
                      value: _selectedCategory,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedCategory = newValue;
                        });
                      },
                      items: _categories.map((category) {
                        return DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        );
                      }).toList(),
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a category';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Details',
                        hintText: 'Write your complaint...',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppColors.pink),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppColors.pink),
                        ),
                      ),
                      maxLines: 8,
                      onChanged: (value) {
                        _details = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter details';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            const Text(
                              'Attachments',
                              style: TextStyle(fontSize: 14),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(242, 242, 250, 1),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: const Icon(
                                Icons.add,
                                size: 20,
                                color: AppColors.pink,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.pink,
                          minimumSize: const Size(double.infinity, 48)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Form submitted')),
                          );
                        }
                      },
                      child: const Text(
                        'Submit',
                        style: TextStyle(color: AppColors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
