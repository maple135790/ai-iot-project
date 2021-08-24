import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intel_his/db/patient.dart';
import 'package:intel_his/popup/bzd_warning.dart';
import 'package:intel_his/popup/ddi.dart';
import 'package:intel_his/screen/home/prescription.dart';
import 'package:sqflite/sqflite.dart';

import 'bloc/home_bloc.dart';
import 'widgets/allergy_hist.dart';
import 'widgets/prescription_view.dart';

class DemoHome extends StatefulWidget {
  const DemoHome({Key? key}) : super(key: key);

  @override
  _DemoHomeState createState() => _DemoHomeState();
}

class _DemoHomeState extends State<DemoHome> {
  // var name = TextEditingController(); // read from db
  // var patientId = TextEditingController(); // read from db
  // var age = TextEditingController(); // read from db
  // var height = TextEditingController(); // read from db
  // var weight = TextEditingController(); // read from db
  final symptom = TextEditingController();
  late HomeBloc _bloc;
  List<String> drugResult = [];
  List<String> allergyHist = [];
  int curPatID = 0;
  bool isPregnant = false; // read from db
  String selectedDrug = '-';
  Widget recordTable() {
    // return DataTable(
    //   columns: [DataColumn(label: Container())],
    //   rows: [
    //     DataRow(cells: [DataCell(Container())])
    //   ],
    // );
    return Container(
      child: Placeholder(),
    );
  }

  @override
  void initState() {
    super.initState();
    allergyHist = [demoPatList[curPatID].allergy];
    // allergyHist = []; // read from db
    // allergyHist = ["Xanax", "Ultracet"]; // read from db
    _bloc = HomeBloc(allergyHist);
  }

  @override
  void dispose() {
    super.dispose();
    // name.dispose();
    // patientId.dispose();
    // age.dispose();
    // height.dispose();
    // weight.dispose();
    symptom.dispose();
  }

  @override
  Widget build(BuildContext context) {
    allergyHist = [demoPatList[curPatID].allergy];
    print(drugResult);
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocConsumer<HomeBloc, HomeState>(
        bloc: _bloc,
        listener: (context, state) async {
          print('listener: ');
          if (state is BzdDuplicationSent) {
            bool isConfirm = await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => BzdWarning(type: BzdWarningType.duplicated),
            );
            if (isConfirm) _bloc.add(AllergyCheckEvent(state.psc));
          } else if (state is BzdDDISent) {
            bool isConfirm = await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => BzdWarning(type: BzdWarningType.ddi),
            );
            if (isConfirm) _bloc.add(AllergyCheckEvent(state.psc));
          } else if (state is AllergyChecked) {
            if (state.hasAllergy) {
              String? newDrug = await showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => DrugAlert(state.psc),
              );
              if (newDrug != null) {
                Prescription newPsc = state.psc.changeMedName(newDrug);
                setState(() {
                  _bloc.psc = newPsc;
                });
              }
            } else {
              setState(() {
                _bloc.psc = state.psc;
              });
            }
          } else if (state is EPSAntidoteSent) {
            String? newDrug = await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => DrugAlert(
                state.psc,
                isEPSAlert: true,
              ),
            );
            if (newDrug != null) {
              Prescription newPsc = state.psc.changeMedName(newDrug);
              setState(() {
                _bloc.psc = newPsc;
              });
            } else {
              setState(() {
                _bloc.psc = state.psc;
              });
            }
          }
        },
        builder: (context, state) {

          return Scaffold(
            appBar: AppBar(
              title: Text("智慧醫囑系統"),
              actions: [
                IconButton(
                  onPressed: () {
                    // _bloc.add(ChangePatient());
                    setState(() {
                      _bloc.clearTable =true;
                      curPatID =
                          curPatID == demoPatList.length - 1 ? 0 : curPatID + 1;
                    });
                  },
                  icon: Icon(Icons.account_circle),
                )
              ],
            ),
            body: Container(
              padding: const EdgeInsets.fromLTRB(40, 20, 40, 10),
              child: Column(
                children: [
                  Row(children: [Text("基本資料", style: TextStyle(fontSize: 22))]),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 8,
                              child: TextField(
                                controller: TextEditingController(
                                    text: demoPatList[curPatID].name),
                                decoration: InputDecoration(labelText: "姓名"),
                                enabled: false,
                              ),
                            ),
                            SizedBox(width: 15),
                            Expanded(
                              child: TextField(
                                controller: TextEditingController(
                                    text: demoPatList[curPatID].id),
                                decoration: InputDecoration(labelText: "病歷號"),
                                enabled: false,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: TextEditingController(
                                    text: demoPatList[curPatID].age),
                                decoration: InputDecoration(labelText: "年齡"),
                                enabled: false,
                              ),
                            ),
                            const SizedBox(width: 30),
                            Expanded(
                              child: TextField(
                                controller: TextEditingController(
                                    text: demoPatList[curPatID].height),
                                decoration: InputDecoration(labelText: "身高"),
                                enabled: false,
                              ),
                            ),
                            const SizedBox(width: 30),
                            Expanded(
                              child: TextField(
                                controller: TextEditingController(
                                    text: demoPatList[curPatID].weight),
                                decoration: InputDecoration(labelText: "體重"),
                                enabled: false,
                              ),
                            ),
                            Expanded(
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                  allergyHist.length > 0
                                      ? Colors.red
                                      : Colors.grey,
                                )),
                                onPressed: allergyHist.length > 0
                                    ? () {
                                        showDialog(
                                          context: context,
                                          builder: (context) =>
                                              AllergyHist(allergyHist),
                                        );
                                      }
                                    : null,
                                child: Text('藥物過敏史'),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            color: Colors.grey[200],
                            child: TextField(
                              controller: symptom,
                              onChanged: (String? text) {},
                              maxLines: 5,
                              decoration: InputDecoration(
                                labelText: "症狀",
                                border: OutlineInputBorder(),
                              ),
                              enabled: true,
                            ),
                          ),
                        ),
                        PrescriptionView(
                          _bloc,
                          allergyHistory: allergyHist,
                        ),
                      ],
                    ),
                  ),
                  ButtonBar(
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: Text("送出"),
                      )
                    ],
                  ),
                  Row(children: [Text("用藥紀錄", style: TextStyle(fontSize: 22))]),
                  Expanded(
                    child: recordTable(),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
