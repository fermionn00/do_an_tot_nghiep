import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart'
    as permission_handler;

class LocationService {
  LocationService._privateConstructor();

  static final _repository = LocationService._privateConstructor();

  static LocationService get instance => _repository;

  Function(bool hasPermission)? listenPermission;

  initial() async {
    Geolocator.getServiceStatusStream().listen((ServiceStatus event) async {
      // log.debug('getServiceStatusStream: ${event.name}');
      if (event == ServiceStatus.disabled) {
        openDialog(onONButtonClick: () async {
          Get.back();
          openLocationSettings();
        });
      }
    });
  }

  Position _lastKnowPosition = Position(
    heading: 0.0,
    timestamp: DateTime.now(),
    longitude: 0.0,
    speedAccuracy: 0.0,
    latitude: 0.0,
    altitude: 0.0,
    speed: 0.0,
    accuracy: 0.0,
    altitudeAccuracy: 0,
    headingAccuracy: 0,
  );

  Position get getLastKnowPosition => _lastKnowPosition;

  _onNewLocationListener(Position position) {
    _lastKnowPosition = position;
  }

  bool isFinishRequestPermission = true;

  /// requestLocationPermission
  requestLocationPermission() async {
    isFinishRequestPermission = false;
    if (!(await Geolocator.isLocationServiceEnabled())) {
      openDialog(onONButtonClick: () async {
        isFinishRequestPermission = true;
        Get.back();
        openLocationSettings();
      });
    } else {
      var status = await permission_handler.Permission.location.status;
      if (status.isDenied ||
          status.isPermanentlyDenied ||
          status.isRestricted) {
        status = await permission_handler.Permission.location.request();
      }

      if (status.isGranted || status.isLimited) {
        await getCurrentPosition();
        if (listenPermission != null) listenPermission!(true);
        isFinishRequestPermission = true;
      } else {
        if (listenPermission != null) listenPermission!(false);
        openDialog(onONButtonClick: () async {
          isFinishRequestPermission = true;
          Get.back();
          if (status.isPermanentlyDenied) {
            await Geolocator.openAppSettings();
          } else {
            requestLocationPermission();
          }
        });
      }
    }
  }

  /// get CurrentPosition
  Future getCurrentPosition() async {
    bool isError = false;
    await Geolocator.getCurrentPosition()
        .then((position) => _onNewLocationListener(position))
        .catchError((e) {
      isError = true;
    });
    if (isError) {
      return false;
    } else {
      return _lastKnowPosition;
    }
  }

  /// get LastKnowPosition
  getLastKnownPosition() async {
    await Geolocator.getLastKnownPosition().then((position) {
      if (position != null) _onNewLocationListener(position);
    }).catchError((e) {
      requestLocationPermission();
    });
    return _lastKnowPosition;
  }

  distanceBetween(double startLatitude, double startLongitude,
      double endLatitude, double endLongitude) {
    return Geolocator.distanceBetween(
        startLatitude, startLongitude, endLatitude, endLongitude);
  }

  openDialog({required Function() onONButtonClick}) {}

  openLocationSettings() async {
    if (GetPlatform.isIOS) {
      final channel = const MethodChannel('openAppSetting');
      channel.invokeMethod('location');
    } else {
      await Geolocator.openLocationSettings();
    }
  }
}
