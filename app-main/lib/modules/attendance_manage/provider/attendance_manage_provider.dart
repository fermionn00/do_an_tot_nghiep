import 'package:app_work_log/common/api/api_base.dart';
import 'package:app_work_log/common/api/api_url.dart';
import 'package:app_work_log/modules/attendance_manage/models/attendance_casual_leave_manage.dart';
import 'package:app_work_log/modules/attendance_manage/models/attendance_checkin_manage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class AttendanceCheckInManageProvider extends ServiceProvider {
  AttendanceCheckInManageProvider() : super(provider: apiProvider);

  Future<List<AttendanceCheckInManage>> getListAttendanceCheckInbyDate(
      String statusCode,
      DateTime timeCheckinStart,
      DateTime timeCheckinEnd,
      String companyId) async {
    try {
      Response response = await provider.get(
          "${ApiUrl.attendanceManage}?status_code=$statusCode&time_checkin_start=$timeCheckinStart&time_checkin_end=$timeCheckinEnd&company_id=$companyId");
      List<AttendanceCheckInManage> attendances =
          attendanceFromJson(response.data["data"]);
      return attendances;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return <AttendanceCheckInManage>[];
  }

  Future<List<AttendanceCheckInManage>> getListAttendanceCheckInLate(
      DateTime timeCheckinStart, DateTime timeCheckinEnd) async {
    try {
      Response response = await provider.get(
          "${ApiUrl.attendamceLateManage}?time_checkin_start=$timeCheckinStart&time_checkin_end=$timeCheckinEnd");
      List<AttendanceCheckInManage> attendances =
          attendanceFromJson(response.data["data"]);
      return attendances;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return <AttendanceCheckInManage>[];
  }

  Future<List<AttendanceCasualLeave>> getListAttendanceCasualLeave(
      DateTime timeStart, DateTime timeEnd) async {
    try {
      Response response = await provider.get(
          "${ApiUrl.casualLeaveOfCompanyOnDate}?time_start_start=$timeStart&time_start_end=$timeEnd");
      List<AttendanceCasualLeave> attendances =
          attendanceCasualLeaveFromJson(response.data["data"]);
      return attendances;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return <AttendanceCasualLeave>[];
  }
}
