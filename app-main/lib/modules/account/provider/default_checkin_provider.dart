import 'package:app_work_log/common/api/api_base.dart';
import 'package:app_work_log/common/api/api_url.dart';
import 'package:app_work_log/common/utils/numeral.dart';
import 'package:app_work_log/modules/home/models/user_model.dart';
import 'package:flutter/foundation.dart';

class DefaultCheckinProvider extends ServiceProvider {
  DefaultCheckinProvider() : super(provider: apiProvider);

  Future<UserModel> getUserInfo() async {
    try {
      var response = await provider.get(ApiUrl.getUserInfo);
      return UserModel.fromJson(response.data["data"]);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return UserModel();
  }

  Future<bool> updateDefaultCheckin({required dynamic typeCheckin}) async {
    try {
      var response = await provider
          .put(ApiUrl.updateUserInfor, data: {"type_login": typeCheckin});

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
