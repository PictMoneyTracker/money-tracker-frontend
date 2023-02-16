
import 'package:flutter/foundation.dart';

import 'logger_public.dart';

class MyLogger {
  final List<LoggerModuleContract> _loggerModules;

  MyLogger._(this._loggerModules);

  static MyLogger? _instance;

  factory MyLogger.createInstance(
      List<LoggerModuleContract> modules) {
    return _instance ??= MyLogger._(modules);
  }

  static MyLogger get getInstance {
    if (_instance == null) {
      kDebugMode
          ? throw Exception("App Shell Logger Not Initialized")
          : MyLogger.createInstance(
              [
                DevToolsLoggerModule(),
              ],
            );
    }

    return _instance!;
  }

  void logMessage(
    String message, {
    LoggerMessageType messageType = LoggerMessageType.debug,
  }) {
    for (final module in _loggerModules) {
      module.logMessage(message, messageType: messageType);
    }
  }

  void logError(
    Object error, {
    StackTrace? stackTrace,
    bool? fatal,
  }) {
    for (final module in _loggerModules) {
      module.logError(Exception(error), stackTrace, fatal);
    }
  }
}
