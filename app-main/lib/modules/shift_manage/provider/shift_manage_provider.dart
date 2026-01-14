import 'package:app_work_log/common/api/api_base.dart';
import 'package:app_work_log/common/api/api_url.dart';
import 'package:app_work_log/modules/shift_manage/model/shift.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ShiftManageProvider extends ServiceProvider {
  ShiftManageProvider() : super(provider: apiProvider);

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

  Future<bool> addShift(String companyId, String name, String timeStart,
      String timeEnd, int statusCode, int type) async {
    try {
      Response response = await provider.post(ApiUrl.postShiftCompany, data: {
        "company_id": companyId,
        "name": name,
        "time_start": timeStart,
        "time_end": timeEnd,
        "status_code": statusCode,
        "type": type
      });

      return response.data["data"] != null;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return false;
    }
  }

  Future<bool> updateShift(
      int id, String name, String timeStart, String timeEnd) async {
    try {
      Response response = await provider.put("${ApiUrl.putShiftCompany}/$id",
          data: {"name": name, "time_start": timeStart, "time_end": timeEnd});
      return response.data["data"] != null;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return false;
    }
  }

  Future<bool> deleteShift(int id) async {
    try {
      var response = await provider.delete("${ApiUrl.deleteShiftCompany}/$id");
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print("Status code done: ");
        }
      }
      return response.data["data"] != null;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return false;
    }
  }
}
