import 'package:firebase_auth/firebase_auth.dart';
import 'package:kfc/constants/constants.dart';

class MobileAuthService {
  //  Check authentication
  static bool checkAuthentication() {
    User? user = auth.currentUser;
    if (user == null) {
      return false;
    }
    return true;
  }
}
