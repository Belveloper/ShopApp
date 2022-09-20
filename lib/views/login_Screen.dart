import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/constants/constants.dart';
import 'package:shopapp/controllers/Login/cubit/states.dart';
import 'package:shopapp/views/register_scren.dart';

import '../controllers/Login/cubit/cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ShopLoginCubit>(
        create: (context) => ShopLoginCubit(),
        child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(),
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'LOGIN',
                            style: defaultTitleTextStyle.copyWith(
                                fontSize: 34, color: Colors.black),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          defaultFormField(
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'email must not be empty';
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
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          defaultFormField(
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'password must not be empty';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                passwordController.text = value;
                              },
                              controller: passwordController,
                              keyboardType: TextInputType.text,
                              label: 'Password',
                              suffixIcon:
                                  ShopLoginCubit.get(context).suffixIcon,
                              prefixIcon: Icons.lock_outline,
                              isPassword:
                                  ShopLoginCubit.get(context).passwordIsVisible,
                              suffixPressedFuncion: () {
                                ShopLoginCubit.get(context)
                                    .changePasswordVisibility();
                              }),
                          const SizedBox(
                            height: 30,
                          ),
                          Center(
                            child: Container(
                              width: double.infinity,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: kDefaultColor,
                              ),
                              child: ConditionalBuilder(
                                condition: state is! ShopLoginLoadinglState,
                                builder: (context) => MaterialButton(
                                  onPressed: (() {
                                    if (formKey.currentState!.validate()) {
                                      // print(emailController.text);
                                      ShopLoginCubit.get(context).userLogin(
                                          email: emailController.text,
                                          password: passwordController.text);
                                    }
                                  }),
                                  child: Text(
                                    'LOGIN',
                                    style: defaultTitleTextStyle.copyWith(
                                        color: Colors.white),
                                  ),
                                ),
                                fallback: (BuildContext context) =>
                                    const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Text('Don\'t have an account ?'),
                              defaultTextButton(
                                  onPressed: () {
                                    navigateTo(context, const RegisterScreen());
                                  },
                                  text: 'REGISTER'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
