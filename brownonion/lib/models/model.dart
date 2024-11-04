// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

List<UserModel> userModelFromJson(String str) =>
    List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String userModelToJson(List<UserModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel {
  int complaintId;
  String complaintNo;
  String complaintFrom;
  int complaintTypeId;
  String complaintDescription;
  int statusId;
  int chefId;
  int userId;
  DateTime createdDate;
  String comments;
  DateTime modifiedDate;
  List<dynamic> images;
  String status;
  String restaurantName;
  String customerName;
  String complaintType;
  String createdDateString;

  UserModel({
    required this.complaintId,
    required this.complaintNo,
    required this.complaintFrom,
    required this.complaintTypeId,
    required this.complaintDescription,
    required this.statusId,
    required this.chefId,
    required this.userId,
    required this.createdDate,
    required this.comments,
    required this.modifiedDate,
    required this.images,
    required this.status,
    required this.restaurantName,
    required this.customerName,
    required this.complaintType,
    required this.createdDateString,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        complaintId: json["complaintId"],
        complaintNo: json["complaintNo"],
        complaintFrom: json["complaintFrom"],
        complaintTypeId: json["complaintTypeId"],
        complaintDescription: json["complaintDescription"],
        statusId: json["statusId"],
        chefId: json["chefId"],
        userId: json["userId"],
        createdDate: DateTime.parse(json["createdDate"]),
        comments: json["comments"],
        modifiedDate: DateTime.parse(json["modifiedDate"]),
        images: List<dynamic>.from(json["images"].map((x) => x)),
        status: json["status"],
        restaurantName: json["restaurantName"],
        customerName: json["customerName"],
        complaintType: json["complaintType"],
        createdDateString: json["createdDateString"],
      );

  Map<String, dynamic> toJson() => {
        "complaintId": complaintId,
        "complaintNo": complaintNo,
        "complaintFrom": complaintFrom,
        "complaintTypeId": complaintTypeId,
        "complaintDescription": complaintDescription,
        "statusId": statusId,
        "chefId": chefId,
        "userId": userId,
        "createdDate": createdDate.toIso8601String(),
        "comments": comments,
        "modifiedDate": modifiedDate.toIso8601String(),
        "images": List<dynamic>.from(images.map((x) => x)),
        "status": status,
        "restaurantName": restaurantName,
        "customerName": customerName,
        "complaintType": complaintType,
        "createdDateString": createdDateString,
      };
}
