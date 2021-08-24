import 'widgets/prescription_view.dart';

class Prescription {
  final bool isNHI;
  final String medName;
  final String dailyDose;
  final String dailyAmount;
  final String totalAmount;
  final String freq;
  final PscUsage usage;
  final PscUnit unit;
  final String? others;

  Prescription({
    required this.isNHI,
    required this.medName,
    required this.dailyDose,
    required this.dailyAmount,
    required this.totalAmount,
    required this.freq,
    required this.usage,
    required this.unit,
    this.others,
  });

  @override
  String toString() {
    List temp = [
      this.isNHI,
      this.medName,
      this.dailyDose,
      this.dailyAmount,
      this.totalAmount,
      this.freq,
      this.usage,
      this.unit
    ];
    return temp.toString();
  }
  // String hash(){
  //   this.
  // }
  Prescription changeMedName(String newMedName) {
    return Prescription(
      isNHI: this.isNHI,
      medName: newMedName,
      dailyDose: this.dailyDose,
      dailyAmount: this.dailyAmount,
      totalAmount: this.totalAmount,
      freq: this.freq,
      usage: this.usage,
      unit: this.unit,
      others: this.others,
    );
  }
}

// psc.changeMedName("xanax")
