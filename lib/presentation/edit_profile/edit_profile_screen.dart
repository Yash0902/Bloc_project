import 'dart:io';

import 'package:bloc_project/core/colors/colors.dart';
import 'package:bloc_project/core/constants/icons_constant.dart';
import 'package:bloc_project/core/constants/image_constants.dart';
import 'package:bloc_project/core/constants/length.dart';
import 'package:bloc_project/core/constants/string_constants.dart';
import 'package:bloc_project/core/navigation/navigation_service.dart';
import 'package:bloc_project/core/themes/app_text_style.dart';
import 'package:bloc_project/core/validators/input_validators.dart';
import 'package:bloc_project/core/widgets/common_widgets.dart';
import 'package:bloc_project/data/models/get_user_model.dart';
import 'package:bloc_project/logic/edit_profile/edit_profile_bloc.dart';
import 'package:bloc_project/logic/edit_profile/edit_profile_event.dart';
import 'package:bloc_project/logic/edit_profile/edit_profile_state.dart';
import 'package:bloc_project/logic/login/login_bloc.dart';
import 'package:bloc_project/logic/login/login_event.dart';
import 'package:bloc_project/logic/login/login_state.dart';
import 'package:bloc_project/logic/person/person_bloc.dart';
import 'package:bloc_project/logic/person/person_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfileScreen extends StatefulWidget {
  final UserModel userModel;
  const EditProfileScreen({super.key, required this.userModel});
  @override
  State<EditProfileScreen> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<EditProfileBloc>().add(FetchProfileData(widget.userModel));
    emailController.text = widget.userModel.email ?? '';
    nameController.text = widget.userModel.name ?? '';
    phoneController.text = widget.userModel.phone ?? '';
  }

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    phoneController.dispose();

    super.dispose();
  }

  void _showImagePickerSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors.grey,
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Wrap(
            children: [
              Center(
                child: Container(
                  height: 5,
                  width: 50,
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.photo, color: Colors.blue),
                title: const Text("Choose from Gallery"),
                onTap: () {
                  context.read<EditProfileBloc>().add(PickImageFormGallery());
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Colors.green),
                title: const Text("Take a Photo"),
                onTap: () {
                  context.read<EditProfileBloc>().add(PickImageFormCamera());
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditProfileBloc, EditProfileState>(
      listener: (context, state) {
        if (state.isSuccess) {
          context.read<PersonBloc>().add(PersonDataUpdate(state.userModel!));
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.backGroundColor,
        resizeToAvoidBottomInset: true,
        appBar: CommonWidgets.appBar(title: StringConstants.editProfile),
        body: BlocBuilder<EditProfileBloc, EditProfileState>(
          builder: (context, state) {
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(ImageConstants.imgBg),
                  fit: BoxFit.cover,
                ),
              ),
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.w,
                    vertical: 10.h,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CommonWidgets.verticalSpace(height: 20),

                        GestureDetector(
                          onTap: _showImagePickerSheet,
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage: state.selectedImage != null
                                ? FileImage(state.selectedImage!)
                                : FileImage(File(widget.userModel.image!)),
                          ),
                        ),
                        CommonWidgets.verticalSpace(height: 20),

                        CommonWidgets.commonTextField(
                          controller: nameController,
                          validator: InputValidators.validateName,
                          hintText: StringConstants.enterUserName,
                          labelText: StringConstants.userName,
                          keyboardType: TextInputType.name,
                          onChanged: (value) => context
                              .read<EditProfileBloc>()
                              .add(ChangeName(value)),
                        ),

                        CommonWidgets.commonTextField(
                          controller: emailController,
                          validator: InputValidators.validateEmail,
                          hintText: StringConstants.enterEmail,
                          labelText: StringConstants.email,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) => context
                              .read<EditProfileBloc>()
                              .add(ChangeEmail(value)),
                        ),

                        CommonWidgets.commonTextField(
                          enable: false,
                          controller: phoneController,
                          validator: InputValidators.validatePhone,
                          hintText: StringConstants.enterPhone,
                          labelText: StringConstants.phone,
                          keyboardType: TextInputType.phone,
                          onChanged: (value) => context
                              .read<EditProfileBloc>()
                              .add(ChangePhone(value)),
                        ),

                        CommonWidgets.verticalSpace(height: 30),

                        CommonWidgets.customBackgroundFrame(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<EditProfileBloc>().add(
                                UpdateProfileData(),
                              );
                            }
                          },
                          context: context,
                          showLoading: state.isSubmitting,
                          width: AppLength.screenFullWidth(),
                          child: Text(
                            StringConstants.update,
                            style: AppTextStyle.titleStyle16bw,
                          ),
                        ),
                        CommonWidgets.verticalSpace(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
