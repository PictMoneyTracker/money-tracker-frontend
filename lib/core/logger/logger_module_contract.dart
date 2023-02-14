
import 'logger_message_type.dart';

abstract class LoggerModuleContract {
  void logMessage(
    String message, {
    LoggerMessageType messageType = LoggerMessageType.debug,
  });

  void logError(
    Exception exception,
    StackTrace? stackTrace,
    bool? fatal,
  );
}
