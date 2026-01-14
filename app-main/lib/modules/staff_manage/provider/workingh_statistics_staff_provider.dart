import 'package:app_work_log/common/api/api_base.dart';
import 'package:app_work_log/common/api/api_url.dart';
import 'package:app_work_log/modules/staff_manage/models/statistic.dart';
import 'package:app_work_log/modules/staff_manage/models/time_working_date.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class WorkingHoursStatisticsStaffProvider extends ServiceProvider {
  WorkingHoursStatisticsStaffProvider() : super(provider: apiProvider);

  Future<StatisticModel> getStatictisUserLogin(
      String userId, String dateTimeStart, String datTimeEnd) async {
    try {
      var response = await provider.get(ApiUrl.userStatistic, data: {
        "user_id": userId,
        "time_checkin_start": dateTimeStart,
        "time_checkin_end": datTimeEnd,
        "time_start_start": dateTimeStart,
        "time_start_end": datTimeEnd
      });
      StatisticModel statistic = statisticFromJson(response.data["data"]);
      return statistic;
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
    }
    return StatisticModel();
  }

  Future<List<TimeWorkingDate>> getSumTimeWorking(
      String userId, String timeQuery) async {
    try {
      Response response = await provider.get(ApiUrl.timeWorkingDate,
          data: {"user_id": userId, "time_query": timeQuery});
      List<TimeWorkingDate> timeWorking =
          timeWorkingDateFromJson(response.data["data"]);
      return timeWorking;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return <TimeWorkingDate>[];
  }
}
