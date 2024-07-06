import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ConnectivityController extends GetxController {
  final _connectionType = MConnectivityResult.none.obs;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _streamSubscription;

  MConnectivityResult get connectionType => _connectionType.value;

  set connectionType(MConnectivityResult value) {
    _connectionType.value = value;
  }

  @override
  void onInit() {
    super.onInit();
    getConnectivityType();
    _streamSubscription = _connectivity.onConnectivityChanged.listen(
      (List<ConnectivityResult> results) => _updateState(results),
    );
  }

  Future<void> getConnectivityType() async {
    late List<ConnectivityResult> connectivityResults;
    try {
      connectivityResults = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return;
    }
    _updateState(connectivityResults);
  }

  void _updateState(List<ConnectivityResult> results) {
    if (results.contains(ConnectivityResult.wifi)) {
      connectionType = MConnectivityResult.wifi;
    } else if (results.contains(ConnectivityResult.mobile)) {
      connectionType = MConnectivityResult.mobile;
    } else if (results.contains(ConnectivityResult.none)) {
      connectionType = MConnectivityResult.none;
    } else {
      connectionType = MConnectivityResult.other;
    }
  }

  @override
  void onClose() {
    _streamSubscription.cancel();
    super.onClose();
  }
}

enum MConnectivityResult { none, wifi, mobile, other }
