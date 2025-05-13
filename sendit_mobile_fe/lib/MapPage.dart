import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController? _googleMapController;
  LocationData? _currentLocation;
  final Location _location = Location();
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    final locationData = await _location.getLocation();
    setState(() {
      _currentLocation = locationData;
      _markers.add(
        Marker(
          markerId: const MarkerId('currentLocation'),
          position: LatLng(-6.969208277534193, 107.628116537959),
          infoWindow: const InfoWindow(title: 'Current Location'),
        ),
      );
    });
  }

  void _locateCurrentPosition() async {
    final locationData = await _location.getLocation();
    _googleMapController?.animateCamera(
      CameraUpdate.newLatLng(
        LatLng(-6.969208277534193, 107.628116537959),
      ),
    );
    setState(() {
      _currentLocation = locationData;
      _markers.add(
        Marker(
          markerId: const MarkerId('currentLocation'),
          position: LatLng(-6.969208277534193, 107.628116537959),
          infoWindow: const InfoWindow(title: 'Current Location'),
        ),
      );
    });
  }

  void _zoomIn() {
    _googleMapController?.animateCamera(CameraUpdate.zoomIn());
  }

  void _zoomOut() {
    _googleMapController?.animateCamera(CameraUpdate.zoomOut());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _currentLocation == null
              ? const Center(child: CircularProgressIndicator())
              : GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(-6.969208277534193, 107.628116537959),
                    zoom: 12,
                  ),
                  markers: _markers,
                  onMapCreated: (GoogleMapController controller) {
                    setState(() {
                      _googleMapController = controller;
                    });
                  },
                  zoomControlsEnabled: false,
                ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'zoomInTag', // Unique tag
            onPressed: _zoomIn,
            child: const Icon(Icons.zoom_in),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: 'zoomOutTag', // Unique tag
            onPressed: _zoomOut,
            child: const Icon(Icons.zoom_out),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: 70,
            height: 70,
            child: FloatingActionButton(
              heroTag: 'locatePositionTag', // Unique tag
              onPressed: _locateCurrentPosition,
              child: const Icon(Icons.my_location, size: 35),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _googleMapController?.dispose();
    super.dispose();
  }
}