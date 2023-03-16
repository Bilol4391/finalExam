
// class UserState{
//   bool googleload=true;
//  final UserModel? userModel;
//  final List<UserModel>? listOfUserInfo;
//   UserState({this.userModel, this.listOfUserInfo,this.googleload=true});
//
//  UserState copyWith({
//     bool? googleload,
//    UserModel? userModel,
//    List<UserModel>? listOfUserInfo,
// }) {
//    return UserState(
//      googleload: googleload ?? this.googleload,
//      userModel: userModel ?? this.userModel,
//      listOfUserInfo: listOfUserInfo ?? this.listOfUserInfo,
//    );
//  }
// }
class UserState {
  bool isGoogleLoading;
  bool isFacebookLoading;

  UserState({this.isFacebookLoading = false, this.isGoogleLoading = false});

  UserState copyWith({bool? isGoogleLoading, bool? isFacebookLoading}) {
    return UserState(
      isFacebookLoading: isFacebookLoading ?? this.isFacebookLoading,
      isGoogleLoading: isGoogleLoading ?? this.isGoogleLoading,
    );
  }
}
