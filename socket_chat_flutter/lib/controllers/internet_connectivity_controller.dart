import 'dart:async';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

class ConnectivityController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  RxBool isOnline = false.obs;

  StreamSubscription<ConnectivityResult>? _connectivitySubscription;

  @override
  void onInit() {
    super.onInit();
    checkConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((result) {
      checkConnectivity();
    });
  }

  @override
  void onClose() {
    _connectivitySubscription?.cancel();
    super.onClose();
  }

  Future<void> checkConnectivity() async {
    var connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      bool hasInternet = await _testInternetConnectivity();
      isOnline.value = hasInternet;
    } else {
      isOnline.value = false;
    }
  }

  Future<bool> _testInternetConnectivity() async {
    try {
      final response = await http.get(Uri.parse('https://www.google.com'));
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}