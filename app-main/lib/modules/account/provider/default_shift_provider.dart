import 'package:app_work_log/common/api/api_base.dart';
import 'package:app_work_log/common/api/api_url.dart';
import 'package:app_work_log/common/utils/numeral.dart';
import 'package:app_work_log/modules/account/models/shift_model.dart';
import 'package:app_work_log/modules/home/models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DefaultShiftProvider extends ServiceProvider {
  DefaultShiftProvider() : super(provider: apiProvider);

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

  Future<List<ShiftManager>> getListShiftofCompanyUserLogin() async {
    try {
      Response response = await provider.get(ApiUrl.shiftOfComapny);
      List<ShiftManager> shifts = shiftManagerFromJson(response.data["data"]);
      return shifts;
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
    }
    return <ShiftManager>[];
  }

  Future<bool> updateDefaultShift({required dynamic shiftId}) async {
    try {
      var response = await provider
          .put(ApiUrl.updateUserInfor, data: {"shift_id": shiftId});

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
