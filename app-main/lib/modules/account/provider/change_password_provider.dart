import 'package:app_work_log/common/api/api_base.dart';
import 'package:app_work_log/common/api/api_url.dart';
import 'package:app_work_log/common/utils/numeral.dart';
import 'package:flutter/foundation.dart';

class ChangePasswordProvider extends ServiceProvider {
  ChangePasswordProvider() : super(provider: apiProvider);

  // Change password
  Future<bool> changePassword(
      {required String password,
      required String newPassword,
      required String confirmPassword}) async {
    try {
      Map<String, dynamic> body = {
        "currentPassword": password,
        "password": newPassword,
        "newConfirmPassword": confirmPassword,
      };

      var response = await provider.put(ApiUrl.updatePassword, data: body);

      if (response.statusCode == Numeral.statusCodeApiSuccess) {
        return true;
      }
      return false;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return false;
  }
}
