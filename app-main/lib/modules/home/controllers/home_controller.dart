import 'package:app_work_log/common/global.dart';
import 'package:app_work_log/common/utils/dialog.dart';
import 'package:app_work_log/common/utils/numeral.dart';
import 'package:app_work_log/common/widgets/base_button.dart';
import 'package:app_work_log/common/widgets/base_button_login.dart';
import 'package:app_work_log/common/widgets/base_dialog.dart';
import 'package:app_work_log/languages/language_service.dart';
import 'package:app_work_log/modules/home/models/card_statistic_model.dart';
import 'package:app_work_log/modules/home/models/statistic_model.dart';
import 'package:app_work_log/modules/home/models/shift_model.dart';
import 'package:app_work_log/modules/home/models/user_model.dart';
import 'package:app_work_log/modules/home/provider/home_provider.dart';
import 'package:app_work_log/modules/leave_request/models/manager_model.dart';
import 'package:app_work_log/modules/leave_request/provider/leave_request_provider.dart';
import 'package:app_work_log/modules/staff_manage/models/attendance.dart';
import 'package:app_work_log/oauth2/provider/auth_provider.dart';
import 'package:app_work_log/oauth2/service/auth_service.dart';
import 'package:app_work_log/oauth2/service/notification_service.dart';
import 'package:app_work_log/themes/app_color.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/foundation.dart' show kDebugMode, kIsWeb;

class HomeController extends GetxController {
  final authService = AuthProvider();
  var userInfo = UserModel().obs;
  var lastAttendance = AttendanceModel().obs;
  RxString lastCheckIn = "--:--".obs;
  RxString lastCheckOut = "--:--".obs;
  RxString lastDuration = "--:--".obs;

  RxInt checkInStatus = 2.obs;

  RxString date = "---".obs;

  var statisticCards = <CardStatisticModel>[].obs;

  var homeStatistic = StatisticModel().obs;
  var listShift = [].obs;

  Rx<ShiftModel> selectedShift = ShiftModel().obs;
  Rx<ShiftModel> currentShift = ShiftModel().obs;

  var currentLocationLat = 0.0.obs;
  var currentLocationLong = 0.0.obs;
  var distance = 0.0.obs;
  RxString address = "--".obs;

  RxBool isValidManagerLate = true.obs;

  var listManager = <ManagerModel>[].obs;
  RxInt selectedManagerId = 0.obs;
  Rx<String> selectedDropBox = "send_to".tr.obs;
  final TextEditingController searchDropBoxController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();

  Rx<DateTime> dateTimeCheckoutLate = DateTime.now().obs;

  var isTypeWorkWifi = 0.obs;
  NotificationService notificationService = NotificationService();

  @override
  void onInit() {
    super.onInit();
    getDateNow();
  }

  @override
  Future<void> onReady() async {
    super.onReady();

    switch (Get.find<AuthService>().languageApp) {
      case 1:
        LanguageService.changeLocale("en");
        break;
      case 2:
        LanguageService.changeLocale("vi");
        break;
      case 3:
        LanguageService.changeLocale("jp");
        break;
      default:
        LanguageService.changeLocale("en");
        break;
    }

    refreshData();
  }

