import 'dart:convert';

Region regionFromJson(String str) => Region.fromJson(json.decode(str));

String regionToJson(Region data) => json.encode(data.toJson());

class Region {
  Map<String, String> regions;
  String description;
  String status;

  Region({
    required this.regions,
    required this.description,
    required this.status,
  });

  factory Region.fromJson(Map<String, dynamic> json) => Region(
        regions: Map.from(json["regions"])
            .map((k, v) => MapEntry<String, String>(k, v)),
        description: json["description"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "regions":
            Map.from(regions).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "description": description,
        "status": status,
      };
}
