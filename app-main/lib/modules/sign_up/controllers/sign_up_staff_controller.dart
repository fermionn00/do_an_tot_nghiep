import 'package:app_work_log/common/widgets/base_dialog.dart';
import 'package:app_work_log/modules/sign_up/models/fetch_company_model.dart';
import 'package:app_work_log/modules/sign_up/provider/sign_up_provider.dart';
import 'package:app_work_log/oauth2/service/auth_service.dart';
import 'package:app_work_log/routes/app_pages.dart';
import 'package:app_work_log/themes/app_color.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_work_log/common/utils/dialog.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class SignUpStaffController extends GetxController {
  final GlobalKey<FormState> formKeySignUp = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyCreateStaff = GlobalKey<FormState>();
  var textCompanyID = TextEditingController().obs;

  TextEditingController textCompanyName = TextEditingController();
  TextEditingController textEmail = TextEditingController();
  TextEditingController textFirstName = TextEditingController();
  TextEditingController textLastName = TextEditingController();
  TextEditingController textEmployeeID = TextEditingController();
  TextEditingController textPassword = TextEditingController();
  TextEditingController textConfirmPassword = TextEditingController();
  TextEditingController textCompanyIdController = TextEditingController();

  MobileScannerController cameraController = MobileScannerController(
    detectionSpeed: DetectionSpeed.normal,
    facing: CameraFacing.front,
    torchEnabled: true,
  );

  RxString textPinQR = "".obs;
  RxBool isCheckedPrivacy = false.obs;
  Rx<FetchCompanyModel> fetchedCompany = FetchCompanyModel(-1, "NONE").obs;

  @override
  void onInit() {
    super.onInit();
    textCompanyName.text = "Devfast";
  }

  /// Get company by id
  Future<void> callApiGetCompanyByIdProvider(BuildContext context) async {
    showLoading(context: context);
    List<dynamic> result =
        await SignUpProvider().getCompanyById(textCompanyIdController.text);

    if (result.isEmpty) {
      BaseDialog.getBaseDialog(
        context: Get.context!,
        title: "wrong_company_id".tr,
        desc: "wrong_company_id_desc".tr,
        buttonColor: AppColor.lightRed,
        dialogType: DialogType.error,
      );
      return;
    }

    fetchedCompany.value = result[0];
    if (fetchedCompany.value.name != null) {
      textCompanyName.text = fetchedCompany.value.name!;
    }

    closeLoading();

    Get.toNamed(Routes.createStaff);
  }

  /// Sign up staff  user
  void callApiSignUpStaffUserProvider(BuildContext context) async {
    showLoading(context: context);
    String result = await SignUpProvider().signUpUser(
        firstName: textFirstName.text,
        lastName: textLastName.text,
        email: textEmail.text,
        employeeCode: textEmployeeID.text,
        companyId: fetchedCompany.value.id.toString(),
        password: textPassword.text);

    if (result.isEmpty) {
      BaseDialog.getBaseDialog(
        context: Get.context!,
        title: "error".tr,
        desc: "sign_up_error".tr,
        buttonColor: AppColor.lightRed,
        dialogType: DialogType.error,
      );
    } else {
      Get.find<AuthService>()
          .login(token: result, refreshToken: result, routeName: Routes.home);
    }
    closeLoading();
  }

  validateAndNexttoSignUp(BuildContext context) async {
    final FormState? form = formKeySignUp.currentState;
    if (!form!.validate()) {
    } else {
      await callApiGetCompanyByIdProvider(context);
    }
  }

  void validateAndSignUp(BuildContext context) {
    final FormState? form = formKeyCreateStaff.currentState;
    if (!form!.validate()) {
    } else {
      if (isCheckedPrivacy.value) {
        callApiSignUpStaffUserProvider(context);
      } else {
        showDialog<void>(
          context: Get.context!,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              // <-- SEE HERE
              title: Text('term_of_use_and_privacy'.tr),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('check_privacy'.tr),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }

  String? emptyValidateFunc(String? value) {
    if (value == null || value.isEmpty) {
      return "please_fill_this_field".tr;
    } else {
      return null;
    }
  }

  String? emailValidateFunc(String? value) {
    if (value == null || value.isEmpty) {
      return "please_fill_this_field".tr;
    } else if (!value.isEmail) {
      return "Please enter the email in the correct format";
    } else {
      return null;
    }
  }

  String? passwordValidateFunc(String? value) {
    if (value == null || value.isEmpty) {
      return "please_fill_this_field".tr;
    } else if (value.length < 8) {
      return "password_least_characters_long".tr;
    } else {
      return null;
    }
  }

  String? confirmPasswordValidateFunc(String? value) {
    if (value == null || value.isEmpty) {
      return "please_fill_this_field".tr;
    } else if (value.length < 8) {
      return "password_least_characters_long".tr;
    } else if (value != textPassword.text) {
      return "re-entered_password_not match".tr;
    } else {
      return null;
    }
  }

  updateCheckPrivacy() {
    isCheckedPrivacy.toggle();
  }
}
