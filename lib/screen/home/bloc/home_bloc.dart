import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:intel_his/db/patient.dart';

import '../prescription.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final List allergyHistory;

  Prescription? psc;
  List<Patient> patList = demoPatList;
  bool clearTable =false;
  // Patient pat;

  HomeBloc(this.allergyHistory) : super(HomeInitial());

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is AllergyCheckEvent) {
      Prescription _psc = event.psc;
      bool hasAllergy =
          allergyHistory.map((hist) => hist).contains(_psc.medName);
      yield AllergyChecked(hasAllergy, _psc);
    } else if (event is BzdDuplicationEvent) {
      Prescription _psc = event.psc;
      yield BzdDuplicationSent(_psc);
    } else if (event is BzdDDIEvent) {
      Prescription _psc = event.psc;
      yield BzdDDISent(_psc);
    } else if (event is EPSAntidote) {
      Prescription _psc = event.psc;
      yield EPSAntidoteSent(_psc);
    } else if (event is ChangePatient) {
      yield PatientChanged();
    }
  }
}