  refreshData() async {
    showLoading();
    await Future.wait([
      callApiUserProvider(),
      callApiLastCheckInProvider(),
      getHomeStatistic(),
    ]);
    closeLoading();
    setPermissionLocation();

    if (userInfo.value.shiftId != null) {
      DateTime timeBegin =
          DateFormat("HH:mm:ss").parse(userInfo.value.shiftInfo!.timeStart!);
      DateTime dateTimeBegin = DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          timeBegin.hour,
          timeBegin.minute);
      DateTime dateTimeBeginSchedule = dateTimeBegin.subtract(
        const Duration(minutes: 5),
      );
      if (dateTimeBeginSchedule.compareTo(DateTime.now()) > 0) {
        notificationService.scheduleNotification(
          id: 1,
          title: 'noti'.tr,
          body: "checkin".tr,
          scheduledNotificationDateTime: dateTimeBeginSchedule,
        );
      }

      DateTime timeEnd =
          DateFormat("HH:mm:ss").parse(userInfo.value.shiftInfo!.timeEnd!);
      DateTime dateTimeEnd = DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, timeEnd.hour, timeEnd.minute);
      DateTime dateTimeEndSchedule = dateTimeEnd.add(
        const Duration(minutes: 5),
      );
      if (dateTimeEndSchedule.compareTo(DateTime.now()) > 0) {
        notificationService.scheduleNotification(
          id: 2,
          title: 'noti'.tr,
          body: "checkout".tr,
          scheduledNotificationDateTime: dateTimeEndSchedule,
        );
      }
    }
  }

  getCurrentShiftInfo() {
    if (currentShift.value.id != null) {
      return "${currentShift.value.name} (${currentShift.value.timeStart} - ${currentShift.value.timeEnd})";
    }
    return "not_checked_in".tr;
  }

  Future<bool> setPermissionLocation() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    } else {
      Position position;
      try {
        position = await Geolocator.getCurrentPosition(
          locationSettings: AndroidSettings(accuracy: LocationAccuracy.best),
        );
        currentLocationLat.value = position.latitude;
        currentLocationLong.value = position.longitude;
        if (!kIsWeb) {
          address.value =
              await getAddress(position.latitude, position.longitude);
        }
        return true;
      } catch (e) {
        return false;
      }
    }

    return false;
  }

  Future<String> getAddress(double lat, double long) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
    Placemark place = placemarks[0];
    String address =
        '${place.administrativeArea}, ${place.subAdministrativeArea}, ${place.street}';
    return address;
  }

  Future<void> getHomeStatistic() async {
    homeStatistic.value = await HomeProvider().getStatictisUserLogin();
    statisticCards.value = [
      CardStatisticModel(
          1,
          "working_days".tr,
          homeStatistic.value.workingDays.toString(),
          AppColor.workingDays,
          Icons.calendar_month),
      CardStatisticModel(
          2,
          "working_hours".tr,
          (homeStatistic.value.workingHours ?? 0).toStringAsFixed(2),
          AppColor.workingHours,
          Icons.alarm_on),
      CardStatisticModel(
          3,
          "leave_requests".tr,
          homeStatistic.value.leaveRequest.toString(),
          AppColor.leaveRequests,
          Icons.assignment),
      CardStatisticModel(
          4,
          "hours_off".tr,
          (homeStatistic.value.hoursOff ?? 0).toStringAsFixed(2),
          AppColor.hoursOff,
          Icons.history_toggle_off),
      CardStatisticModel(
          5,
          "ot_requests".tr,
          homeStatistic.value.overtimeRequest.toString(),
          AppColor.otRequests,
          Icons.task),
      CardStatisticModel(
          6,
          "ot_hours".tr,
          (homeStatistic.value.overtimeHours ?? 0).toStringAsFixed(2),
          AppColor.otHours,
          Icons.alarm_add),
      CardStatisticModel(
          7,
          "late_arrival".tr,
          homeStatistic.value.lateArrivals.toString(),
          AppColor.lateArrival,
          Icons.snooze),
      CardStatisticModel(
          8,
          "early_leaving".tr,
          homeStatistic.value.earlyLeaving.toString(),
          AppColor.earlyLeaving,
          Icons.hourglass_bottom),
    ];
  }

  updateCheckInStatus(BuildContext context) async {
    // Call to get company location
    showLoading(context: context);
    await callApiUserProvider();
    if (userInfo.value.shiftId != null) {
      selectedShift.value.id = userInfo.value.shiftId;
    }
    await Future.wait([
      callApiLastCheckInProvider(),
    ]);

    // Check distance
    bool checkLocationPermission = await setPermissionLocation();
    closeLoading();

    if (checkLocationPermission) {
      if (!kIsWeb) {
        distance.value = Geolocator.distanceBetween(
            currentLocationLat.value,
            currentLocationLong.value,
            userInfo.value.companyInfo!.latitude!,
            userInfo.value.companyInfo!.longitude!);
      }
      if (checkInStatus.value == Numeral.checkedInStatus) {
        var result = await HomeProvider().getLastCheckIn();
        lastAttendance.value = result;

        DateTime now = DateTime.now();

        DateFormat dateFormat = DateFormat("yyyy-MM-dd hh:mm:ss");

        String shiftTimeEndString =
            "${DateFormat("yyyy-MM-dd").format(now)} ${result.shiftInfo!.timeEnd!}";

        String shiftTimeStartString =
            "${DateFormat("yyyy-MM-dd").format(now)} ${result.shiftInfo!.timeStart!}";

        DateTime shiftTimeEnd = dateFormat
            .parse(shiftTimeEndString)
            .add(const Duration(minutes: 10));

        DateTime shiftTimeStart = dateFormat.parse(shiftTimeStartString);

        if (now.isBefore(shiftTimeStart)) {
          String type;
          if (now.isAfter(shiftTimeEnd)) {
            type = "late_check_out";
          } else {
            if (distance.value > userInfo.value.companyInfo!.maxDistance! &&
                !kIsWeb) {
              reasonController.text = "";
              selectedDropBox.value = "send_to".tr;
              type = "remote_check_out";
            } else {
              type = "default_check_out";
            }
          }
          showDialogCheckOutBeforeShiftStart(type);
        } else {
          if (now.isAfter(shiftTimeEnd)) {
            checkOutRemoteOrLate(
              context,
              "late_checkout".tr,
              "description_late_checkout".tr,
            );
          } else {
            if (distance.value > userInfo.value.companyInfo!.maxDistance! &&
                !kIsWeb) {
              reasonController.text = "";
              selectedDropBox.value = "send_to".tr;
              checkOutRemoteOrLate(
                context,
                "remote_checkout".tr,
                "noti_remote_checkout".tr,
              );
              // callApiCheckOutProvider();
            } else {
              callApiCheckOutProvider(context);
            }
          }
        }
      } else {
        await callApiGetListShift();
        if (distance.value > userInfo.value.companyInfo!.maxDistance! &&
            !kIsWeb) {
          if (userInfo.value.companyInfo!.typeWork == Numeral.typeWorkAtWork) {
            Get.snackbar("noti".tr, "get_close_company".tr);
          } else if (userInfo.value.companyInfo!.typeWork ==
              Numeral.typeWorkAtWorkRemote) {
            checkInRemote(context: context, shiftId: selectedShift.value.id);
          }
        } else {
          if (userInfo.value.shiftId != null) {
            showDialog<void>(
              context: Get.context!,
              barrierDismissible: false, // user must tap button!
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(
                    "check_in".tr,
                    style: TextStyle(color: AppColor.primaryBlue),
                  ),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        Text(
                          "${"you_are_checking_in_for".tr} ",
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          "${userInfo.value.shiftInfo?.name} (${userInfo.value.shiftInfo?.timeStart} - ${userInfo.value.shiftInfo?.timeEnd})",
                          style: TextStyle(
                              fontSize: 16,
                              color: AppColor.primaryGreen,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: AppColor.lightGrey),
                      ),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                    TextButton(
                      child: Text(
                        'OK',
                        style: TextStyle(color: AppColor.primaryBlue),
                      ),
                      onPressed: () async {
                        var result = await HomeProvider().checkIn(
                            context,
                            userInfo.value.shiftId,
                            currentLocationLat.value,
                            currentLocationLong.value,
                            Numeral.typeWorkAtWork);
                        if (result) {
                          callApiLastCheckInProvider();
                        } else {
                          BaseDialog.getBaseDialog(
                              context: Get.context!,
                              title: "check_in_fail".tr,
                              desc: "check_in_fail_desc".tr,
                              dialogType: DialogType.error,
                              buttonColor: AppColor.lightRed,
                              textColor: AppColor.lightRed);
                        }
                        Get.back();
                        Get.back();
                      },
                    ),
                  ],
                );
              },
            );
          } else {
            chooseShift(context, Numeral.typeWorkAtWork);
          }
        }
      }
    }
  }

  updateCheckInStatusWifi(BuildContext context) async {
    // Call to get company location
    showLoading(context: context);
    await callApiUserProvider();
    if (userInfo.value.shiftId != null) {
      selectedShift.value.id = userInfo.value.shiftId;
    }

    await Future.wait([
      callApiLastCheckInProvider(),
    ]);

    // Check distance
    bool checkLocationPermission = await setPermissionLocation();
    closeLoading();

    if (checkLocationPermission) {
      if (checkInStatus.value == 1) {
        if (isTypeWorkWifi.value == Numeral.typeWorkRemote) {
          reasonController.text = "";
          selectedDropBox.value = "send_to".tr;
          checkOutRemoteOrLate(
              context, "remote_checkout".tr, "noti_remote_checkout".tr);
          // callApiCheckOutProvider();
        } else {
          callApiCheckOutProvider(context);
        }
      } else {
        chooseTypeWorkCheckinWifi(context);
      }
    }
  }

  checkOutRemoteOrLate(BuildContext context, String title, String description) {
    final size = MediaQuery.sizeOf(context);

    callApiManagerOfCompany();
    showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
                width: size.width * 0.7,
                // height: size.height * 0.3,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                            color: AppColor.primaryText,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        style: TextStyle(
                            color: AppColor.lightText,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(height: 16),
                      getManagerWidget(context),
                      const SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "actual_check_out_time".tr,
                            style: TextStyle(
                                color: AppColor.primaryGrey,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: size.width * 0.8,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            decoration: BoxDecoration(
                                color: AppColor.lightPurple,
                                borderRadius: BorderRadius.circular(12),
                                border: (!isValidManagerLate.value)
                                    ? Border.all(
                                        color: AppColor.lightRed, width: 1.5)
                                    : null,
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black12,
                                      spreadRadius: 2,
                                      blurRadius: 4)
                                ]),
                            child: Obx(
                              () => GestureDetector(
                                onTap: () async {
                                  dateTimeCheckoutLate.value =
                                      await showDateTimePicker(
                                              context: context) ??
                                          DateTime.now();
                                },
                                child: Row(
                                  children: [
                                    Icon(Icons.calendar_month,
                                        color: AppColor.primaryGrey.withAlpha(
                                          (0.8 * 255).round(),
                                        )),
                                    const SizedBox(width: 14),
                                    Text(
                                      DateFormat("yyyy-MM-dd  hh:mm:ss")
                                          .format(dateTimeCheckoutLate.value),
                                      style: TextStyle(
                                          color: AppColor.primaryBlue,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      getReasonWidget(context),
                      const SizedBox(height: 16),
                      GestureDetector(
                        onTap: () {
                          sendCheckoutRemoteRequest();
                        },
                        child: BaseButton(
                          height: size.height * 0.055,
                          width: size.width * 0.6,
                          title: "checkout".tr,
                          fontSize: 15,
                          textColor: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                )),
          );
        });
  }

  sendCheckoutRemoteRequest() async {
    // Check valid manager field
    if (selectedDropBox.value.isEmpty ||
        selectedDropBox.value == "send_to".tr) {
      isValidManagerLate.value = false;
    } else {
      isValidManagerLate.value = true;
    }

    if (isValidManagerLate.value) {
      int result = await HomeProvider().checkOutLate(
          managerId: selectedManagerId.value,
          timeLeave: dateTimeCheckoutLate.value,
          reason: reasonController.text,
          latitudeCheckout: currentLocationLat.value,
          longitudeCheckout: currentLocationLong.value);

      if (result == 200 || result == 204) {
        callApiLastCheckInProvider();
        getHomeStatistic();
        currentShift.value = ShiftModel();
        Get.back();
      } else {
        BaseDialog.getBaseDialog(
            context: Get.context!,
            title: "check_out_fail".tr,
            desc: "check_out_fail_desc".tr,
            dialogType: DialogType.error,
            buttonColor: AppColor.lightRed,
            textColor: AppColor.lightRed);
      }
    } else {
      if (kDebugMode) {
        print("----------- INVALID");
      }
    }
  }

  showDialogCheckOutBeforeShiftStart(String type) {
    showDialog<void>(
      context: Get.context!,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "invalid_check_out".tr,
            style: TextStyle(color: AppColor.primaryBlue),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("invalid_check_out_desc".tr),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Cancel',
                style: TextStyle(color: AppColor.primaryGrey),
              ),
              onPressed: () {
                Get.back();
              },
            ),
            TextButton(
              child: Text(
                'OK',
                style: TextStyle(color: AppColor.primaryBlue),
              ),
              onPressed: () async {
                switch (type) {
                  case "late_check_out":
                    await checkOutRemoteOrLate(context, "late_checkout".tr,
                        "description_late_checkout".tr);
                    break;
                  case "remote_check_out":
                    Get.back();
                    await checkOutRemoteOrLate(context, "remote_checkout".tr,
                        "noti_remote_checkout".tr);
                    break;
                  case "default_check_out":
                    await callApiCheckOutProvider(context);
                    Get.back();
                    break;
                  default:
                    await callApiCheckOutProvider(context);
                    Get.back();
                }
              },
            ),
          ],
        );
      },
    );
  }

  getReasonWidget(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "reason".tr,
          style: TextStyle(
              color: AppColor.primaryGrey,
              fontSize: 14,
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          width: size.width * 0.8,
          height: size.height * 0.12,
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          decoration: BoxDecoration(
              color: AppColor.lightPurple,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(color: Colors.black12, spreadRadius: 2, blurRadius: 4)
              ]),
          child: TextField(
            maxLength: 500,
            maxLines: null,
            controller: reasonController,
            decoration: InputDecoration(
                hintStyle: TextStyle(fontSize: 14, color: AppColor.primaryGrey),
                border: InputBorder.none,
                hintText: "reason".tr),
          ),
        )
      ],
    );
  }

  updateSelectedManager(ManagerModel manager) {
    selectedDropBox.value = "${manager.name} - ${manager.departName}";
    selectedManagerId.value = manager.id!;
  }

  /// Get manager of company
  Future<void> callApiManagerOfCompany() async {
    var result =
        await LeaveRequestProvider().getListManagerofCompanyUserLogin();
    if (result.isNotEmpty) {
      listManager.value = result;
    }
  }

  Future<DateTime?> showDateTimePicker({
    required BuildContext context,
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    initialDate ??= DateTime.now();
    firstDate ??= initialDate.subtract(const Duration(days: 365 * 100));
    lastDate ??= firstDate.add(const Duration(days: 365 * 200));

    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (selectedDate == null) return null;

    if (!context.mounted) return selectedDate;

    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(selectedDate),
    );

    return selectedTime == null
        ? selectedDate
        : DateTime(
            selectedDate.year,
            selectedDate.month,
            selectedDate.day,
            selectedTime.hour,
            selectedTime.minute,
          );
  }

  getManagerWidget(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "manager".tr,
          style: TextStyle(
              color: AppColor.primaryGrey,
              fontSize: 14,
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 10,
        ),
        Obx(
          () => Container(
            width: size.width * 0.8,
            padding: const EdgeInsets.symmetric(vertical: 2),
            decoration: BoxDecoration(
                color: AppColor.lightPurple,
                borderRadius: BorderRadius.circular(12),
                border: (!isValidManagerLate.value)
                    ? Border.all(color: AppColor.lightRed, width: 1.5)
                    : null,
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black12, spreadRadius: 2, blurRadius: 4)
                ]),
            child: DropdownButtonHideUnderline(
              child: DropdownButton2<ManagerModel>(
                isExpanded: true,
                hint: TextFormField(
                    cursorColor: Colors.black,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: selectedDropBox.value,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: const EdgeInsets.only(
                          left: 10, bottom: 13, top: 13, right: 10),
                      prefixIcon: Icon(Icons.supervisor_account,
                          color: AppColor.primaryGrey.withAlpha(
                            (0.8 * 255).round(),
                          )),
                      labelStyle: TextStyle(
                          color: (isValidManagerLate.value)
                              ? AppColor.primaryGrey
                              : AppColor.lightRed,
                          fontSize: 14),
                    )),
                items: listManager
                    .map((item) => DropdownMenuItem(
                          value: item,
                          child: Text(
                            "${item.name} - ${item.departName}",
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    updateSelectedManager(value);
                  }
                },
                buttonStyleData: const ButtonStyleData(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  height: 40,
                  width: 200,
                ),
                dropdownStyleData: const DropdownStyleData(
                  maxHeight: 200,
                ),
                menuItemStyleData: const MenuItemStyleData(
                  height: 40,
                ),
                dropdownSearchData: DropdownSearchData(
                  searchController: searchDropBoxController,
                  searchInnerWidgetHeight: 50,
                  searchInnerWidget: Container(
                    height: 50,
                    padding: const EdgeInsets.only(
                      top: 8,
                      bottom: 4,
                      right: 8,
                      left: 8,
                    ),
                    child: TextFormField(
                      expands: true,
                      maxLines: null,
                      controller: searchDropBoxController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        hintText: 'Search for an item...',
                        hintStyle: const TextStyle(fontSize: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  searchMatchFn: (item, searchValue) {
                    String displayedLabel =
                        "${item.value?.name} - ${item.value?.departName}";

                    displayedLabel = displayedLabel.toLowerCase();
                    searchValue = searchValue.toLowerCase();

                    return displayedLabel.contains(searchValue);
                  },
                ),
                //This to clear the search value when you close the menu
                onMenuStateChange: (isOpen) {
                  if (!isOpen) {
                    searchDropBoxController.clear();
                  }
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  checkInRemote({required BuildContext context, required int? shiftId}) {
    final size = MediaQuery.sizeOf(context);
    showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
                width: size.width * 0.7,
                height: size.height * 0.3,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: [
                    Text(
                      "not_office_range".tr,
                      style: TextStyle(
                          color: AppColor.primaryText,
                          fontSize: 17,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "do_you_want_to_work_from_home".tr,
                      style: TextStyle(
                          color: AppColor.primaryText,
                          fontSize: 17,
                          fontWeight: FontWeight.w500),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          if (userInfo.value.shiftId == null) {
                            chooseShift(context, Numeral.typeWorkRemote);
                          } else {
                            var result = await HomeProvider().checkIn(
                                context,
                                userInfo.value.shiftId,
                                currentLocationLat.value,
                                currentLocationLong.value,
                                Numeral.typeWorkRemote);

                            if (result) {
                              callApiLastCheckInProvider();
                            } else {
                              BaseDialog.getBaseDialog(
                                  context: Get.context!,
                                  title: "check_in_fail".tr,
                                  desc: "check_in_fail_desc".tr,
                                  dialogType: DialogType.error,
                                  buttonColor: AppColor.lightRed,
                                  textColor: AppColor.lightRed);
                            }
                            Get.back();
                            Get.back();
                          }
                        },
                        child: AvatarGlow(
                          // endRadius: size.width * 0.3,
                          glowColor: AppColor.primaryGreen,
                          duration: const Duration(milliseconds: 2000),
                          repeat: true,
                          // showTwoGlows: true,
                          // repeatPauseDuration:
                          //     const Duration(milliseconds: 100),
                          child: CircleAvatar(
                            backgroundImage: const AssetImage(
                                'assets/images/common/img_checkin_remote_button.png'),
                            radius: size.width * 0.18,
                          ),
                        ),
                      ),
                    )
                  ],
                )),
          );
        });
  }

  /// Choose shift
  chooseShift(BuildContext context, int typeCheckin) {
    final size = MediaQuery.sizeOf(context);
    showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              width: size.width * 0.7,
              height: size.height * 0.4,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: createRadioListUsers(context, typeCheckin),
            ),
          );
        });
  }

  Widget createRadioListUsers(BuildContext context, int typeCheckin) {
    final size = MediaQuery.sizeOf(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Row(
            children: [
              Text(
                "Shift",
                style: TextStyle(
                    color: AppColor.primaryText,
                    fontSize: 23,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: listShift.length,
              itemBuilder: (BuildContext context, int index) {
                ShiftModel shift = listShift[index];
                return GestureDetector(
                  onTap: () {
                    selectedShift.value = shift;
                  },
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Obx(
                            () => Image.asset(
                                (selectedShift.value == shift)
                                    ? "assets/icons/ic_check_box.png"
                                    : "assets/icons/ic_uncheck_box.png",
                                width: 22,
                                height: 22),
                          ),
                          const SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                shift.name ?? "",
                                style: TextStyle(
                                    color: AppColor.primaryPurple,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "(${shift.timeStart}  -  ${shift.timeEnd})",
                                style: TextStyle(
                                    fontSize: 13, color: AppColor.primaryText),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 6.0),
                        child: Divider(),
                      )
                    ],
                  ),
                );
                // title: Text("List item $index"));
              }),
        ),
        const SizedBox(
          height: 7,
        ),
        GestureDetector(
          onTap: () async {
            if (selectedShift.value.id == null) {
              AwesomeDialog(
                context: Get.context!,
                dialogType: DialogType.error,
                animType: AnimType.scale,
                title: "no_shift_selected".tr,
                desc: "no_shift_selected_desc".tr,
                btnOkColor: AppColor.lightRed,
                btnOkOnPress: () {},
                onDismissCallback: (type) {},
              ).show();
            } else {
              await callApiCheckInProvider(context, typeCheckin);
              Get.back();
              Get.back();
            }
          },
          child: BaseButtonLogin(
            height: size.height * 0.055,
            width: size.width * 0.5,
            title: "check_in".tr,
            borderRadius: 16,
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Future<void> callApiGetListShift() async {
    var result = await HomeProvider().getListShift();

    if (result.isEmpty) {
      return;
    }
    listShift.value = result;
    selectedShift.value = listShift[0];
  }

  /// Check In
  callApiCheckInProvider(BuildContext context, int typeCheckin) async {
    var result = await HomeProvider().checkIn(
        context,
        selectedShift.value.id ?? 1,
        currentLocationLat.value,
        currentLocationLong.value,
        typeCheckin);

    if (result) {
      callApiLastCheckInProvider();
    } else {
      BaseDialog.getBaseDialog(
          context: Get.context!,
          title: "check_in_fail".tr,
          desc: "check_in_fail_desc".tr,
          dialogType: DialogType.error,
          buttonColor: AppColor.lightRed,
          textColor: AppColor.lightRed);
    }
  }

  /// Check Out
  callApiCheckOutProvider(BuildContext context) async {
    var result = await HomeProvider()
        .checkOut(context, currentLocationLat.value, currentLocationLong.value);
    if (result == 200 || result == 204) {
      callApiLastCheckInProvider();
      getHomeStatistic();
      currentShift.value = ShiftModel();
    } else {
      BaseDialog.getBaseDialog(
          context: Get.context!,
          title: "check_out_fail".tr,
          desc: "check_out_fail_desc".tr,
          dialogType: DialogType.error,
          buttonColor: AppColor.lightRed,
          textColor: AppColor.lightRed);
    }
  }

  /// Get user infor
  Future<void> callApiUserProvider() async {
    var result = await HomeProvider().getUserInfo();
    userInfo.value = result;

    if (result.id != null) {
      Global.userId = result.id!;
    }

    if (result.companyId != null) {
      Global.companyId = result.companyId!;
    }

    if (result.firstName != null && result.lastName != null) {
      Global.userName = "${result.firstName} ${result.lastName}";
    }
  }

  /// Get last check in
  Future<void> callApiLastCheckInProvider() async {
    var result = await HomeProvider().getLastCheckIn();
    lastAttendance.value = result;

    checkInStatus.value = lastAttendance.value.statusCode ?? 2;
    lastCheckIn.value = formatCheckInTime(lastAttendance.value.timeCheckin);
    lastCheckOut.value = formatCheckInTime(lastAttendance.value.timeCheckout);
    lastDuration.value = calWorkingHour(
        lastAttendance.value.timeCheckin, lastAttendance.value.timeCheckout);

    if (lastAttendance.value.timeCheckout == null) {
      currentShift.value = lastAttendance.value.shiftInfo ?? ShiftModel();
    } else {
      currentShift.value = ShiftModel();
    }
  }

  String formatCheckInTime(DateTime? time) {
    if (time == null) {
      return "--:--";
    }
    return DateFormat("HH:mm").format(time);
  }

  String calWorkingHour(DateTime? checkInTime, DateTime? checkOutTime) {
    if (checkInTime == null || checkOutTime == null) {
      return "--:--";
    } else {
      final Duration duration = checkOutTime.difference(checkInTime);
      return duration.inHours.toString();
    }
  }

  getDateNow() {
    DateTime now = DateTime.now();
    var locale = LanguageService.locales[
        Get.find<AuthService>().languageApp == null
            ? 0
            : (Get.find<AuthService>().languageApp! - 1)];
    initializeDateFormatting(locale.toString());
    String formattedDate =
        DateFormat('EEEE, MMMM dd', locale.toString()).format(now);
    date.value = formattedDate;
  }

  chooseTypeWorkCheckinWifi(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              width: size.width * 0.7,
              height: size.height * 0.2,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Row(
                      children: [
                        Text(
                          "Choose type work",
                          style: TextStyle(
                              color: AppColor.primaryText,
                              fontSize: 23,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () async {
                          isTypeWorkWifi.value = Numeral.typeWorkAtWork;
                          await callApiGetListShift();
                          if (userInfo.value.shiftId != null) {
                            var result = await HomeProvider().checkIn(
                              context,
                              userInfo.value.shiftId,
                              currentLocationLat.value,
                              currentLocationLong.value,
                              Numeral.typeWorkAtWork,
                            );

                            if (result) {
                              callApiLastCheckInProvider();
                            } else {
                              BaseDialog.getBaseDialog(
                                  context: Get.context!,
                                  title: "check_in_fail".tr,
                                  desc: "check_in_fail_desc".tr,
                                  dialogType: DialogType.error,
                                  buttonColor: AppColor.lightRed,
                                  textColor: AppColor.lightRed);
                            }
                            Get.back();
                            Get.back();
                          } else {
                            chooseShift(context, Numeral.typeWorkAtWork);
                          }
                        },
                        child: SizedBox(
                          width: size.width * 0.3,
                          height: size.width * 0.3,
                          child: SvgPicture.asset(
                              "assets/images/common/ic_at_work.svg"),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          isTypeWorkWifi.value = Numeral.typeWorkRemote;
                          await callApiGetListShift();
                          if (userInfo.value.companyInfo!.typeWork ==
                              Numeral.typeWorkAtWork) {
                            /// thông báo công ty chỉ cho làm tại công ty
                            Get.snackbar(
                                "noti".tr,
                                "noti_default_checkin".trParams({
                                  "typeCheckin": "location".tr,
                                }));
                          } else if (userInfo.value.companyInfo!.typeWork ==
                              Numeral.typeWorkAtWorkRemote) {
                            if (userInfo.value.shiftId == null) {
                              chooseShift(context, Numeral.typeWorkRemote);
                            } else {
                              var result = await HomeProvider().checkIn(
                                context,
                                userInfo.value.shiftId,
                                currentLocationLat.value,
                                currentLocationLong.value,
                                Numeral.typeWorkRemote,
                              );

                              if (result) {
                                callApiLastCheckInProvider();
                              } else {
                                BaseDialog.getBaseDialog(
                                    context: Get.context!,
                                    title: "check_in_fail".tr,
                                    desc: "check_in_fail_desc".tr,
                                    dialogType: DialogType.error,
                                    buttonColor: AppColor.lightRed,
                                    textColor: AppColor.lightRed);
                              }
                              Get.back();
                              Get.back();
                            }
                          }
                        },
                        child: SizedBox(
                          width: size.width * 0.3,
                          height: size.width * 0.3,
                          child: SvgPicture.asset(
                              "assets/images/common/ic_remote.svg"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
