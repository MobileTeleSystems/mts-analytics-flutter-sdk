package ru.mts.analytics.plugin.remoteconfig

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineExceptionHandler
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.launch
import ru.mts.analytics.sdk.publicapi.api.MtsAnalyticsApi
import ru.mts.analytics.sdk.publicapi.remoteconfig.MARemoteConfigCfg
import ru.mts.analytics.sdk.publicapi.remoteconfig.MARemoteConfigResult

internal class RemoteConfigMapper(
    private val mtsAnalytics: MtsAnalyticsApi,
    private val coroutineScope: CoroutineScope
) {

    private val exceptionHandler: (MethodChannel.Result, Throwable) -> Unit = { result, throwable ->
        result.error(
            throwable.message ?: "",
            throwable.stackTrace.contentToString(),
            throwable.cause
        )
    }

    fun getDefaultConfigValue(call: MethodCall, result: MethodChannel.Result) {
        coroutineScope.launch(
            CoroutineExceptionHandler { _, throwable ->
                exceptionHandler(result, throwable)
            }
        ) {
            call.argument<String?>("key")?.let { key ->
                result.success(
                    mtsAnalytics
                        .remoteConfig
                        .defaultConfig
                        .value
                        ?.data
                        ?.get(key)
                )
            } ?: result.success(null)
        }
    }

    fun getActiveConfig(call: MethodCall, result: MethodChannel.Result) {
        coroutineScope.launch(
            CoroutineExceptionHandler { _, throwable ->
                exceptionHandler(result, throwable)
            }
        ) {
            call.argument<String?>("key")?.let { key ->
                result.success(
                    mtsAnalytics
                        .remoteConfig
                        .activeConfig
                        .value
                        ?.data
                        ?.get(key)
                )
            } ?: result.success(null)
        }
    }

    fun setDefaultsMap(call: MethodCall, result: MethodChannel.Result) {
        coroutineScope.launch(
            CoroutineExceptionHandler { _, throwable ->
                exceptionHandler(result, throwable)
            }
        ) {
            call.argument<Map<String, String>>("parameters")?.let { map ->
                mtsAnalytics
                    .remoteConfig
                    .setDefaults(map)
            }
            result.success(null)
        }
    }

    fun fetchRemoteConfigValues(result: MethodChannel.Result) {
        coroutineScope.launch(
            CoroutineExceptionHandler { _, throwable ->
                exceptionHandler(result, throwable)
            }
        ) {
            result.success(
                mtsAnalytics
                    .remoteConfig
                    .fetchRemoteConfigValues().toMap()
            )
        }
    }

    fun fetchRemoteConfigValuesAndActivate(result: MethodChannel.Result) {
        coroutineScope.launch(
            CoroutineExceptionHandler { _, throwable ->
                exceptionHandler(result, throwable)
            }
        ) {
            mtsAnalytics
                .remoteConfig
                .fetchRemoteConfigValuesAndActivate()
            result.success(null)
        }
    }

    fun activate(result: MethodChannel.Result) {
        coroutineScope.launch(
            CoroutineExceptionHandler { _, throwable ->
                exceptionHandler(result, throwable)
            }
        ) {
            mtsAnalytics
                .remoteConfig
                .activate()
            result.success(null)
        }
    }

    fun minFetchInterval(call: MethodCall, result: MethodChannel.Result) {
        coroutineScope.launch(
            CoroutineExceptionHandler { _, throwable ->
                exceptionHandler(result, throwable)
            }
        ) {
            call.argument<Number>("interval")?.let { interval ->
                mtsAnalytics
                    .remoteConfig
                    .maRemoteConfigCfg = MARemoteConfigCfg(
                    remoteConfigFetchInterval = interval.toLong()
                )
            }
            result.success(null)
        }
    }

    private fun MARemoteConfigResult.toMap() = when (this) {
        is MARemoteConfigResult.Success -> {
            mapOf(
                TYPE_KEY_RC_RESULT to TYPE_SUCCESS,
            )
        }

        is MARemoteConfigResult.Throttle -> {
            mapOf(
                TYPE_KEY_RC_RESULT to TYPE_THROTTLE,
            )
        }

        is MARemoteConfigResult.Failure -> {
            mapOf(
                TYPE_KEY_RC_RESULT to TYPE_FAILURE,
                "error" to error.message,
            )
        }

        else -> {
            mapOf(
                TYPE_KEY_RC_RESULT to TYPE_FAILURE,
                "error" to "Result is not valid",
            )
        }
    }

    companion object {
        private const val TYPE_KEY_RC_RESULT = "type"
        private const val TYPE_FAILURE = "failure"
        private const val TYPE_THROTTLE = "throttle"
        private const val TYPE_SUCCESS = "success"
    }
}