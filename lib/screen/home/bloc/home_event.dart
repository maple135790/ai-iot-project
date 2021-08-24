part of 'home_bloc.dart';

abstract class HomeEvent {
  const HomeEvent();
}

class AllergyCheckEvent extends HomeEvent {
  final Prescription psc;

  const AllergyCheckEvent(this.psc);
}

class BzdDuplicationEvent extends HomeEvent {
  final Prescription psc;

  const BzdDuplicationEvent(this.psc);
}

class BzdDDIEvent extends HomeEvent {
  final Prescription psc;

  const BzdDDIEvent(this.psc);
}

class EPSAntidote extends HomeEvent {
  final Prescription psc;

  const EPSAntidote(this.psc);
}

class ChangePatient extends HomeEvent {
  const ChangePatient();
}

class Init extends HomeEvent {
  const Init();
}
