import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/controllers/Profile/cubit/states.dart';
import 'package:shopapp/models/Profile/update_profile_model.dart';
import 'package:shopapp/models/login/shop_login_model.dart';
import 'package:shopapp/webServices/endpoints/end_points.dart';
import 'package:shopapp/webServices/login_api/dio_helper.dart';
import 'package:shopapp/webServices/token.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(ProfileInitalState());

  static ProfileCubit get(context) => BlocProvider.of(context);

  ShopLoginModel? profileModel;
  bool? formFieldEnabled = false;

  void getProfileData() {
    formFieldEnabled = true;
    emit(ProfileGetInformationsLoadingState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      print('profile informations:');
      print(value.data['name']);
      profileModel = ShopLoginModel.fromJson(value.data);
      emit(ProfileGetInformationsSuccesState());
    }).onError((error, stackTrace) {
      print(error.toString());
      emit(ProfileGetInformationsErrorState(error.toString()));
    });
  }

  UpdateProfileModel? updateProfileModel;
  void updateProfileInformations(String? name, String? email, String? phone) {
    emit(ProfileUpdateInformationsLoadingState());
    DioHelper.putData(url: UPDATE_PROFILE, token: token, data: {
      'name': name,
      'email': email,
      'phone': phone,
    }).then((value) {
      print(value.data);
      updateProfileModel = UpdateProfileModel.fromJson(value.data);
      getProfileData();
      emit(ProfileUpdateInformationsSuccesState());
    }).onError((error, stackTrace) {
      emit(ProfileUpdateInformationsErrorState(error.toString()));
    });
  }
}
