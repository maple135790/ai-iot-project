import 'package:flutter/material.dart';
import 'package:intel_his/constant.dart';

class DrugCaution extends StatelessWidget {
  final String medName;

  const DrugCaution(this.medName, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Caution"),
      content: Text(cautions[this.medName]! == ""
          ? "use with caution"
          : cautions[this.medName]!),
      actions: [
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.red),
          ),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: Text('confirm'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: Text('cancel'),
        ),
      ],
    );
  }
}
