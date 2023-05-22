// To parse this JSON data, do
//
//     final contactUs = contactUsFromJson(jsonString);

import 'dart:convert';

ContactUs contactUsFromJson(String str) => ContactUs.fromJson(json.decode(str));

String contactUsToJson(ContactUs data) => json.encode(data.toJson());

class ContactUs {
  String phoneNumber;
  String email;
  String address;

  ContactUs({
    required this.phoneNumber,
    required this.email,
    required this.address,
  });

  factory ContactUs.fromJson(Map<String, dynamic> json) => ContactUs(
    phoneNumber: json["phoneNumber"],
    email: json["email"],
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "phoneNumber": phoneNumber,
    "email": email,
    "address": address,
  };
}
