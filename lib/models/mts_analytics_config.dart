import 'package:mts_analytics_plugin/models/log_level.dart';

class MtsAnalyticsConfig {
  LogLevel logLevel;
  int backgroundTimeout;
  int activeTimeout = 900;
  int eventStorageLimit;
  String androidFlowId;
  String iosFlowId;
  bool crashReportingEnabled;
  bool networkTrafficEnabled;

  MtsAnalyticsConfig({
    this.logLevel = LogLevel.off,
    this.backgroundTimeout = 900,
    this.activeTimeout = 900,
    this.eventStorageLimit = 3000,
    this.androidFlowId = "",
    this.iosFlowId = "",
    this.crashReportingEnabled = false,
    this.networkTrafficEnabled = true,
  });

  factory MtsAnalyticsConfig.fromJson(Map<String, dynamic> json) {
    final data = json['parameters'];
    return MtsAnalyticsConfig(
      backgroundTimeout: data['backgroundTimeout'] ?? 0,
      activeTimeout: data['activeTimeout'] ?? 0,
      eventStorageLimit: data['eventStorageLimit'] ?? 0,
      androidFlowId: data['androidFlowId'] ?? '',
      iosFlowId: data['iosFlowId'] ?? '',
      crashReportingEnabled: data['crashReportingEnabled'] ?? false,
      networkTrafficEnabled: data['networkTrafficEnabled'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['logLevel'] = logLevel.level;
    data['crashReportingEnabled'] = crashReportingEnabled;
    data['backgroundTimeout'] = backgroundTimeout;
    data['activeTimeout'] = activeTimeout;
    data['eventStorageLimit'] = eventStorageLimit;
    data['networkTrafficEnabled'] = networkTrafficEnabled;
    data['androidFlowId'] = androidFlowId;
    data['iosFlowId'] = iosFlowId;

    return <String, dynamic>{'parameters': data};
  }

  MtsAnalyticsConfig copyWith({
    LogLevel? logLevel,
    int? backgroundTimeout,
    int? activeTimeout,
    int? eventStorageLimit,
    String? androidFlowId,
    String? iosFlowId,
    bool? crashReportingEnabled,
    bool? networkTrafficEnabled,
  }) {
    return MtsAnalyticsConfig(
      logLevel: logLevel ?? this.logLevel,
      backgroundTimeout: backgroundTimeout ?? this.backgroundTimeout,
      activeTimeout: activeTimeout ?? this.activeTimeout,
      eventStorageLimit: eventStorageLimit ?? this.eventStorageLimit,
      androidFlowId: androidFlowId ?? this.androidFlowId,
      iosFlowId: iosFlowId ?? this.iosFlowId,
      crashReportingEnabled:
          crashReportingEnabled ?? this.crashReportingEnabled,
      networkTrafficEnabled:
          networkTrafficEnabled ?? this.networkTrafficEnabled,
    );
  }
}
