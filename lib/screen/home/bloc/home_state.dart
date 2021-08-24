part of 'home_bloc.dart';

abstract class HomeState {
  const HomeState();
}

class HomeInitial extends HomeState {}

class AllergyChecked extends HomeState {
  final bool hasAllergy;
  final Prescription psc;

  const AllergyChecked(this.hasAllergy, this.psc);
}

class BzdDuplicationSent extends HomeState {
  final Prescription psc;

  const BzdDuplicationSent(this.psc);
}

class BzdDDISent extends HomeState {
  final Prescription psc;

  const BzdDDISent(this.psc);
}

class EPSAntidoteSent extends HomeState {
  final Prescription psc;

  const EPSAntidoteSent(this.psc);
}

class PatientChanged extends HomeState {

  PatientChanged();
}
