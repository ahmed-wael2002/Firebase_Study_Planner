import 'package:flutter/material.dart';
import 'package:lab_assessment_3/View/study_plan_dialog.dart';
import 'package:lab_assessment_3/View/study_plan_widget.dart';
import '../Model/study_plan.dart';
import '../Model/study_plan_service.dart';

class StudyPlanScreen extends StatefulWidget {
  const StudyPlanScreen({super.key});

  @override
  State<StudyPlanScreen> createState() => _StudyPlanScreenState();
}

class _StudyPlanScreenState extends State<StudyPlanScreen> {
  String _filter = 'All'; // Filter: Upcoming, Specific Subject, All
  String _sortBy = 'Date'; // Sort by: Date or Subject

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Study Plans'),
        actions: [
          Container(
            padding: const EdgeInsets.all(6.0),
            margin: const EdgeInsets.all(6.0),
            child: Row(
              children: [
                PopupMenuButton<String>(
                  child: const Icon(Icons.sort),
                  onSelected: (value) => setState(() => _sortBy = value),
                  itemBuilder: (context) => const [
                    PopupMenuItem(value: 'Date', child: Text('Sort by Date')),
                    PopupMenuItem(value: 'Subject', child: Text('Sort by Subject')),
                  ],
                ),
                const SizedBox(width: 8.0),
                PopupMenuButton<String>(
                  child: const Icon(Icons.filter_alt),
                  onSelected: (value) => setState(() => _filter = value),
                  itemBuilder: (context) => const [
                    PopupMenuItem(value: 'All', child: Text('Show All')),
                    PopupMenuItem(value: 'Upcoming', child: Text('Upcoming')),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
      body: StreamBuilder<List<StudyPlan>>(
        stream: StudyPlanService.fetchStudyPlans(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No study plans available.'));
          }

          // Filter the data
          List<StudyPlan> studyPlans = snapshot.data!;
          if (_filter == 'Upcoming') {
            studyPlans = studyPlans.where((plan) => plan.date.isAfter(DateTime.now()) && !plan.isCompleted).toList();
          } else if (_filter != 'All') {
            studyPlans = studyPlans.where((plan) => plan.subject == _filter).toList();
          }

          // Sort the data
          if (_sortBy == 'Date') {
            studyPlans.sort((a, b) => a.date.compareTo(b.date));
          } else if (_sortBy == 'Subject') {
            studyPlans.sort((a, b) => a.subject.compareTo(b.subject));
          }

          return ListView.builder(
            itemCount: studyPlans.length,
            itemBuilder: (context, index) {
              final studyPlan = studyPlans[index];
              return GestureDetector(
                onTap: () => _showStudyPlanDialog(context, studyPlan), // Show the dialog on tap
                child: StudyPlanWidget(
                  studyPlan: studyPlan,
                  onToggleComplete: (value) {
                    StudyPlanService.saveStudyPlan(
                      studyPlan.copyWith(isCompleted: value ?? false),
                    );
                  },
                  onDelete: () {
                    StudyPlanService.deleteStudyPlan(studyPlan.id!);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showStudyPlanDialog(context, null), // Show dialog to add a new study plan
        child: const Icon(Icons.add),
      ),
    );
  }

  // Show dialog for creating/updating study plans
  void _showStudyPlanDialog(BuildContext context, StudyPlan? studyPlan) {
    showDialog(
      context: context,
      builder: (context) => StudyPlanDialog(studyPlan: studyPlan),
    );
  }
}
