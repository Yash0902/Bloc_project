import 'dart:io';

import 'package:bloc_project/data/models/get_user_model.dart';
import 'package:equatable/equatable.dart';

class SignUpState extends Equatable {
  final List<UserModel> users;
  final String userName;
  final String email;
  final String phone;
  final String password;
  final String cnfPassword;
  final File? userProfile;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final String error;

  const SignUpState({
    required this.users,
    required this.userName,
    required this.email,
    required this.phone,
    required this.password,
    required this.cnfPassword,
    required this.userProfile,
    required this.isSubmitting,
    required this.isSuccess,
    required this.isFailure,
    required this.error,
  });

  factory SignUpState.initial() {
    return SignUpState(
      users: [],
      userName: '',
      email: '',
      phone: '',
      password: '',
      cnfPassword: '',
      userProfile: null,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      error: '',
    );
  }

  SignUpState copyWith({
    List<UserModel>? users,
    String? userName,
    String? email,
    String? phone,
    String? password,
    String? cnfPassword,
    File? userProfile,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
    String? error,

  }) {
    return SignUpState(
      users: users ?? this.users,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      cnfPassword: cnfPassword ?? this.cnfPassword,
      userProfile: userProfile ?? this.userProfile,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [users, userName,email,phone, password,cnfPassword, userProfile,isSubmitting, isSuccess, isFailure,error];
}

