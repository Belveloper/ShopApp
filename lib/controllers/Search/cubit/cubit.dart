import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/controllers/Search/cubit/states.dart';
import 'package:shopapp/models/Search/search_model.dart';
import 'package:shopapp/webServices/login_api/dio_helper.dart';
import 'package:shopapp/webServices/token.dart';

import '../../../webServices/endpoints/end_points.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;

  void search(String? searchText) {
    emit(SearchLoadingState());
    DioHelper.postData(url: SEARCH, token: token, data: {
      'text': searchText,
    }).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      print(searchModel!.data!.data![0].name);
      emit(SearchgetDataSuccesState());
    }).onError((error, stackTrace) {
      print(error.toString());
      emit(SearchgetDataErrorState(error.toString()));
    });
  }
}
