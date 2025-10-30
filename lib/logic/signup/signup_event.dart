import 'dart:io';

import 'package:bloc_project/data/models/get_user_model.dart';
import 'package:bloc_project/logic/login/login_state.dart';
import 'package:equatable/equatable.dart';

abstract class SignUpEvent extends Equatable{

  @override
  List<Object?> get props => [];
}

class PickUserProfile extends SignUpEvent{

}
class PressToRegister extends SignUpEvent{
    final List<UserModel> signupdata = const [];
}

class UserNameChange extends SignUpEvent{
  final String userName;
  UserNameChange(this.userName);
  @override
  List<Object?> get props => [userName];
}

class EmailChange extends SignUpEvent{
  final String email;
  EmailChange(this.email);
  @override
  List<Object?> get props => [email];
}

class PhoneChange extends SignUpEvent{
  final String phone;
  PhoneChange(this.phone);
  @override
  List<Object?> get props => [phone];
}

class PasswordChange extends SignUpEvent{
  final String password;
  PasswordChange(this.password);

  @override
  List<Object?> get props => [password];
}

class CnfPasswordChange extends SignUpEvent{
  final String cnfPassword;
  CnfPasswordChange(this.cnfPassword);
  @override
  List<Object?> get props => [cnfPassword];
}

class ClickOnSignUpButton extends SignUpEvent {
}


class ClickOnLoginButton extends SignUpEvent {
}


class PickImageFormGallery extends SignUpEvent{}

class PickImageFormCamera extends SignUpEvent{}