import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intel_his/popup/bzd_warning.dart';
import 'package:intel_his/screen/home/bloc/home_bloc.dart';
import 'package:intel_his/screen/home/prescription.dart';

import '../../../constant.dart';
import '../../../popup/ddi.dart';

enum PscUnit { Mg, g }
enum PscUsage { IV, IM, PO }

class PrescriptionView extends StatefulWidget {
  final List<String> allergyHistory;
  final HomeBloc bloc;

  PrescriptionView(
    this.bloc, {
    required this.allergyHistory,
    Key? key,
  }) : super(key: key);

  @override
  _PrescriptionViewState createState() => _PrescriptionViewState();
}

class _PrescriptionViewState extends State<PrescriptionView> {
  final List<String> colsTitle = [
    '查詢',
    '付',
    '藥品名稱',
    '日劑量',
    '頻率',
    '日份',
    '單位',
    '用法',
    '總量',
    '其他',
    '',
  ];
  List<Map<String, dynamic>> pscMeds = [];

  final medName = TextEditingController();
  final dailyDose = TextEditingController();
  final freq = TextEditingController();
  final dailyAmount = TextEditingController();
  final totalAmount = TextEditingController();
  final others = TextEditingController();
  List<Map<String, dynamic>> meds = [];
  Prescription? _psc;
  late HomeBloc _bloc;
  bool isNHI = true;
  bool hasBzd = false;
  PscUsage usage = PscUsage.PO;
  PscUnit unit = PscUnit.Mg;

  @override
  void initState() {
    super.initState();
    _bloc = widget.bloc;
    _bloc.add(Init());
    // if (widget.updatePsc ?? false) {
    //   updatePrescription();
    // }
  }

  @override
  void dispose() {
    super.dispose();
    medName.dispose();
    dailyDose.dispose();
    freq.dispose();
    dailyAmount.dispose();
    totalAmount.dispose();
    others.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _psc = _bloc.psc;
    updatePrescription();
    if (_bloc.clearTable) clearTable();
    checkBzd();

    Widget inputTextField(
      TextEditingController cont, {
      double? width,
      bool isRequired = true,
      bool needCapitalize = false,
    }) {
      return LimitedBox(
        child: Container(
          margin: EdgeInsets.all(4.0),
          width: width ?? 70,
          child: TextField(
            inputFormatters: needCapitalize ? [UpperCaseTextFormatter()] : [],
            controller: cont,
            onChanged: (s) {
              print(s);
            },
            decoration: InputDecoration(
              filled: true,
              isDense: true,
              border: InputBorder.none,
            ),
          ),
        ),
      );
    }

    DataRow inputRow = DataRow(
      cells: [
        DataCell(
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ),
        DataCell(
          ElevatedButton(
            onPressed: () {
              setState(() {
                isNHI = !isNHI;
              });
            },
            child: Text(isNHI ? '健' : '自'),
          ),
        ),
        DataCell(
          inputTextField(
            medName,
            width: 200,
            needCapitalize: true,
          ),
        ),
        DataCell(inputTextField(dailyDose)),
        DataCell(inputTextField(freq)),
        DataCell(inputTextField(dailyAmount)),
        DataCell(
          ElevatedButton(
            onPressed: () {
              int i = PscUnit.values.indexOf(unit);
              if (i == PscUnit.values.length - 1) i = -1;
              setState(() {
                unit = PscUnit.values[i + 1];
              });
            },
            child: Text(unit.toString().split('.').last),
          ),
        ),
        DataCell(
          ElevatedButton(
            onPressed: () {
              int i = PscUsage.values.indexOf(usage);
              if (i == PscUsage.values.length - 1) i = -1;
              setState(() {
                usage = PscUsage.values[i + 1];
              });
            },
            child: Text(usage.toString().split('.').last),
          ),
        ),
        DataCell(inputTextField(totalAmount)),
        DataCell(inputTextField(others, isRequired: false)),
        DataCell(
          ElevatedButton(
            onPressed: () async {
              Prescription psc = Prescription(
                dailyAmount: dailyAmount.text,
                dailyDose: dailyDose.text,
                freq: freq.text,
                isNHI: isNHI,
                medName: medName.text,
                totalAmount: totalAmount.text,
                unit: unit,
                usage: usage,
              );
              if (hasBzd && bzdList.contains(medName.text)) {
                _bloc.add(BzdDuplicationEvent(psc));
              } else if (hasBzd && medName.text == 'Ultracet') {
                _bloc.add(BzdDDIEvent(psc));
              } else if (medName.text == 'Novamin' && others.text == 'eps') {
                _bloc.add(EPSAntidote(psc));
              } else {
                _bloc.add(AllergyCheckEvent(psc));
              }
            },
            child: Text('Submit'),
          ),
        ),
      ],
    );
    List<DataRow> rows = [inputRow];
    rows.addAll(
      meds.map((med) {
        print(med);
        return DataRow(
          cells: [
            DataCell(
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {},
              ),
            ),
            DataCell(Text(med['payment'])),
            DataCell(Text(med['medName'])),
            DataCell(Text(med['dailyDose'])),
            DataCell(Text(med['freq'])),
            DataCell(Text(med['dailyAmount'])),
            DataCell(Text(med['unit'])),
            DataCell(Text(med['usage'])),
            DataCell(Text(med['totalAmount'] ?? '')),
            DataCell(Text(med['others'] ?? '')),
            DataCell(
              IconButton(
                icon: Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
                onPressed: () {
                  int target = med['hashCode'];
                  setState(() {
                    for (int i = 0; i < meds.length; i++) {
                      if (meds[i]['hashCode'] == target) {
                        meds.remove(meds[i]);
                        break;
                      }
                    }
                  });
                },
              ),
            ),
          ],
        );
      }).toList(),
    );
    return Expanded(
      child: DataTable(
        columns: colsTitle.map((t) => DataColumn(label: Text(t))).toList(),
        rows: rows,
        dataRowHeight: 40,
      ),
    );
  }

  void clearTable() {
    setState(() {
      meds.clear();
      _bloc.clearTable =false;
    });
  }

  void updatePrescription() {
    if (_psc != null)
      return setState(() {
        meds.add({
          "payment": _psc!.isNHI ? "健" : "自",
          "medName": _psc!.medName,
          "dailyDose": _psc!.dailyDose,
          "freq": _psc!.freq,
          "dailyAmount": _psc!.dailyAmount,
          "unit": _psc!.unit.toString().split('.').last,
          "usage": _psc!.usage.toString().split('.').last,
          "totalAmount": _psc!.totalAmount,
          "others": _psc!.others,
          'hashCode': _psc!.hashCode
        });
        isNHI = true;
        unit = PscUnit.Mg;
        usage = PscUsage.PO;
        medName.clear();
        dailyDose.clear();
        freq.clear();
        dailyAmount.clear();
        totalAmount.clear();
        others.clear();
        _bloc.psc = null;
      });
  }

  void checkBzd() {
    setState(() {
      hasBzd = false;
      for (Map med in meds) {
        if (bzdList.contains(med['medName'])) {
          hasBzd = true;
          break;
        }
      }
    });
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.length > 0
          ? newValue.text[0].toUpperCase() + newValue.text.substring(1)
          : "",
      selection: newValue.selection,
    );
  }
}
