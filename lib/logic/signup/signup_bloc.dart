import 'dart:io';

import 'package:bloc_project/core/navigation/navigation_service.dart';
import 'package:bloc_project/core/utils/app_image_picker.dart';
import 'package:bloc_project/core/validators/input_validators.dart';
import 'package:bloc_project/data/models/get_user_model.dart';
import 'package:bloc_project/logic/signup/signup_event.dart';
import 'package:bloc_project/logic/signup/signup_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  late ImagePicker picker = ImagePicker();
  SignUpBloc() : super(SignUpState.initial()) {
    on<UserNameChange>((event, emit) {
      print(event.userName);
      emit(state.copyWith(userName: event.userName));
    });
    on<PhoneChange>((event, emit) {
      print(event.phone);
      emit(state.copyWith(phone: event.phone));
    });
    on<EmailChange>((event, emit) {
      emit(state.copyWith(email: event.email));
    });
    on<PasswordChange>((event, emit) {
      emit(state.copyWith(password: event.password));
    });
    on<CnfPasswordChange>((event, emit) {
      emit(state.copyWith(cnfPassword: event.cnfPassword));
    });
    on<PickUserProfile>((event, emit) async {
      File? selectImage = await AppImagePickerAndCropper.pickImage();
      if (selectImage != null) {
        emit(state.copyWith(userProfile: selectImage));
      }
    });
    on<ClickOnSignUpButton>((event, emit) async {
      emit(
        state.copyWith(isFailure: false, isSubmitting: true, isSuccess: false),
      );
      try {
        if (state.userName.isEmpty ||
            state.email.isEmpty ||
            state.phone.isEmpty) {
          emit(
            state.copyWith(
              isFailure: true,
              isSubmitting: false,
              error: "Missing fields",
            ),
          );
          print(" Missing fields");
          return;
        }

        final bool exist = state.users.any((u) => u.email == state.email);
        if (exist) {
          emit(
            state.copyWith(
              isFailure: true,
              isSubmitting: false,
              error: "User already exists with email",
            ),
          );
          print("User already exists with email: ${state.email}");
          return;
        }

        if (state.password != state.cnfPassword) {
          emit(
            state.copyWith(
              isFailure: true,
              isSubmitting: false,
              error: "Passwords do not match",
            ),
          );
          print("Passwords do not match");
          return;
        }

        final newUser = UserModel(
          image: state.userProfile?.path,
          name: state.userName,
          email: state.email,
          phone: state.phone,
          password: state.password,
        );

        final updatedUsers = [...state.users, newUser];

        emit(
          state.copyWith(
            users: updatedUsers,
            isSubmitting: false,
            isSuccess: true,
            isFailure: false,
          ),
        );

        print("✅ All registered users:");
        print(updatedUsers.map((u) => u.toJson()).toList());

        NavigationService.navigatorKey.currentState!.pop();
      } catch (e) {
        print("Error: $e");
        emit(
          state.copyWith(
            isFailure: true,
            isSubmitting: false,
            isSuccess: false,
          ),
        );
      }
    });
    on<PickImageFormCamera>(_PickFromCameraBloc);
    on<PickImageFormGallery>(_PickFromGalleryBloc);
  }

  Future<void> _PickFromGalleryBloc(
      PickImageFormGallery event,
      Emitter<SignUpState> emit,
      ) async {
    try {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        emit(state.copyWith(userProfile: File(image.path)));
        await Future.delayed(const Duration(milliseconds: 200));
        NavigationService.navigatorKey.currentState!.pop();
      }
    } catch (e) {
      print("image file error ${e}");
    }
  }

  Future<void> _PickFromCameraBloc(
      PickImageFormCamera event,
      Emitter<SignUpState> emit,
      ) async {
    try {
      final XFile? image = await picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        emit(state.copyWith(userProfile: File(image.path)));
        await Future.delayed(const Duration(milliseconds: 200));
        NavigationService.navigatorKey.currentState!.pop();
      }
    } catch (e) {
      print("error in file");
    }
  }

}
