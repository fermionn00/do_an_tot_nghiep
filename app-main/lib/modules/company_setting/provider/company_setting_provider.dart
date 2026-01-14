import 'package:app_work_log/common/api/api_base.dart';
import 'package:app_work_log/common/api/api_url.dart';
import 'package:app_work_log/modules/company_profile/models/company.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class CompanySettingProvider extends ServiceProvider {
  CompanySettingProvider() : super(provider: apiProvider);

  Future<CompanyModel> getInfoCompanyUserLogin(String companyId) async {
    try {
      Response response =
          await provider.get("${ApiUrl.infoCompanyByCode}/$companyId");
      CompanyModel companyModel = companyModelFromJson(response.data["data"]);
      return companyModel;
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
    }
    return CompanyModel();
  }

  Future<bool> updateInfoCompany(String id, CompanyModel companyModel) async {
    try {
      Response response = await provider.put(
          "${ApiUrl.updateInfoCompanyByCode}/$id",
          data: companyModel.toJson());
      return response.data["data"] != null;
    } catch (e) {
      return false;
    }
  }
}
