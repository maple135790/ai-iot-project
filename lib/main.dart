import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
import 'package:sqlite3/sqlite3.dart';
import 'screen/home/demo_home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final database = await openDatabase('lib\db\medical databse.db');
  // final db =sqlite3.openInMemory();
  runApp(HIS());
}

class HIS extends StatelessWidget {
  // final Database database;

  const HIS();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: DemoHome(),
    );
  }
}
