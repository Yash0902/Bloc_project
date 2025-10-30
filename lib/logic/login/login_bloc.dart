import 'package:bloc_project/core/navigation/navigation_service.dart';
import 'package:bloc_project/logic/login/login_event.dart';
import 'package:bloc_project/logic/login/login_state.dart';
import 'package:bloc_project/logic/signup/signup_bloc.dart';
import 'package:bloc_project/routes/app_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final SignUpBloc signUpBloc;
  LoginBloc(this.signUpBloc) : super(LoginState.initial()) {
    on<EmailChange>((event, emit) {
      emit(state.copyWith(email: event.email));
    });

    on<PasswordChange>((event, emit) {
      emit(state.copyWith(password: event.password));
    });

    on<ClickOnLoginButton>((event, emit) async {
      emit(
        state.copyWith(
          isFailure: false,
          isSubmitting: true,
          isSuccess: false,
        ),
      );


      final users = signUpBloc.state.users;

      try {

        final matchedUser = users.firstWhere(
              (u) => u.email == state.email && u.password == state.password,
        );

        // print("Logged in as: ${matchedUser.name}");

        emit(
          state.copyWith(
            isSubmitting: false,
            isSuccess: true,
            isFailure: false,
            userModel: matchedUser,
          ),
        );

       NavigationService.navigatorKey.currentState!.pushNamed(AppRoutes.bottomNav);
      } catch (e) {
        print("Login failed: Invalid credentials");

        emit(
          state.copyWith(
            isFailure: true,
            isSubmitting: false,
            isSuccess: false,

          ),
        );
      }
    });


    on<ClickOnSignUpButton>((event, emit) {
      NavigationService.pushNamed(AppRoutes.signup);
    });
  }
}
