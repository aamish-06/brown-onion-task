import "package:brownonion/api/api_service.dart";
import "package:brownonion/consts/app_assets.dart";
import "package:brownonion/consts/app_colors.dart";
import "package:brownonion/models/model.dart";
import "package:brownonion/pages/add_complaint.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/rendering.dart";
import "package:flutter/widgets.dart";
import "package:google_fonts/google_fonts.dart";
import 'package:http/http.dart' as http;
import 'dart:convert';

import "package:image_picker/image_picker.dart";

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final _formKey = GlobalKey<FormState>();

  final ImagePicker _picker = ImagePicker();
  XFile? image;

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      image = pickedFile;
    });
  }

  String _details = '';

  String? _selectedCategory;
  String _complaintDetail = '';

  final List<String> _categories = [
    'Payment',
    'Payment1',
    'Other',
  ];

  // List<Map<String, dynamic>> complaints = [];

  // Future<void> addComplaint(
  //     String payment, String details, XFile? image) async {
  //   var request = http.MultipartRequest(
  //       'POST',
  //       Uri.parse(
  //           'https://brownonions-002-site2.ftempurl.com/api/Complaint/AddComplaint'));

  //   // Add text fields
  //   request.fields['complaintDescription'] = details;
  //   request.fields['payment'] = payment;

  //   // Add image if present
  //   if (image != null) {
  //     var stream = http.ByteStream(image.openRead());
  //     var length = await image.length();
  //     var multipartFile =
  //         http.MultipartFile('file', stream, length, filename: image.name);
  //     request.files.add(multipartFile);
  //   }

  //   var response = await request.send();
  //   final respStr = await response.stream.bytesToString();
  //   final jsonResponse = json.decode(respStr);

  //   if (response.statusCode == 200 && jsonResponse['apiStatusCode'] == 200) {
  //     print('Complaint added successfully!');
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //           content: Text(
  //               'Complaint added successfully: ${jsonResponse['notifyMessage']}')),
  //     );
  //   } else {
  //     print('Failed to add complaint');
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Error: ${jsonResponse['message']}')),
  //     );
  //   }
  // }

  late List<UserModel>? _userModel = [];

  void _addComplaint() async {
    UserModel newComplaint = UserModel(
      complaintId: 0,
      complaintNo: 'C123',
      complaintFrom: 'User',
      complaintTypeId: 1,
      complaintDescription: 'Complaint description here',
      statusId: 1,
      chefId: 3,
      userId: 1,
      createdDate: DateTime.now(),
      comments: 'No comments',
      modifiedDate: DateTime.now(),
      images: [],
      status: 'Pending',
      restaurantName: 'Restaurant',
      customerName: 'Customer',
      complaintType: 'Type',
      createdDateString: DateTime.now().toIso8601String(),
    );

    bool success = await ApiService().addComplaint(newComplaint);
    if (success) {
      print("Complaint added successfully!");
    } else {
      print("Failed to add complaint.");
    }
  }

  @override
  void initState() {
    super.initState();
    //fetchComplaints();
    _getData();
  }

  void _getData() async {
    final users = (await ApiService().getUsers())!;
    if (users != null) {
      setState(() {
        _userModel = users;
      });
    } else {
      setState(() {
        _userModel = [];
      });
    }
  }

  final List<String> items = [
    'Complaint Number',
    'Complaint Number',
    'Complaint Number'
  ];
  final List<String> status = ['Pending', 'Pending', 'Resolved'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.pink,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              decoration: const BoxDecoration(
                  color: AppColors.pink,
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(70))),
              width: double.infinity,
              height: 231,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Create your',
                    style: TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        fontSize: 26,
                        color: AppColors.white),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Complaints',
                            style: TextStyle(
                                fontFamily: 'Plus Jakarta Sans',
                                fontSize: 26,
                                fontWeight: FontWeight.w700,
                                color: AppColors.white),
                          ),
                          Text(
                            'Have something to rant about?',
                            style: TextStyle(
                                fontFamily: 'Plus Jakarta Sans',
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppColors.white),
                          ),
                        ],
                      ),
                      ElevatedButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Stack(
                                      alignment: Alignment.topCenter,
                                      children: [
                                        AlertDialog(
                                          backgroundColor: Colors.white,
                                          content: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    GestureDetector(
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Icon(Icons
                                                            .close_rounded))
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Form(
                                                  key: _formKey,
                                                  child: Column(
                                                    children: [
                                                      DropdownButtonFormField<
                                                          String>(
                                                        decoration:
                                                            InputDecoration(
                                                          labelText: 'Payment',
                                                          floatingLabelBehavior:
                                                              FloatingLabelBehavior
                                                                  .always,
                                                          hintText:
                                                              'Complaint Category',
                                                          hintStyle:
                                                              const TextStyle(
                                                                  fontSize: 12),
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),
                                                          ),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),
                                                            borderSide:
                                                                const BorderSide(
                                                                    color: AppColors
                                                                        .pink),
                                                          ),
                                                        ),
                                                        icon: const Icon(
                                                          Icons
                                                              .arrow_forward_ios_outlined,
                                                          color: AppColors.pink,
                                                          size: 12,
                                                        ),
                                                        value:
                                                            _selectedCategory,
                                                        onChanged: (newValue) {
                                                          setState(() {
                                                            _selectedCategory =
                                                                newValue;
                                                          });
                                                        },
                                                        items: _categories
                                                            .map((category) {
                                                          return DropdownMenuItem(
                                                            value: category,
                                                            child:
                                                                Text(category),
                                                          );
                                                        }).toList(),
                                                        validator: (value) {
                                                          if (value == null) {
                                                            return 'Please select a category';
                                                          }
                                                          return null;
                                                        },
                                                      ),
                                                      const SizedBox(
                                                          height: 16),
                                                      TextFormField(
                                                        decoration:
                                                            InputDecoration(
                                                          labelText: 'Details',
                                                          hintText:
                                                              'Write your complaint...',
                                                          hintStyle:
                                                              const TextStyle(
                                                                  fontSize: 12),
                                                          floatingLabelBehavior:
                                                              FloatingLabelBehavior
                                                                  .always,
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),
                                                            borderSide:
                                                                const BorderSide(
                                                                    color: AppColors
                                                                        .pink),
                                                          ),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),
                                                            borderSide:
                                                                const BorderSide(
                                                                    color: AppColors
                                                                        .pink),
                                                          ),
                                                        ),
                                                        maxLines: 4,
                                                        onChanged: (value) {
                                                          _details = value;
                                                        },
                                                        validator: (value) {
                                                          if (value == null ||
                                                              value.isEmpty) {
                                                            return 'Please enter details';
                                                          }
                                                          return null;
                                                        },
                                                      ),
                                                      const SizedBox(
                                                          height: 20),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Column(
                                                            children: [
                                                              const Text(
                                                                'Attachments',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14),
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              GestureDetector(
                                                                onTap:
                                                                    pickImage,
                                                                child:
                                                                    Container(
                                                                  width: 80,
                                                                  height: 80,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: const Color
                                                                        .fromRGBO(
                                                                        242,
                                                                        242,
                                                                        250,
                                                                        1),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            14),
                                                                  ),
                                                                  child:
                                                                      const Icon(
                                                                    Icons.add,
                                                                    size: 20,
                                                                    color:
                                                                        AppColors
                                                                            .pink,
                                                                  ),
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
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                backgroundColor:
                                                                    AppColors
                                                                        .pink,
                                                                minimumSize:
                                                                    const Size(
                                                                        double
                                                                            .infinity,
                                                                        48)),
                                                        onPressed: () {
                                                          if (_formKey
                                                              .currentState!
                                                              .validate()) {
                                                            _addComplaint();

                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              const SnackBar(
                                                                  content: Text(
                                                                      'Form submitted')),
                                                            );
                                                          }
                                                        },
                                                        child: const Text(
                                                          'Submit',
                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .white),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                            top: 100, //4
                                            child: SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.38,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.06,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: AppColors.pink,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: const Center(
                                                  child: Text(
                                                    'New Complaint',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        decoration:
                                                            TextDecoration
                                                                .none),
                                                  ),
                                                ),
                                              ),
                                            ))
                                      ]);
                                });
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: const CircleBorder(),
                              padding: const EdgeInsets.all(02)),
                          child: const Icon(
                            Icons.add,
                            color: AppColors.pink,
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        size: 20.58,
                        Icons.search,
                        color: AppColors.search,
                      ),
                      hintText: 'Search...',
                      hintStyle: const TextStyle(color: AppColors.search),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        'SORT BY ',
                        style: TextStyle(fontSize: 10, color: AppColors.pink),
                      ),
                      Text(
                        'DATE ADDED',
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: AppColors.pink),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down_outlined,
                        color: AppColors.pink,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            (_userModel == null || _userModel!.isEmpty)
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: _userModel!.length, //items.length,
                    itemBuilder: (context, index) {
                      var complaint = _userModel![index];
                      return Card(
                        color: AppColors.white,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        textAlign: TextAlign.start,
                                        '${items[index]}',
                                        style: const TextStyle(
                                            fontSize: 10,
                                            color: Color.fromRGBO(
                                                103, 106, 108, 1)),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        _userModel![index]
                                            .complaintId
                                            .toString(), //'#000384309283',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      )
                                    ],
                                  ),
                                  ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          backgroundColor:
                                              status[index] == 'Resolved'
                                                  ? AppColors.green
                                                  : AppColors.pink,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 22, vertical: 6)),
                                      child: Text(
                                        '${status[index]}',
                                        style: const TextStyle(
                                            color: AppColors.white,
                                            fontSize: 10,
                                            fontFamily: 'Plus Jakarta Sans'),
                                      )),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.person_3_outlined,
                                        color: AppColors.pink,
                                        size: 15,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        _userModel![index]
                                            .complaintFrom
                                            .toString(),
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      // Image.asset(AppAssets.person,
                                      //     height: 15, width: 15),
                                      Icon(
                                        Icons.calendar_month_rounded,
                                        color: AppColors.pink,
                                        size: 15,
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Text(
                                        'March 30,2024 | 14:33',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontFamily: 'Plus Jakarta Sans',
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Complaint Description',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 11,
                              ),
                              Text(
                                //_userModel!['description'] ?? '',
                                'Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing industries for previewing layouts and visual mockups...',
                                style: const TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.w300),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
