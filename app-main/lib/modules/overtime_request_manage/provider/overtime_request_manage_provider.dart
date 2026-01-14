import 'package:app_work_log/common/api/api_base.dart';
import 'package:app_work_log/common/api/api_url.dart';
import 'package:app_work_log/common/global.dart';
import 'package:app_work_log/common/utils/numeral.dart';
import 'package:app_work_log/modules/overtime_request_manage/models/overtime_request_manage.dart';
import 'package:app_work_log/modules/overtime_request_manage/models/statistic_company.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class OverTimeRequestProvider extends ServiceProvider {
  OverTimeRequestProvider() : super(provider: apiProvider);

  Future<List<OvertimeRequestManage>> getListOvertimeRequestManage(
      DateTime timeStart, DateTime timeEnd, int? approveId) async {
    try {
      Response? response;
      if (Global.roleCodeUser == Numeral.roleCodeAdmin) {
        response = await provider.get(
            "${ApiUrl.overtimeCompanyManage}?time_start_start=$timeStart&time_start_end=$timeEnd");
      } else if (Global.roleCodeUser == Numeral.roleCodeManager) {
        response = await provider.get(
            "${ApiUrl.overtimeCompanyManage}?time_start_start=$timeStart&time_start_end=$timeEnd&to_approve_id=$approveId");
      }
      List<OvertimeRequestManage> overtimeRequest =
          overtimeRequestManageFromJson(response!.data["data"]);
      return overtimeRequest;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return <OvertimeRequestManage>[];
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
      Response response =
          await provider.put("${ApiUrl.updateOvertimeRequest}/$id",
              data: statusCode == Numeral.statusCodeApproved
                  ? {
                      "status_code": statusCode,
                    }
                  : {"status_code": statusCode, "reason_reject": reasonReject});
      return response.data["data"] != null;
    } catch (e) {
      return false;
    }
  }
}
