import "package:brownonion/consts/app_colors.dart";
import "package:brownonion/pages/add_complaint.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/rendering.dart";
import "package:flutter/widgets.dart";
import "package:google_fonts/google_fonts.dart";
import 'package:http/http.dart' as http;
import 'dart:convert';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedCategory;
  String _complaintDetail = '';

  final List<String> _categories = [
    'Payment',
    'Payment1',
    'Other',
  ];

  List<dynamic> complaints = [];

  @override
  void initState() {
    super.initState();
    //fetchComplaints();
  }

  // Future<void> fetchComplaints() async {
  //   final url =
  //       'https://brownonions-002-site2.ftempurl.com/api/Complaint/GetComplaints?ComplaintId=-1&ChefId=3&UserId=-1&StatusId=-1&ComplaintTypeId=-1&FromComplaint=chef';
  //   try {
  //     final response = await http.get(Uri.parse(url));
  //     if (response.statusCode == 200) {
  //       setState(() {
  //         complaints = json.decode(response.body);
  //       });
  //     } else {
  //       throw Exception('Failed to load complaints');
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //   }
  // }

  final List<String> items = [
    'Complaint Number',
    'Complaint Number',
    'Complaint Number'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AddComplaint()));
                        },
                        child: const CircleAvatar(
                          backgroundColor: AppColors.white,
                          child: Icon(
                            Icons.add,
                            color: AppColors.pink,
                          ),
                        ),
                      ),
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
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
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
            SizedBox(
              height: double.maxFinite,
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text('${items[index]}'),
                                const Text(
                                  '#000384309283',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                )
                              ],
                            ),
                            ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.pink,
                                ),
                                child: const Text(
                                  'Pending',
                                  style: TextStyle(color: AppColors.white),
                                )),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
