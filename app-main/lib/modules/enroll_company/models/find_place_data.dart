import 'package:google_maps_flutter/google_maps_flutter.dart';

class FindPlaceData {
  String mainText, description;
  String placeId;
  double lat = 0, lng = 0;

  String get getDescription {
    List<String> data = description.split(', ').reversed.toList();
    if (description.isEmpty && mainText.isEmpty) return '';
    if (data.first.toUpperCase() == 'JAPAN') data[0] = '日本';
    return data.join("");
  }

  setDescription(String data) {
    description = '';
    List<String> data0 =
        data.split(', ').skipWhile((e) => !e.contains('</span>')).toList();
    data0 = [
      for (var i in data0)
        ...i
            .split('<span ')
            .skip(1)
            .skipWhile(
                (e) => e.contains("country-name") || e.contains("postal-code"))
            .map((e) => e.replaceAll('</span>', '')),
    ];
    data0 = [
      ...data0.where((e) => e.contains('street-address')),
      ...data0.where((e) => e.contains('extended-address')),
      ...data0.where((e) => e.contains('locality')),
      ...data0.where((e) => e.contains('region')),
    ].map((e) => e.split('>').last).toList();
    description = data0.join(', ');
  }

  toNew() => FindPlaceData(
        mainText: mainText,
        description: description,
        placeId: placeId,
        lat: lat,
        lng: lng,
      );

  toLatLng() => LatLng(lat, lng);

  FindPlaceData({
    this.mainText = '',
    this.description = '',
    this.placeId = '',
    this.lat = 0,
    this.lng = 0,
  });
}
