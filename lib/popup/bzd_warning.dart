import 'package:flutter/material.dart';

enum BzdWarningType { duplicated, ddi }

class BzdWarning extends StatelessWidget {
  final BzdWarningType type;

  const BzdWarning({
    required this.type,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (this.type == BzdWarningType.duplicated) {
      return AlertDialog(
        title: Text("BZD warning"),
        content: Text("已有BZD 藥物\n是否確定要再次開立"),
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
    } else if (this.type == BzdWarningType.ddi) {
      return AlertDialog(
        title: Text("BZD warming"),
        content: Text("兩者藥物交互作用有可能\n產生不良反應，是否確定要開立"),
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
    } else {
      return ErrorWidget(Exception('not a type of BzdWarning'));
    }
  }
}
