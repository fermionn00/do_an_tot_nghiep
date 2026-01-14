import 'package:app_work_log/common/api/api_base.dart';
import 'package:app_work_log/common/api/api_url.dart';
import 'package:app_work_log/modules/leave_request/models/manager_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class LeaveRequestProvider extends ServiceProvider {
  LeaveRequestProvider() : super(provider: apiProvider);

  /// Send leave request
  Future<bool> sendLeaveRequest(
      {required int companyId,
      required int userId,
      required int toApproveId,
      required String timeStart,
      required String timeEnd,
      required String duration,
      required String reason}) async {
    try {
      Map<String, dynamic> body = {
        "company_id": companyId,
        "user_id": userId,
        "to_approve_id": toApproveId,
        "time_start": timeStart,
        "time_end": timeEnd,
        "duration": duration,
        "reason": reason,
      };
      var response = await provider.post(ApiUrl.sendLeaveRequest, data: body);

      if (response.statusCode == 201) {
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

  /// Get list manger of company
  Future<List<ManagerModel>> getListManagerofCompanyUserLogin() async {
    try {
      Response response = await provider.get(ApiUrl.managerOfCompany);
      List<ManagerModel> managers = managerModelFromJson(response.data["data"]);
      return managers;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return <ManagerModel>[];
  }
}
