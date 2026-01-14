class Numeral {
  /// Index BottomNavigationBar
  static int screenHome = 0;
  static int screenAttendance = 1;
  static int screenManager = 2;
  static int screenNotification = 3;
  static int screenProfile = 4;

  /// Index select Manage
  static int selectAttendanceCheckin = 0;
  static int selectAttendanceLate = 1;
  static int selectAttendanceCasualLeave = 2;
  static int selectDashboardStatistics = 3;
  static int selectLeaveRequests = 4;
  static int selectOvertimeRequests = 5;
  static int selectStaff = 6;
  static int selectDepartment = 7;
  static int selectShift = 8;
  static int selectProfileCompany = 9;
  static int selectCompanySetting = 10;

  /// Index DropDown Attendance Manage
  static int selectListCheckin = 0;
  static int selectListLate = 1;
  static int selectListCasualLeave = 2;

  /// Status code leave request and Overtime request
  static int statusCodePending = 1;
  static int statusCodeApproved = 2;
  static int statusCodeReject = 3;

  /// Google Map
  static double zoomGoogleMap = 16;
  static double radiusCheck = 50;

  /// Date
  static int numberNextDay = 1;

  /// Status code user
  static int statusCodeActive = 1;
  static int statusCodeInactive = 2;

  /// Status code response api
  static int statusCodeApiSuccess = 200;
  static int statusCodeDefault = 1;
  static int codeNotManager = -1;

  /// Role code user
  static int roleCodeStaff = 1;
  static int roleCodeManager = 2;
  static int roleCodeAdmin = 3;

  /// Language
  static int languageEn = 1;
  static int languageVn = 2;
  static int languageJp = 3;

  /// Type Work Company
  static int typeWorkAtWork = 1;
  static int typeWorkRemote = 2;
  static int typeWorkAtWorkRemote = 3;

  /// Type Check-in
  static int typeCheckinLocation = 1;
  static int typeCheckinWifi = 2;
  static int typeCheckinLocationWifi = 3;

  /// Step forgot password
  static int stepInputEmail = 1;
  static int stepInputCode = 2;
  static int stepInputPasswordNew = 3;

  // Status check-in user
  static int checkedInStatus = 1;
}
