
import 'package:bloc_project/data/models/get_user_model.dart';

class UserRepository{
  List<UserModel> _userData = [];

  void signup(UserModel user){
     _userData.add(user);
  }

}