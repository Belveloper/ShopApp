abstract class SearchStates {}

class SearchInitialState extends SearchStates {}

class SearchLoadingState extends SearchStates {}

class SearchgetDataSuccesState extends SearchStates {}

class SearchgetDataErrorState extends SearchStates {
  final String error;
  SearchgetDataErrorState(this.error);
}
