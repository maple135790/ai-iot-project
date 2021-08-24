class Patient {
  final String name;
  final String allergy;
  final String age;
  final String height;
  final String weight;
  final String id;

  Patient({
    required this.name,
    required this.allergy,
    required this.age,
    required this.height,
    required this.weight,
    required this.id,
  });
}

List<Patient> demoPatList = [
  Patient(
    name: 'Patient_one',
    allergy: 'Ultracet',
    age: '18',
    height: '180',
    weight: '80',
    id: "001",
  ),
  Patient(
    name: 'Patient_two',
    allergy: 'Novamin',
    age: '75',
    height: '170',
    weight: '60',
    id: "002",
  ),
  Patient(
    name: 'Patient_three',
    allergy: 'Xanax',
    age: '45',
    height: '175',
    weight: '75',
    id: "003",
  ),
];
