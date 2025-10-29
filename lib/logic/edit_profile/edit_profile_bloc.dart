import 'dart:io';
import 'package:bloc_project/core/navigation/navigation_service.dart';
import 'package:bloc_project/data/models/get_user_model.dart';
import 'package:bloc_project/logic/edit_profile/edit_profile_event.dart';
import 'package:bloc_project/logic/edit_profile/edit_profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  late ImagePicker picker = ImagePicker();
  EditProfileBloc() : super(EditProfileState.initial()) {
    on<FetchProfileData>((event, emit) {
      emit(
        state.copyWith(
          userModel: event.userModel,
          email: event.userModel.email,
          name: event.userModel.name,
          phone: event.userModel.phone,
          address: event.userModel.address,
        ),
      );
    });
    on<UpdateProfileData>(_updateProfileData);
    on<ChangeEmail>((event, emit) {
      emit(state.copyWith(email: event.email));
    });
    on<ChangeName>((event, emit) {
      emit(state.copyWith(name: event.name));
    });
    on<ChangePhone>((event, emit) {
      emit(state.copyWith(phone: event.phone));
    });
    on<ChangeAddress>((event, emit) {
      emit(state.copyWith(address: event.address));
    });

    on<PickImageFormCamera>(_PickFromCameraBloc);

    on<PickImageFormGallery>(_PickFromGalleryBloc);
  }

  Future<void> _PickFromGalleryBloc(
    PickImageFormGallery event,
    Emitter<EditProfileState> emit,
  ) async {
    try {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        emit(state.copyWith(selectedImage: File(image.path)));
        await Future.delayed(const Duration(milliseconds: 200));
        NavigationService.navigatorKey.currentState!.pop();
      }
    } catch (e) {
      print("image file error ${e}");
    }
  }

  Future<void> _PickFromCameraBloc(
    PickImageFormCamera event,
    Emitter<EditProfileState> emit,
  ) async {
    try {
      final XFile? image = await picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        emit(state.copyWith(selectedImage: File(image.path)));
        await Future.delayed(const Duration(milliseconds: 200));
        NavigationService.navigatorKey.currentState!.pop();
      }
    } catch (e) {
      print("error in file");
    }
  }

  // void _updateProfileData(
  //   UpdateProfileData event,
  //   Emitter<EditProfileState> emit,
  // ) async {
  //   emit(
  //     state.copyWith(isSubmitting: true, isFailure: false, isSuccess: false),
  //   );
  //
  //   await Future.delayed(const Duration(seconds: 2));
  //   emit(
  //     state.copyWith(
  //       userModel: UserModel(
  //         id: state.userModel!.id,
  //         name: state.name,
  //         email: state.email,
  //         phone: state.phone,
  //         address: state.address,
  //         image: state.selectedImage?.path,
  //       ),
  //     ),
  //   );
  //   emit(
  //     state.copyWith(isSubmitting: false, isFailure: false, isSuccess: true),
  //   );
  //   NavigationService.navigatorKey.currentState!.pop();
  // }

  Future<void> _updateProfileData(UpdateProfileData event, Emitter<EditProfileState> emit) async {

    if (state.userModel == null) {
      print("⚠️ Cannot update — userModel is null");
      return;
    }

    emit(state.copyWith(isSubmitting: true, isFailure: false, isSuccess: false));


    await Future.delayed(const Duration(seconds: 2));

    final updatedUser = state.userModel!.copyWith(
      name: state.name,
      email: state.email,
      phone: state.phone,
      address: state.address,
      image: state.selectedImage?.path ?? state.userModel!.image,
    );

    emit(state.copyWith(
      userModel: updatedUser,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    ));

    NavigationService.navigatorKey.currentState!.pop();
  }
}
