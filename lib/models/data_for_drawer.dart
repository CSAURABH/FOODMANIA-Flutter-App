// To parse this JSON data, do
//
//     final dataForDrawer = dataForDrawerFromJson(jsonString);

import 'dart:convert';

List<DataForDrawer> dataForDrawerFromJson(String str) =>
    List<DataForDrawer>.from(
        json.decode(str).map((x) => DataForDrawer.fromJson(x)));

String dataForDrawerToJson(List<DataForDrawer> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DataForDrawer {
  DataForDrawer({
    required this.emailId,
    required this.fullName,
  });

  String emailId;
  String fullName;

  factory DataForDrawer.fromJson(Map<String, dynamic> json) => DataForDrawer(
        emailId: json["Email-Id"],
        fullName: json["Full-Name"],
      );

  Map<String, dynamic> toJson() => {
        "Email-Id": emailId,
        "Full-Name": fullName,
      };
}
