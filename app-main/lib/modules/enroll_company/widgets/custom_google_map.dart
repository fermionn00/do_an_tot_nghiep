import 'package:app_work_log/modules/enroll_company/controllers/custom_google_map_controller.dart';
import 'package:app_work_log/modules/enroll_company/models/find_place_data.dart';
import 'package:app_work_log/modules/enroll_company/services/map_pin_picker.dart';
import 'package:app_work_log/modules/enroll_company/widgets/custom_marker.dart';
import 'package:app_work_log/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomGoogleMap extends StatelessWidget {
  const CustomGoogleMap({
    super.key,
    required this.customGoogleMapController,
    required this.onUpdateAddress,
    required this.initialPosition,
  });

  final Function(FindPlaceData data) onUpdateAddress;

  final CustomGoogleMapController customGoogleMapController;

  final FindPlaceData initialPosition;

  void _onMapCreated(GoogleMapController controller) {
    customGoogleMapController.mapController.complete(controller);
    customGoogleMapController.customInfoWindowController.googleMapController =
        controller;
    customGoogleMapController.infoWindowController.googleMapController =
        controller;
    if (!customGoogleMapController.isMapCreated) {
      customGoogleMapController.isMapCreated = true;

      customGoogleMapController.position = CameraPosition(
          target: LatLng(initialPosition.lat, initialPosition.lng), zoom: 17);
      customGoogleMapController.animateCamera(
          CameraUpdate.newCameraPosition(customGoogleMapController.position));
    }
  }

  void _updateCameraPosition(CameraPosition position) {
    if (customGoogleMapController.isUpdateAddress) {}
    customGoogleMapController.position = position;
  }

  void _onCameraMoveStarted() =>
      customGoogleMapController.mapPickerController.mapMoving();

  void _onCameraIdle() {
    customGoogleMapController.mapPickerController.mapFinishedMoving();
    if (customGoogleMapController.isUpdateAddress) {
      onUpdateAddress(FindPlaceData(
          lng: customGoogleMapController.position.target.longitude,
          lat: customGoogleMapController.position.target.latitude));
      _searchAddressFromPosition();
    }
  }

  void _searchAddressFromPosition() {}

  @override
  Widget build(BuildContext context) {
    return MapPicker(
      mapPickerController: customGoogleMapController.mapPickerController,
      showDot: true,
      iconWidget: Obx(
        () => CustomMarker(
          color: customGoogleMapController.markers
                  .any((e) => e.markerId.value == 'startPoint')
              ? CustomColors.blue
              : CustomColors.red,
        ),
      ),
      child: GoogleMap(
        buildingsEnabled: false,
        mapType: MapType.normal,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: LatLng(
            initialPosition.lat,
            initialPosition.lng,
          ),
          zoom: 17.0,
        ),
        onCameraMove: _updateCameraPosition,
        onCameraMoveStarted: _onCameraMoveStarted,
        onCameraIdle: _onCameraIdle,
        zoomControlsEnabled: false,
        markers: Set<Marker>.of(customGoogleMapController.markers),
        polylines: Set<Polyline>.of(customGoogleMapController.polyline),
      ),
    );
  }
}
