import 'package:flutter/material.dart';
import 'package:journal/services/journal_service.dart';

import '../../helpers/weekday.dart';
import '../../models/journal.dart';

class AddJournalScreen extends StatelessWidget {
  final Journal journal;
  AddJournalScreen({super.key, required this.journal});
  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${WeekDay(journal.createdAt.weekday).long.toLowerCase()}, ${journal.createdAt.day}  |  ${journal.createdAt.month}  |  ${journal.createdAt.year}"),
        actions: [
          IconButton(
              onPressed: (){
                registerJournal(context);
              },
              icon: Icon(Icons.check)
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: TextField(
          controller: _contentController,
          keyboardType: TextInputType.multiline,
          style: TextStyle(fontSize: 24),
          expands: true,
          minLines: null,
          maxLines: null,
        ),
      ),
    );
  }

  void registerJournal(BuildContext context) async {
    String content = _contentController.text;
    journal.content = content;
    JournalService service = JournalService();
    bool result = await service.register(journal);
    Navigator.pop(context, result);
  }
}
