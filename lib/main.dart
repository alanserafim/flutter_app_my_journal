import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:journal/screens/add_journal_screen/add_journal_screen.dart';
import 'package:journal/services/journal_service.dart';
import 'models/journal.dart';
import 'screens/home_screen/home_screen.dart';

void main() {
  runApp(const MyApp());

  JournalService service = JournalService();
  service.getAll();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Journal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
        appBarTheme: AppBarTheme(
          color: Colors.black,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.white,
          ),
          actionsIconTheme: IconThemeData(color: Colors.white),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        textTheme: GoogleFonts.bitterTextTheme(),
      ),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.light,
      initialRoute: "home",
      routes: {
        "home": (context) => const HomeScreen(),
      },
      onGenerateRoute: (settings){
        if(settings.name == "add-journal"){
          final Journal journal = settings.arguments as Journal;
          return MaterialPageRoute(builder: (context){
            return AddJournalScreen(journal: journal);
          });
        }
        return null;
      },
    );
  }
}
