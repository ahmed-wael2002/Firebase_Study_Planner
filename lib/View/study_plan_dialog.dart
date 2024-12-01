import 'package:flutter/material.dart';
import 'package:lab_assessment_3/Model/study_plan.dart';

import '../Model/study_plan_service.dart';

class StudyPlanDialog extends StatefulWidget {
  final StudyPlan? studyPlan; // Existing StudyPlan for editing, null for new

  const StudyPlanDialog({this.studyPlan, super.key});

  @override
  State<StudyPlanDialog> createState() => _StudyPlanDialogState();
}

class _StudyPlanDialogState extends State<StudyPlanDialog> {
  final _formKey = GlobalKey<FormState>();
  late String _subject;
  late String _topic;
  late DateTime _date;
  late int _duration;

  @override
  void initState() {
    super.initState();

    // Initialize fields with existing studyPlan data or defaults
    _subject = widget.studyPlan?.subject ?? '';
    _topic = widget.studyPlan?.topic ?? '';
    _date = widget.studyPlan?.date ?? DateTime.now();
    _duration = widget.studyPlan?.duration ?? 0;
  }

  // Save StudyPlan to Firestore
  Future<void> _saveStudyPlan() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final studyPlan = StudyPlan(
        id: widget.studyPlan?.id, // Retain the ID if editing
        subject: _subject,
        topic: _topic,
        date: _date,
        duration: _duration,
        isCompleted: widget.studyPlan?.isCompleted ?? false,
      );

      await StudyPlanService.saveStudyPlan(studyPlan);
      Navigator.of(context).pop(); // Close the dialog
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.studyPlan == null ? 'Add Study Plan' : 'Edit Study Plan'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Subject Field
              TextFormField(
                initialValue: _subject,
                decoration: const InputDecoration(labelText: 'Subject'),
                validator: (value) => value == null || value.isEmpty ? 'Please enter a subject' : null,
                onSaved: (value) => _subject = value!,
              ),
              const SizedBox(height: 12),

              // Topic Field
              TextFormField(
                initialValue: _topic,
                decoration: const InputDecoration(labelText: 'Topic'),
                validator: (value) => value == null || value.isEmpty ? 'Please enter a topic' : null,
                onSaved: (value) => _topic = value!,
              ),
              const SizedBox(height: 12),

              // Date Picker
              TextButton.icon(
                icon: const Icon(Icons.calendar_today),
                label: Text('Select Date: ${_date.toLocal()}'.split(' ')[0]),
                onPressed: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: _date,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (selectedDate != null) {
                    setState(() => _date = selectedDate);
                  }
                },
              ),
              const SizedBox(height: 12),

              // Duration Field
              TextFormField(
                initialValue: _duration > 0 ? _duration.toString() : '',
                decoration: const InputDecoration(labelText: 'Duration (in minutes)'),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || int.tryParse(value) == null || int.parse(value) <= 0
                    ? 'Please enter a valid duration'
                    : null,
                onSaved: (value) => _duration = int.parse(value!),
              ),
            ],
          ),
        ),
      ),
      actions: [
        // Cancel Button
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        // Save Button
        ElevatedButton(
          onPressed: _saveStudyPlan,
          child: const Text('Save'),
        ),
      ],
    );
  }
}
