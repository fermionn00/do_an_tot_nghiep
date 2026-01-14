import 'package:app_work_log/common/api/api_base.dart';
import 'package:app_work_log/common/api/api_url.dart';
import 'package:app_work_log/common/global.dart';
import 'package:app_work_log/common/utils/numeral.dart';
import 'package:app_work_log/modules/leave_request_manage/models/leave_request_manage.dart';
import 'package:app_work_log/modules/leave_request_manage/models/statistic_company.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class LeaveRequestManageProvider extends ServiceProvider {
  LeaveRequestManageProvider() : super(provider: apiProvider);

  Future<List<LeaveRequestManage>> getListLeaveRequestManage(
      DateTime timeStart, DateTime timeEnd, int? approveId) async {
    try {
      Response? response;
      if (Global.roleCodeUser == Numeral.roleCodeAdmin) {
        response = await provider.get(
          "${ApiUrl.casualLeaveOfCompanyOnDate}?time_start_start=$timeStart&time_start_end=$timeEnd",
        );
      } else if (Global.roleCodeUser == Numeral.roleCodeManager) {
        response = await provider.get(
            "${ApiUrl.casualLeaveOfCompanyOnDate}??time_start_start=$timeStart&time_start_end=$timeEnd&to_approve_id=$approveId");
      }
      List<LeaveRequestManage> leaveRequest =
          leaveRequestManageFromJson(response!.data["data"]);
      return leaveRequest;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return <LeaveRequestManage>[];
  }

  Future<StatisticCompany> getCompanyStatistic(
      String dateTimeStart, String datTimeEnd, int? approveId) async {
    try {
      Response? response;
      if (Global.roleCodeUser == Numeral.roleCodeAdmin) {
        response = await provider.get(ApiUrl.companyStatistic, data: {
          "time_checkin_start": dateTimeStart,
          "time_checkin_end": datTimeEnd,
          "time_start_start": dateTimeStart,
          "time_start_end": datTimeEnd
        });
      } else if (Global.roleCodeUser == Numeral.roleCodeManager) {
        response = await provider.get(ApiUrl.companyStatistic, data: {
          "time_checkin_start": dateTimeStart,
          "time_checkin_end": datTimeEnd,
          "time_start_start": dateTimeStart,
          "time_start_end": datTimeEnd,
          "to_approve_id": approveId
        });
      }
      StatisticCompany companyModel =
          statisticCompanyFromJson(response!.data["data"]);
      return companyModel;
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
    }
    return StatisticCompany();
  }

  Future<bool> updateLeaveRequest(
      String id, int statusCode, String reasonReject) async {
    try {
      Response response = await provider.put("${ApiUrl.updateLeaveRequest}/$id",
          data: statusCode == Numeral.statusCodeApproved
              ? {
                  "status_code": statusCode,
                }
              : {"status_code": statusCode, "reason_reject": reasonReject});
      return response.data["data"] != null;
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
      return false;
    }
  }
}
