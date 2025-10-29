import 'dart:io';
import 'package:equatable/equatable.dart';

import '../../data/models/get_user_model.dart';

class EditProfileState extends Equatable{
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final String email;
  final String name;
  final String phone;
  final String address;
  final File? selectedImage;
  final UserModel? userModel;
   const EditProfileState({required this.userModel ,
     required this.email,required this.name,required this.phone,required this.address
     ,required this.isSubmitting,required this.isSuccess,required this.isFailure,required this.selectedImage
   });


   factory EditProfileState.initial(){
     return EditProfileState(
         selectedImage: null,
         userModel: null,
         email: '',
         name: '',
         phone: '',
         address: '',
         isSubmitting: false,
         isSuccess: false,
         isFailure: false
     );
   }

   EditProfileState copyWith({File? selectedImage, UserModel? userModel,String? email,String? name,String? phone,String? address,
   bool? isSubmitting,bool? isSuccess,bool? isFailure}){
     return EditProfileState(
         selectedImage: selectedImage ?? this.selectedImage,
         userModel: userModel??this.userModel,
         email: email??this.email,
         name: name??this.name,
         phone: phone?? this.phone,
         address: address??this.address,
         isSubmitting:isSubmitting?? this.isSubmitting,
         isSuccess: isSuccess?? this.isSuccess,
         isFailure: isFailure?? this.isFailure
     );

}


   @override
  List<Object?> get props => [selectedImage,userModel,email,name,phone,address,isSubmitting,isSuccess,isFailure];

}

