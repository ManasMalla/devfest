import 'dart:developer';

import 'package:devfest_vizag/login/user_type.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  List<dynamic> dataOfRegistrants = [];
  bool shouldShowLoader = false;

  String firebaseVerificationID = "";
  int? _resendToken;
  String phoneNumber = "";

  bool isApplicationPending = true;

  UserRoles userRole = UserRoles.unknown;

  List<dynamic> uniqueOrganizations = [];
  List<dynamic> uniqueCities = [];
  setUserRole(UserRoles _) {
    userRole = _;
    notifyListeners();
  }

  showLoader() {
    shouldShowLoader = true;
    notifyListeners();
  }

  hideLoader() {
    shouldShowLoader = false;
    notifyListeners();
  }

  Future<void> onLoginUser(
      // GlobalKey<FormState> mobileFormKey,
      // TextEditingController phoneTextEditController,
      {
    required Function(String) onSuccessfulLogin,
    required Function(String) onError,
    required Function(String) showMessage,
    // required Function(Function(String)) navigateToOTPScreen,
  }) async {
    /*  var isFormReady = mobileFormKey.currentState?.validate() ?? false;
    if (isFormReady) {
      phoneNumber = phoneTextEditController.text;
      log("Trying to login user: ${phoneTextEditController.text}");
      try {
        await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: "+91${phoneTextEditController.text}",
          verificationCompleted:
              (PhoneAuthCredential phoneAuthCredential) async {
            onLoginWithCredential(
                phoneAuthCredential, onSuccessfulLogin, onError);
          },
          verificationFailed: (FirebaseAuthException exception) {
            onError(
                "Couldn't verify your phone number, Error: ${exception.message}");
            hideLoader();
          },
          codeSent: (String verificationId, int? resendToken) {
            firebaseVerificationID = verificationId;
            _resendToken = resendToken;
            showMessage("OTP sent successfully");
            //Navigate to OTP page
            navigateToOTPScreen((String otp) async {
              PhoneAuthCredential phoneAuthCredential =
                  PhoneAuthProvider.credential(
                      verificationId: verificationId, smsCode: otp);
              onLoginWithCredential(
                  phoneAuthCredential, onSuccessfulLogin, onError);
            });
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            firebaseVerificationID = verificationId;
            showMessage("OTP sent successfully");
            //Navigate to OTP page
            navigateToOTPScreen((String otp) async {
              PhoneAuthCredential phoneAuthCredential =
                  PhoneAuthProvider.credential(
                      verificationId: verificationId, smsCode: otp);
              onLoginWithCredential(
                  phoneAuthCredential, onSuccessfulLogin, onError);
            });
          },
          forceResendingToken: _resendToken,
          timeout: const Duration(
            seconds: 60,
          ),
        );
      } catch (exception) {
        log("Verification Completed");
        onError("Couldn't verify your phone number, Error: $exception");
        hideLoader();
      }
    } else {
      hideLoader();
    }*/
  }

  onLoginWithCredential(PhoneAuthCredential phoneAuthCredential,
      Function(String) onSuccessfulLogin, Function(String) onError) async {
    log("Verification Completed");
    await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
    log("Successful login");
    onSuccessfulLogin(
      FirebaseAuth.instance.currentUser?.displayName ?? "User",
    );
  }

  void setApplicationPending() {
    isApplicationPending = true;
    notifyListeners();
  }

  void setApplicationAccepted() {
    isApplicationPending = false;
    notifyListeners();
  }
}
