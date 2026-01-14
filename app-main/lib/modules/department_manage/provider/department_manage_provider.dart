import 'package:app_work_log/common/api/api_base.dart';
import 'package:app_work_log/common/api/api_url.dart';
import 'package:app_work_log/common/utils/numeral.dart';
import 'package:app_work_log/modules/department_manage/model/department_manager.dart';
import 'package:app_work_log/modules/department_manage/model/employee_company.dart';
import 'package:app_work_log/modules/department_manage/model/manager_company.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DepartmentManageProvider extends ServiceProvider {
  DepartmentManageProvider() : super(provider: apiProvider);

  Future<List<DepartmentManage>> getListDepartmentofCompanyUserLogin(
      String companyId) async {
    try {
      Response response =
          await provider.get("${ApiUrl.departmentOfCompany}/$companyId");
      List<DepartmentManage> departments =
          departmentManageFromJson(response.data["data"]);
      return departments;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return <DepartmentManage>[];
  }

  Future<List<ManagerCompany>> getListManagerofCompanyUserLogin() async {
    try {
      Response response = await provider.get(ApiUrl.managerOfCompany);
      List<ManagerCompany> managers =
          managerCompanyFromJson(response.data["data"]);
      return managers;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return <ManagerCompany>[];
  }

  Future<List<EmployeeCompany>> getListEmployeeCompanyUserLogin() async {
    try {
      Response response = await provider.get(ApiUrl.companyEmployee);
      List<EmployeeCompany> managers =
          employeeCompanyFromJson(response.data["data"]);
      return managers;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return <EmployeeCompany>[];
  }

  Future<bool> addDepartment(String nameDepartment, int idCompany,
      int idManager, int statusCode) async {
    try {
      Response response = await provider.post(ApiUrl.postDepartmentCompany,
          data: idManager != Numeral.codeNotManager
              ? {
                  "name": nameDepartment,
                  "company_id": idCompany,
                  "manager_id": idManager,
                  "status_code": statusCode
                }
              : {
                  "name": nameDepartment,
                  "company_id": idCompany,
                  "status_code": statusCode
                });

      return response.data["data"] != null;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateDepartment(
      int id, String name, int companyId, int managerId) async {
    try {
      Response response = await provider.put(
          "${ApiUrl.putDepartmentCompany}/$id",
          data: managerId != Numeral.codeNotManager
              ? {"name": name, "company_id": companyId, "manager_id": managerId}
              : {"name": name, "company_id": companyId});
      return response.data["data"] != null;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteDepartment(int id) async {
    try {
      var response =
          await provider.delete("${ApiUrl.deleteDepartmentCompany}/$id");
      return response.data["data"] != null;
    } catch (e) {
      return false;
    }
  }
}
