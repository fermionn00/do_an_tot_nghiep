import 'package:app_work_log/common/api/api_base.dart';
import 'package:app_work_log/common/api/api_url.dart';
import 'package:app_work_log/common/utils/numeral.dart';
import 'package:flutter/foundation.dart';

class UpdateProfileProvider extends ServiceProvider {
  UpdateProfileProvider() : super(provider: apiProvider);

  // Update user infor
  Future<bool> updateUserInfo(
      {required String firstName,
      required String lastName,
      required String employeeId,
      required String address,
      required String phoneNumber}) async {
    try {
      Map<String, dynamic> body = {
        "first_name": firstName,
        "last_name": lastName,
        "employee_code": employeeId,
        "address": address,
        "phone_number": phoneNumber,
      };

      var response = await provider.put(ApiUrl.updateUserInfor, data: body);

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
