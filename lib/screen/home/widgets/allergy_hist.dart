import 'package:flutter/material.dart';

class AllergyHist extends StatelessWidget {
  final List<String> hist;
  AllergyHist(this.hist, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('藥物過敏史'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: hist.map((h) => Text(h)).toList(),
        // child: ListView.builder(
        //   itemCount: hist.length,
        //   itemBuilder: (context, index) => ListTile(title: Text(hist[index])),
        // ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("cancel"),
        )
      ],
    );
  }
}
