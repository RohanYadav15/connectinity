import 'dart:ffi';

class Opportunity {
  final String title;
  final String description;
  final String orgName;
  final List<Float> location;
  final DateTime timeCreated;
  // final List<String> responders;

  Opportunity({
    required this.title,
    required this.description,
    required this.orgName,
    required this.location,
    required this.timeCreated,
  });

  factory Opportunity.fromMap(Map<String, dynamic> data) {
    return Opportunity(
        title: data['title'],
        description: data['description'],
        orgName: data['orgName'],
        location: data['location'],
        timeCreated: data['TimeCreated']);
    // responders: data['responders']);
  }
}
