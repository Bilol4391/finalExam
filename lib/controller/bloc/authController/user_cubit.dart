import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:x_pay/controller/bloc/authController/user_state.dart';
import 'package:x_pay/controller/localeStore/userId.dart';
import 'package:x_pay/model/user_model.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserState());
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  signIn(String name, String phone, String password) {
    firestore.collection("users").add(UserModel(
            username: name,
            password: password,
            phone: phone,
            docId: firestore.collection("users").doc().id,
            name: name,
            email: '',
            favourite: '')
        .toJson());
  }

  // getUser() async {
  //   var res = await firestore.collection("users").where("").get();
  //   List<UserModel> user = [];
  //   for (var element in res.docs) {
  //     user.add(UserModel.fromJson(element.data()));
  //   }
  //   emit(state.copyWith(listOfUserInfo: user));
  // }

  loginGoogle(VoidCallback onSuccess) async {
    emit(state.copyWith(isGoogleLoading: true));
    GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser?.authentication != null) {
      GoogleSignInAuthentication? googleAuth = await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userObj =
          await FirebaseAuth.instance.signInWithCredential(credential);
      debugPrint("${userObj.additionalUserInfo?.isNewUser}");
      if (userObj.additionalUserInfo?.isNewUser ?? true) {
        // sing in
        firestore
            .collection("users")
            .add(UserModel(
                    name: userObj.user?.displayName ?? "",
                    username: userObj.user?.displayName ?? "",
                    password: userObj.user?.uid ?? "",
                    email: userObj.user?.email ?? "",
                    phone: userObj.user?.phoneNumber ?? "",
                    avatar: userObj.user?.photoURL ?? "",
                    favourite: '')
                .toJson())
            .then((value) async {
          await LocaleStore.setId(value.id);
          onSuccess();
          googleSignIn.signOut();
        });
      } else {
        // sing up
        var res = await firestore
            .collection("users")
            .where("email", isEqualTo: userObj.user?.email)
            .get();

        if (res.docs.isNotEmpty) {
          await LocaleStore.setId(res.docs.first.id);
          onSuccess();
        }
      }
    }

    emit(state.copyWith(isGoogleLoading: false));
  }

  loginFacebook(VoidCallback onSuccess) async {
    emit(state.copyWith(isFacebookLoading: true));
    final fb = FacebookLogin();
    final user = await fb.logIn(permissions: [
      FacebookPermission.email,
      FacebookPermission.publicProfile
    ]);
    if (user.status == FacebookLoginStatus.success) {
      final OAuthCredential credential =
          FacebookAuthProvider.credential(user.accessToken?.token ?? "");

      final userObj =
          await FirebaseAuth.instance.signInWithCredential(credential);
      if (userObj.additionalUserInfo?.isNewUser ?? true) {
        // sing in
        firestore
            .collection("users")
            .add(UserModel(
              name: userObj.user?.displayName ?? "",
              username: userObj.user?.displayName ?? "",
              password: userObj.user?.uid ?? "",
              email: userObj.user?.email ?? "",
              phone: userObj.user?.phoneNumber ?? "",
              avatar: userObj.user?.photoURL ?? "",
              favourite: '',
            ).toJson())
            .then((value) async {
          await LocaleStore.setId(value.id);
          onSuccess();
        });
      } else {
        // sing up
        var res = await firestore
            .collection("users")
            .where("email", isEqualTo: userObj.user?.email)
            .get();

        if (res.docs.isNotEmpty) {
          await LocaleStore.setId(res.docs.first.id);
          onSuccess();
        }
      }
    }

    emit(state.copyWith(isFacebookLoading: false));
  }
}
