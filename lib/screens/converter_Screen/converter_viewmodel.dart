import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:currency_converter/models/currency_info.dart';
import 'package:currency_converter/screens/bye_bye_screen/exit_screen.dart';
import 'package:currency_converter/services/apiservice/apiservice.dart';
import 'package:currency_converter/services/offline_service/offline_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

class CurrencyProvider extends ChangeNotifier {
  List<String> currencyCodes = [];
  String toCode = "";
  String fromCode = "";
  double? amount;
  Map<String, double> offlineresult = {};
  CurrencyInfo? Onlineresult;
  String? connection;

  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  bool get mounted {
    if (mounted) {
      return true;
    } else {
      return false;
    }
  }

  void checkIfOnline(BuildContext context) async {
    await initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

    if (_connectionStatus == ConnectivityResult.none) {
      // showDialog(
      //     context: context,
      //     builder: ((context) {
      //       return AlertDialog(
      //         title: Text(" You Are Offline ?"),
      //         content: Text(" Click Ok to Work On offline mode ?"),
      //         actions: [
      //           ElevatedButton(
      //               onPressed: () {
      //                 Navigator.pop(context);
      //               },
      //               child: Text("OK")),
      //           ElevatedButton(
      //               onPressed: () {
      //                 Navigator.pop(context);
      //                 Navigator.of(context)
      //                     .push(MaterialPageRoute(builder: (context) {
      //                   return ByeByeScreen();
      //                 }));
      //               },
      //               child: Text("cancel"))
      //         ],
      //       );
      //     }));
    }
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      log('Couldn\'t check connectivity status', error: e);
      return;
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    _connectionStatus = result;
    result != ConnectivityResult.none
        ? connection = "online"
        : connection = "offline";
    notifyListeners();
  }

  Future<void> convert() async {
    // if (_connectionStatus != ConnectivityResult.wifi ||
    //     _connectionStatus != ConnectivityResult.mobile ||
    //     _connectionStatus != ConnectivityResult.ethernet) {
    //   print("conectivityoff");
    //   Offlineresult = OfflineService.fetchCurrencyConversionOffline(
    //       amount: amount, from: fromCode, to: toCode);
    // }
    if (_connectionStatus == ConnectivityResult.none) {
      print("offline");
      offlineresult = OfflineService.fetchCurrencyConversionOffline(
          amount: amount, from: fromCode, to: toCode);
    } else if (_connectionStatus == ConnectivityResult.wifi ||
        _connectionStatus == ConnectivityResult.ethernet) {
      Onlineresult = await ApiService.fetchCurrencyConversionOnline(
          amount: amount, from: fromCode, to: toCode);
    }

    notifyListeners();
  }

  void setAmount(String value) {
    amount = double.parse(value);
    print(amount);
    notifyListeners();
  }

  void putToCode(String value) {
    toCode = value;
    print(toCode);
    notifyListeners();
  }

  void putFromCode(String value) {
    fromCode = value;
    print(fromCode);
    notifyListeners();
  }
}
