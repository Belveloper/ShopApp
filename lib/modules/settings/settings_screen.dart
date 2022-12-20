import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/controllers/Profile/cubit/cubit.dart';
import 'package:shopapp/controllers/Profile/cubit/states.dart';

import '../../components/components.dart';
import '../../constants/constants.dart';
import '../../controllers/Login/cubit/cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    var cubit = ProfileCubit.get(context);
    nameController.text = cubit.profileModel!.data!.name!;
    phoneController.text = cubit.profileModel!.data!.phone!;

    emailController.text = cubit.profileModel!.data!.email!;

    return BlocConsumer<ProfileCubit, ProfileStates>(
      listener: (context, state) {
        if (state is ProfileUpdateInformationsSuccesState) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'UPDATE YOUR PROFILE',
                      style: defaultTitleTextStyle.copyWith(
                          fontSize: 30, color: Colors.black),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                      // isEnabled: false,
                      initalValue: cubit.profileModel!.data!.name!,
                      onSubmit: (value) {
                        if (formKey.currentState!.validate()) {
                          // print(emailController.text);
                          ShopLoginCubit.get(context).userLogin(
                            email: emailController.text.trim(),
                            password: nameController.text.trim(),
                          );
                        }
                      },
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'Name must not be empty';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        nameController.text = value;
                      },
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      label: 'Name',
                      prefixIcon: Icons.person_outline,
                      style: defaultTitleTextStyle.copyWith(
                          color: Colors.black, fontWeight: FontWeight.w300),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    defaultFormField(
                      initalValue: cubit.profileModel!.data!.email!,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'Email must not be empty';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        emailController.text = value;
                      },
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      label: 'Email',
                      prefixIcon: Icons.email_outlined,
                      style: defaultTitleTextStyle.copyWith(
                          color: Colors.black, fontWeight: FontWeight.w300),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                      //  isEnabled: false,
                      initalValue: cubit.profileModel!.data!.phone!,
                      onSubmit: (value) {
                        if (formKey.currentState!.validate()) {
                          // print(emailController.text);
                          ShopLoginCubit.get(context).userLogin(
                            email: emailController.text.trim(),
                            password: nameController.text.trim(),
                          );
                        }
                      },
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'Phone must not be empty';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        phoneController.text = value;
                      },
                      controller: phoneController,
                      keyboardType: TextInputType.number,
                      label: 'Phone',
                      prefixIcon: Icons.phone_outlined,
                      style: defaultTitleTextStyle.copyWith(
                          color: Colors.black, fontWeight: FontWeight.w300),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: ConditionalBuilder(
                        condition: true,
                        builder: (context) => Container(
                          width: double.infinity,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: kDefaultOrangeColor,
                          ),
                          child: MaterialButton(
                            onPressed: (() {
                              if (formKey.currentState!.validate()) {
                                print(emailController.text);
                                cubit.updateProfileInformations(
                                    nameController.text,
                                    emailController.text,
                                    phoneController.text);
                              }
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                backgroundColor: Colors.green.shade200,
                                content: const Text('Profile Updated'),
                              ));
                            }),
                            child: Text(
                              'Submit',
                              style: defaultTitleTextStyle.copyWith(
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        fallback: (BuildContext context) => Center(
                          child: defaultLoadingIndicator(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
