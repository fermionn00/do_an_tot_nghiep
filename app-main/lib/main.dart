import 'package:app_work_log/common/utils/global_key.dart';
import 'package:app_work_log/languages/language_service.dart';
import 'package:app_work_log/oauth2/service/auth_service.dart';
import 'package:app_work_log/oauth2/service/notification_service.dart';
import 'package:app_work_log/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_web_frame/flutter_web_frame.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:workmanager/workmanager.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

// --- THÊM 2 DÒNG IMPORT NÀY ---
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', 'High Importnce Notifications',
    description: 'This channel is used for important notifications',
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    try {
      if (task == "scheduledNotification") {
        tz.initializeTimeZones();
        NotificationService().scheduleNotification(
          id: inputData!['id'],
          title: inputData['title'],
          body: inputData['body'],
          scheduledNotificationDateTime: inputData['timeSchedule'],
        );
        return Future.value(true);
      }
      return Future.value(false);
    } catch (err) {
      throw Exception(err);
    }
  });
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // --- BẮT ĐẦU ĐOẠN CODE CẤU HÌNH GOOGLE MAPS ---
  // Yêu cầu sử dụng Renderer mới nhất để tránh lỗi AdvancedMarkers
  final GoogleMapsFlutterPlatform mapsImplementation =
      GoogleMapsFlutterPlatform.instance;
  if (mapsImplementation is GoogleMapsFlutterAndroid) {
    // Dùng Android View Surface để render map mượt hơn
    mapsImplementation.useAndroidViewSurface = true;
    try {
      await mapsImplementation
          .initializeWithRenderer(AndroidMapRenderer.latest);
    } catch (e) {
      print("Lỗi khởi tạo Renderer Maps: $e");
    }
  }
  // --- KẾT THÚC ĐOẠN CODE CẤU HÌNH GOOGLE MAPS ---

  tz.initializeTimeZones();
  NotificationService().initNotification();

  if (!kIsWeb) {
    await Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
    // FirebaseMessaging.onBackgroundMessage((message) => _message(message));
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  await dotenv.load(fileName: "lib/.env");
  await GetStorage.init();
  await Get.putAsync(() => AuthService().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    final size = MediaQuery.sizeOf(context);
    return FlutterWebFrame(
      builder: (context) => GetMaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        locale: LanguageService.locale,
        fallbackLocale: LanguageService.fallbackLocale,
        translations: LanguageService(),
        getPages: AppPages.routes,
      ),
      maximumSize: Size(
        size.width,
        size.height,
      ),
      enabled: kIsWeb,
      backgroundColor: Colors.black,
    );
  }
}
