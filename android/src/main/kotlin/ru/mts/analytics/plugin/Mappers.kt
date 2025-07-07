package ru.mts.analytics.plugin

import ru.mts.analytics.plugin.ecomm.toEcommerceGA4
import ru.mts.analytics.plugin.ecomm.toEcommerceGA4Name
import ru.mts.analytics.plugin.ecomm.toEcommerceUA
import ru.mts.analytics.plugin.ecomm.toEcommerceUAName
import ru.mts.analytics.sdk.logger.LogLevel2
import ru.mts.analytics.sdk.publicapi.config.MtsAnalyticsConfig2
import ru.mts.analytics.sdk.publicapi.event2.Event2

fun Int?.toLogLevel(): LogLevel2 {
    return when (this) {
        LogLevel2.OFF.level -> LogLevel2.OFF
        LogLevel2.ERROR.level -> LogLevel2.ERROR
        LogLevel2.WARNING.level -> LogLevel2.WARNING
        LogLevel2.DEBUG.level -> LogLevel2.DEBUG
        LogLevel2.VERBOSE.level -> LogLevel2.VERBOSE
        else -> LogLevel2.OFF
    }
}


fun Map<String, Any?>.toMtsAnalyticsConfig(): MtsAnalyticsConfig2 {
    val logLevel = this["logLevel"] as? Int?
    return MtsAnalyticsConfig2.Builder(flowId = get("androidFlowId") as? String ?: "")
        .setLogLevel(logLevel?.toLogLevel() ?: LogLevel2.OFF)
        .setCrashReportingEnabled(get("crashReportingEnabled") as? Boolean == true)
        .setBackgroundTimeout(get("backgroundTimeout") as? Int ?: 1800)
        .setActiveTimeout(get("activeTimeout") as? Int ?: 1800)
        .setEventStorageLimit(get("eventStorageLimit") as? Int ?: 20000)
        .setNetworkTrafficEnabled(get("networkTrafficEnabled") as? Boolean != false)
        .build()
}

@Suppress("UNCHECKED_CAST")
fun Map<String, Any?>.toEvent(): Event2? {
    val eventName = this["event"] as String
    val eventType = this["eventType"] as String
    return when (eventType) {
        "custom_error" ->
            Event2.ErrorEvent(
                errMsg = this["stackTrace"] as String,
                screenName = this[TITLE] as String,
                customDimensions = this[CONTENT_OBJECT] as Map<String, Any?>
            )

        "screenview" ->
            Event2.ScreenEvent(
                screenName = this["title"] as String,
                customDimensions = this[CONTENT_OBJECT] as Map<String, Any?>
            )

        "ecommerce_ga4" -> (this[EVENT_DATA] as? Map<String, Any?>)?.let { ecommerceGA4 ->
            Event2.EcommerceGA4EventV2(
                eventName = eventName.toEcommerceGA4Name(),
                ecommerceGA4 = ecommerceGA4.toEcommerceGA4(),
                customParameters = (this[CUSTOM_DATA] as? Map<String, Any?>?)?.let {
                    HashMap(it)
                }
            )
        }

        "ecommerce_ua" -> (this[EVENT_DATA] as? Map<String, Any?>)?.let { ecommerceUA ->
            Event2.EcommerceUAEventV2(
                eventName = eventName.toEcommerceUAName(),
                ecommerceUA = ecommerceUA.toEcommerceUA(),
                ecommerceParameters = (this[ECOMMERCE_PARAMETERS] as? Map<String, Any?>?)?.let {
                    HashMap(it)
                },
                customParameters = (this[CUSTOM_DATA] as? Map<String, Any?>?)?.let {
                    HashMap(it)
                }
            )
        }

        else ->
            Event2.CustomEvent(
                screenName = this[TITLE] as String,
                eventName = eventName,
                customDimensions = this[CONTENT_OBJECT] as Map<String, Any?>
            )
    }
}

private const val EVENT_DATA = "eventData"
private const val TITLE = "title"
private const val CONTENT_OBJECT = "contentObject"
private const val CUSTOM_DATA = "customData"
private const val ECOMMERCE_PARAMETERS = "ecommerceParameters"