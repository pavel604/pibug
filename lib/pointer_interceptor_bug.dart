import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

class PointerInterceptorBug extends StatelessWidget {
  PointerInterceptorBug({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: HeaderWidget(
          scaffoldKey: _scaffoldKey,
        ),
      ),
      endDrawer: const MapEndDrawerWidget(),
      body: MapUiBody(),
    );
  }
}

class MapUiBody extends StatefulWidget {
  MapUiBody({Key? key}) : super(key: key);
  static const routeName = "/mapvew";
  @override
  State<StatefulWidget> createState() => MapUiBodyState();
}

class MapUiBodyState extends State<MapUiBody> with WidgetsBindingObserver {
  MapUiBodyState();
  // ignore: prefer_final_fields, unused_field
  List<MapType> mTypes = [
    MapType.normal,
    MapType.hybrid,
    MapType.satellite,
    MapType.terrain,
  ];
  MapType currentMapType = MapType.normal;

  bool _isMapCreated = false;
  //final bool _isMoving = false;
  final bool _compassEnabled = false;
  final bool _mapToolbarEnabled = false;
  final CameraTargetBounds _cameraTargetBounds = CameraTargetBounds.unbounded;
  final MinMaxZoomPreference _minMaxZoomPreference =
      const MinMaxZoomPreference(5.0, 19.0);
  //MapType _mapType = currentMapType;
  final bool _rotateGesturesEnabled = true;
  final bool _scrollGesturesEnabled = true;
  final bool _tiltGesturesEnabled = true;
  final bool _zoomControlsEnabled = false;
  final bool _zoomGesturesEnabled = true;
  final bool _indoorViewEnabled = true;
  final bool _myLocationEnabled = true;

  final bool _myLocationButtonEnabled = false;
  // ignore: prefer_final_fields
  bool _myTrafficEnabled = false;
  // ignore: prefer_final_fields
  bool _myPoisVisible = false;

  Set<Marker> markers = {};
  Set<Circle> circles = {};
  final Color lightCircleColor = const Color(0x44ffffff);
  final Color darkCircleColor = const Color(0x22000000);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(dynamic oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      GoogleMap(
        initialCameraPosition:
            const CameraPosition(target: LatLng(48.9942321, -122.7098484)),
        compassEnabled: _compassEnabled,
        mapToolbarEnabled: _mapToolbarEnabled,
        cameraTargetBounds: _cameraTargetBounds,
        minMaxZoomPreference: _minMaxZoomPreference,
        mapType: currentMapType,
        rotateGesturesEnabled: _rotateGesturesEnabled,
        scrollGesturesEnabled: _scrollGesturesEnabled,
        tiltGesturesEnabled: _tiltGesturesEnabled,
        zoomGesturesEnabled: _zoomGesturesEnabled,
        zoomControlsEnabled: _zoomControlsEnabled,
        indoorViewEnabled: _indoorViewEnabled,
        myLocationEnabled: _myLocationEnabled,
        myLocationButtonEnabled: _myLocationButtonEnabled,
        trafficEnabled: _myTrafficEnabled,
        onCameraIdle: () {},
        markers: markers,
        circles: circles,
      ),
      // more children here...
    ]);
  }
}

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({Key? key, required this.scaffoldKey}) : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldKey;
  @override
  Widget build(BuildContext context) {
    return PointerInterceptor(
      child: Container(
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          boxShadow: const [
            BoxShadow(
              blurRadius: 2,
              spreadRadius: 0,
              offset: Offset(0.0, 2),
              color: Colors.black26,
            )
          ],
        ),
        padding: const EdgeInsets.all(8),
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              //add profile plus name

              SizedBox(
                width: 60,
                height: 60,
                child: TextButton(
                  child: Center(
                    child: Center(
                      child: Icon(
                        Icons.menu,
                        color: Theme.of(context).textTheme.bodyText1!.color,
                      ),
                    ),
                  ),
                  onPressed: () {
                    scaffoldKey.currentState?.openEndDrawer();
                  },
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}

class MapEndDrawerWidget extends StatelessWidget {
  const MapEndDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PointerInterceptor(
        child: Drawer(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_forward_ios),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          title: const Text("Menu"),
          actions: const <Widget>[],
        ),
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            ListTile(
              leading: const Icon(Icons.location_city),
              title: const Text('Menu Item'),
              onTap: () {},
            ),
          ],
        ),
      ),
    ));
  }
}
