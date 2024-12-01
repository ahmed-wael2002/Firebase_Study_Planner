import 'package:cloud_firestore/cloud_firestore.dart';

class StudyPlan {
  String? id; // Firestore document ID
  String subject;
  String topic;
  DateTime date;
  int duration; // Duration in minutes
  bool isCompleted;

  StudyPlan({
    this.id,
    required this.subject,
    required this.topic,
    required this.date,
    required this.duration,
    this.isCompleted = false,
  });

  // Convert StudyPlan to Map (for Firestore)
  Map<String, dynamic> toMap() {
    return {
      'subject': subject,
      'topic': topic,
      'date': date.toIso8601String(),
      'duration': duration,
      'isCompleted': isCompleted,
    };
  }

  // Create a StudyPlan from Firestore DocumentSnapshot
  static StudyPlan fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return StudyPlan(
      id: doc.id,
      subject: data['subject'],
      topic: data['topic'],
      date: DateTime.parse(data['date']),
      duration: data['duration'],
      isCompleted: data['isCompleted'],
    );
  }

  // Firestore CRUD functions
  static final _collection = FirebaseFirestore.instance.collection('studyPlans');

  static Future<void> createStudyPlan(StudyPlan studyPlan) async {
    await _collection.add(studyPlan.toMap());
  }

  static Stream<List<StudyPlan>> readStudyPlans() {
    return _collection.orderBy('date').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => StudyPlan.fromFirestore(doc)).toList();
    });
  }

  static Future<void> updateStudyPlan(String studyPlanId, Map<String, dynamic> updates) async {
    await _collection.doc(studyPlanId).update(updates);
  }

  static Future<void> deleteStudyPlan(String studyPlanId) async {
    await _collection.doc(studyPlanId).delete();
  }

  // CopyWith method
  StudyPlan copyWith({
    String? id,
    String? subject,
    String? topic,
    DateTime? date,
    int? duration,
    bool? isCompleted,
  }) {
    return StudyPlan(
      id: id ?? this.id,
      subject: subject ?? this.subject,
      topic: topic ?? this.topic,
      date: date ?? this.date,
      duration: duration ?? this.duration,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
