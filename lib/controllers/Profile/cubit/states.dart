abstract class ProfileStates {}

class ProfileInitalState extends ProfileStates {}

class ProfileGetInformationsSuccesState extends ProfileStates {}

class ProfileGetInformationsLoadingState extends ProfileStates {}

class ProfileGetInformationsErrorState extends ProfileStates {
  final String error;
  ProfileGetInformationsErrorState(this.error);
}

class ProfileUpdateInformationsSuccesState extends ProfileStates {}

class ProfileUpdateInformationsLoadingState extends ProfileStates {}

class ProfileUpdateInformationsErrorState extends ProfileStates {
  final String error;
  ProfileUpdateInformationsErrorState(this.error);
}
