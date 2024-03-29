import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:qwiker_rider/core/widgets/custom_button.dart';
import 'package:qwiker_rider/features/profile/presentation/manager/user_data/user_data_cubit.dart';
import '../../../../../core/theaming/app_colors.dart';
import '../../../../../core/theaming/app_fonts.dart';
import '../../../auth/presentation/view/widgets/custom_text_form_field.dart';

class UserDataInputFieldsCompleate extends StatelessWidget {
  const UserDataInputFieldsCompleate(
      {super.key,
      required this.nameHint,
      required this.emailHint,
      required this.phoneHint,
      this.buttonOnPressd,
      required this.buttonText,
      required this.extraPhoneHint});

  final String nameHint;
  final String emailHint;
  final String phoneHint;
  final String extraPhoneHint;
  final String buttonText;
  final void Function()? buttonOnPressd;

  @override
  Widget build(BuildContext context) {
    var userDataCubit = BlocProvider.of<UserDataCubit>(context);
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: userDataCubit.formKey,
      child: Column(
        children: [
          CustomTextFormField(
            textController: userDataCubit.nameController,
            validator: (val) {
              if (val == null || val.isEmpty) {
                return 'Please enter your full Name';
              } else if (val.contains(RegExp(r'[0-9]'))) {
                return 'your name should not contains a number';
              } else {
                return null;
              }
            },
            onChanged: (val) {},
            onSave: (val) {},
            keyboardType: TextInputType.text,
            fillColor: AppColors.whaite,
            hintText: nameHint,
            hintStyle: AppFonts.poppinsRegularGray_14,
            borderRadius: 50.r,
            enabledBorderColor: AppColors.liteGray,
            focusBorderColor: AppColors.mainBlue,
            prefixIcon: const Icon(
              Icons.person_2,
            ),
          ),
          Gap(30.h),
          CustomTextFormField(
            textController: userDataCubit.emailController,
            validator: (val) {
              if (val == null || val.isEmpty) {
                return 'Please enter your email';
              } else if (!RegExp(
                      r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                  .hasMatch(val)) {
                return 'Please enter a verified email';
              } else {
                return null;
              }
            },
            onChanged: (val) {},
            onSave: (val) {},
            keyboardType: TextInputType.emailAddress,
            fillColor: AppColors.whaite,
            hintText: emailHint,
            hintStyle: AppFonts.poppinsRegularGray_14,
            borderRadius: 50.r,
            enabledBorderColor: AppColors.liteGray,
            focusBorderColor: AppColors.mainBlue,
            prefixIcon: const Icon(
              Icons.mail,
            ),
          ),
          Gap(30.h),
          InternationalPhoneNumberInput(
            hintText: extraPhoneHint,
            onInputChanged: (PhoneNumber number) {
              // print(number.phoneNumber);
            },
            onInputValidated: (bool value) {
              print(value);
            },
            selectorConfig: const SelectorConfig(
              selectorType: PhoneInputSelectorType.DROPDOWN,
              useEmoji: true,
            ),
            ignoreBlank: false,
            spaceBetweenSelectorAndTextField: 5,
            autoValidateMode: AutovalidateMode.onUserInteraction,
            selectorTextStyle: const TextStyle(color: Colors.black),
            initialValue: userDataCubit.number,
            textFieldController: userDataCubit.extraPhoneController,
            formatInput: true,
            keyboardType: const TextInputType.numberWithOptions(
                signed: true, decimal: true),
            inputBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(40.r))),
            onSaved: (PhoneNumber number) {},
          ),
          Gap(30.h),
          CustomButton(
            onPressed: buttonOnPressd,
            title: buttonText,
            backgroundColor: AppColors.mainBlue,
            titleStyle:
                AppFonts.poppinsMedium_18.copyWith(color: AppColors.whaite),
          ),
        ],
      ),
    );
  }
}
