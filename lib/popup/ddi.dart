import 'package:flutter/material.dart';
import 'package:intel_his/screen/home/prescription.dart';

import '../constant.dart';
import 'drug_caution.dart';

class DrugAlert extends StatefulWidget {
  final Prescription psc;
  final bool? isEPSAlert;

  DrugAlert(
    this.psc, {
    Key? key,
    this.isEPSAlert,
  }) : super(key: key);
  @override
  _DrugAlertState createState() => _DrugAlertState();
}

class _DrugAlertState extends State<DrugAlert> {
  String medSelection = "";

  @override
  Widget build(BuildContext context) {
    String _medName = widget.psc.medName;
    bool? _isEPSAlert = widget.isEPSAlert;
    List<Widget> substituteList = indications[_medName]!.map((subsMed) {
      return Card(
        child: ListTile(
          enabled: true,
          selected: medSelection == subsMed['name'],
          trailing: Icon(
            Icons.check_circle,
            color: medSelection == subsMed['name']
                ? Colors.green
                : Colors.grey[300],
          ),
          onTap: () async {
            if (cautions.containsKey(subsMed['name'])) {
              bool isConfirm = await showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => DrugCaution(subsMed['name']!),
              );
              if (isConfirm) {
                setState(() {
                  medSelection = subsMed['name']!;
                });
              }
            } else {
              setState(() {
                medSelection = subsMed['name']!;
              });
            }
          },
          title: Text(subsMed['name']!),
          subtitle: Text(subsMed['indication']!),
        ),
      );
    }).toList();
    List<Widget> _children = [
      Text(_isEPSAlert ?? false ? 'EPS encountered' : 'DDI detected'),
      Text(_isEPSAlert ?? false
          ? 'THese are EPS antidoses: '
          : 'These are substitute options:'),
    ];
    _children
      ..addAll(substituteList)
      ..add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(_isEPSAlert ?? false
                  ? "Use Novamin anyway"
                  : "Use allergy drug anyway"),
              Card(
                child: ListTile(
                  title: Text(_medName),
                  trailing: Icon(
                    Icons.check_circle,
                    color: medSelection == _medName
                        ? Colors.green
                        : Colors.grey[300],
                  ),
                  onTap: () {
                    setState(() {
                      medSelection = _medName;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      );

    return AlertDialog(
      title: Text(_isEPSAlert ?? false ? 'EPS Alert' : 'DDI Alert'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: _children,
      ),
      actions: [
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.red),
          ),
          onPressed: () {
            Navigator.of(context).pop(medSelection);
          },
          child: Text('confirm'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('cancel'),
        ),
      ],
    );
  }
}
