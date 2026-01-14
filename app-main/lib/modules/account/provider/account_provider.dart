import 'package:app_work_log/common/api/api_base.dart';
import 'package:app_work_log/common/api/api_url.dart';
import 'package:app_work_log/modules/home/models/user_model.dart';
import 'package:flutter/foundation.dart';

class AccountProvider extends ServiceProvider {
  AccountProvider() : super(provider: apiProvider);

  /// Get user infor
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
}
