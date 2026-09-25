import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  String id, eventImage, eventName, eventTitle, eventDescription;
  int eventCategoryIndex;
  DateTime eventDate;
  bool isFavorite;
  static const String collectionName = 'Events';

  Event({
    this.id = '',
    required this.eventImage,
    required this.eventName,
    required this.eventTitle,
    required this.eventDescription,
    required this.eventDate,
    required this.eventCategoryIndex,
    this.isFavorite = false,
  });

  Map<String, dynamic> toJsonFirestore() {
    return {
      'id': id,
      'eventImage': eventImage,
      'eventName': eventName,
      'eventTitle': eventTitle,
      'eventDescription': eventDescription,
      'eventCategoryIndex': eventCategoryIndex,
      'eventDate': eventDate,
      'isFavorite': isFavorite,
    };
  }

  Event.fromJsonFirestore(Map<String, dynamic> data)
    : this(
        id: data['id'],
    eventImage: data['eventImage'],
    eventName: data['eventName'],
        eventTitle: data['eventTitle'],
        eventDescription: data['eventDescription'],
        eventCategoryIndex: data['eventCategoryIndex'],
        eventDate: (data['eventDate'] as Timestamp).toDate(),
        isFavorite: data['isFavorite'],
      );
}
