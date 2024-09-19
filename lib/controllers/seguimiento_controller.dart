import 'package:get/get.dart';
import 'package:mi_ruta/controllers/controller.dart';
import 'package:mi_ruta/services/geolocator_sevice.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:here_sdk/core.dart';
import 'package:here_sdk/mapview.dart';

class SeguimientoController extends Controller {
  final StopWatchTimer stopWatchTimer =
      StopWatchTimer(mode: StopWatchMode.countUp);
  final geolocatorService = Get.find<GeolocatorService>();
  late List<MapMarker> markers = [];
  final MapImage poiMapImage = MapImage.withFilePathAndWidthAndHeight(
      "assets/images/poi_texture.png", 60, 60);

  @override
  Future<void> init() async {
    // TODO: implement init
    super.init();
    await Future.delayed(const Duration(minutes: 2));
    stopWatchTimer.onStartTimer();
  }

  void addLocationIndicator(
      GeoCoordinates geoCoordinates,
      LocationIndicatorIndicatorStyle indicatorStyle,
      HereMapController hereMapController) {
    LocationIndicator locationIndicator = LocationIndicator();
    locationIndicator.locationIndicatorStyle = indicatorStyle;

    // A LocationIndicator is intended to mark the user's current location,
    // including a bearing direction.
    // For testing purposes, we create a Location object. Usually, you may want to get this from
    // a GPS sensor instead.
    Location location = Location.withCoordinates(geoCoordinates);
    location.time = DateTime.now();
    location.bearingInDegrees = 0; // _getRandom(0, 360)

    locationIndicator.updateLocation(location);

    // Show the indicator on the map view.
    locationIndicator.enable(hereMapController);
  }

  MapMarker addMapMarker(GeoCoordinates geoCoordinates, String text) {
    int imageWidth = 60;
    int imageHeight = 60;
    MapImage mapImage = MapImage.withFilePathAndWidthAndHeight(
        "assets/images/poi_texture.png", imageWidth, imageHeight);
    MapMarker mapMarker = MapMarker(geoCoordinates, mapImage);

    MapMarkerTextStyle textStyleCurrent = mapMarker.textStyle;
    MapMarkerTextStyle textStyleNew = mapMarker.textStyle;
    double textSizeInPixels = 30;
    double textOutlineSizeInPixels = 5;

    List<MapMarkerTextStylePlacement> placements = [];
    placements.add(MapMarkerTextStylePlacement.bottom);
    placements.add(MapMarkerTextStylePlacement.top);
    mapMarker.isOverlapAllowed = false;

    try {
      textStyleNew = MapMarkerTextStyle.make(
          textSizeInPixels,
          textStyleCurrent.textColor,
          textOutlineSizeInPixels,
          textStyleCurrent.textOutlineColor,
          placements);
    } on MapMarkerTextStyleInstantiationException catch (e) {
      // An error code will indicate what went wrong, for example, when negative values are set for text size.
      print("TextStyle: Error code: ${e.error.name}");
    }

    mapMarker.text = text;
    mapMarker.textStyle = textStyleNew;

    //hereMapController.mapScene.addMapMarker(mapMarker);

    /**Anchor2D anchor2D = Anchor2D.withHorizontalAndVertical(0.5, 1);
    MapMarker mapMarker = MapMarker.withAnchor(
        GeoCoordinates(10.296847, -66.383364), poiMapImage!, anchor2D);**/

    return mapMarker;
  }

  Future<void> onMapCreated(HereMapController hereMapController) async {
    // The camera can be configured before or after a scene is loaded.
    const double dMeters = 1500; // distancia en metros
    MapMeasure mapMeasureZoom = MapMeasure(MapMeasureKind.distance, dMeters);
    /**GeoCoordinates geoCoordinates = GeoCoordinates(
        geolocatorService.realtimePosition.value.latitude,
        geolocatorService.realtimePosition.value.longitude);**/
    hereMapController.camera.lookAtPointWithMeasure(
        GeoCoordinates(geolocatorService.realtimePosition.value.latitude,
            geolocatorService.realtimePosition.value.longitude),
        mapMeasureZoom);

    // Load the map scene using a map scheme to render the map with.
    hereMapController.mapScene.loadSceneForMapScheme(MapScheme.liteDay,
        (MapError? error) {
      if (error != null) {
        print('Map scene not loaded. MapError: ${error.toString()}');
      }
    });

    LocationIndicatorIndicatorStyle indicatorStyle =
        LocationIndicatorIndicatorStyle.pedestrian;
    addLocationIndicator(
        GeoCoordinates(geolocatorService.realtimePosition.value.latitude,
            geolocatorService.realtimePosition.value.longitude),
        indicatorStyle,
        hereMapController);

    // agregar marcadores
    /**markers.add(
        addMapMarker(GeoCoordinates(10.296847, -66.383364), "Urb. Los Robles"));

    //hereMapController.mapScene.addMapMarker(addMapMarker(GeoCoordinates(10.296847, -66.383364)));
    hereMapController.mapScene.addMapMarkers(markers);**/
  }
}
