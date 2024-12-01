import 'package:flutter/material.dart';
import 'package:lab_assessment_3/Model/study_plan.dart';

class StudyPlanWidget extends StatelessWidget {
  final StudyPlan studyPlan; // StudyPlan object to display
  final void Function(bool?)? onToggleComplete; // Callback to handle checkbox toggling
  final void Function()? onDelete; // Callback to handle delete action

  const StudyPlanWidget({
    required this.studyPlan,
    this.onToggleComplete,
    this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3, // Adds subtle shadow for a modern look
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: Checkbox(
          value: studyPlan.isCompleted,
          onChanged: onToggleComplete,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5), // Modern rounded checkbox
          ),
        ),
        title: Text(
          studyPlan.subject,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: studyPlan.isCompleted ? Colors.grey : Theme.of(context).colorScheme.primary,
            decoration: studyPlan.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Topic: ${studyPlan.topic}',
              style: TextStyle(
                fontSize: 14,
                color: studyPlan.isCompleted ? Colors.grey : Theme.of(context).colorScheme.secondary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Date: ${studyPlan.date.toLocal()}'.split('.')[0], // Formats the date
              style: TextStyle(
                fontSize: 14,
                color: studyPlan.isCompleted ? Colors.grey : Theme.of(context).colorScheme.secondary,
              ),
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete, // Use the callback to delete the StudyPlan
        ),
      ),
    );
  }
}
