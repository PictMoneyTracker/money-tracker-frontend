import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

import '../logger_message_type.dart';
import '../logger_module_contract.dart';

class DevToolsLoggerModule implements LoggerModuleContract {
  final logger = kDebugMode
      ? Logger(
          printer: PrettyPrinter(
            methodCount: 0,
            lineLength: 80,
          ),
        )
      : null;

  @override
  void logMessage(
    String message, {
    LoggerMessageType messageType = LoggerMessageType.debug,
  }) {
    if (kDebugMode) {
      switch (messageType) {
        case LoggerMessageType.info:
          logger?.i(message);
          break;
        case LoggerMessageType.warning:
          logger?.w(message);
          break;
        case LoggerMessageType.debug:
          logger?.d(message);
      }
    }
  }

  @override
  void logError(Exception exception, StackTrace? stackTrace, bool? fatal) {
    if (kDebugMode) {
      logger?.wtf(
        exception.toString(),
        exception,
        stackTrace,
      );
    }
  }
}
