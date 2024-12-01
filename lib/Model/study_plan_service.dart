import 'package:cloud_firestore/cloud_firestore.dart';
import 'study_plan.dart';

class StudyPlanService {
  static final _studyPlanCollection = FirebaseFirestore.instance.collection('studyPlans');

  // Create or Update StudyPlan
  static Future<void> saveStudyPlan(StudyPlan studyPlan) async {
    if (studyPlan.id == null) {
      // If no ID exists, create a new document
      await _studyPlanCollection.add(studyPlan.toMap());
    } else {
      // If ID exists, update the existing document
      await _studyPlanCollection.doc(studyPlan.id).update(studyPlan.toMap());
    }
  }

  // Fetch all study plans sorted by date
  static Stream<List<StudyPlan>> fetchStudyPlans() {
    return _studyPlanCollection.orderBy('date').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => StudyPlan.fromFirestore(doc)).toList();
    });
  }

  // Delete StudyPlan
  static Future<void> deleteStudyPlan(String studyPlanId) async {
    await _studyPlanCollection.doc(studyPlanId).delete();
  }
}
