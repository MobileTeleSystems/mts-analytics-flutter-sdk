package ru.mts.analytics.plugin

import android.content.Context
import android.net.Uri
import ru.mts.analytics.plugin.linkmanager.toMap

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.coroutineScope
import kotlinx.coroutines.launch
import kotlinx.coroutines.runBlocking
import ru.mts.analytics.sdk.publicapi.MTSAnalytics
import ru.mts.analytics.sdk.publicapi.config.MtsAnalyticsConfig2
import ru.mts.analytics.sdk.publicapi.api.MtsAnalyticsApi
import ru.mts.analytics.sdk.publicapi.api.apicontract.DeepLinkResult

/** MtsAnalyticsPlugin */
class MtsAnalyticsPlugin : FlutterPlugin, MethodCallHandler {
    private lateinit var channel: MethodChannel
    private var context: Context? = null
    private lateinit var mtsAnalytics: MtsAnalyticsApi
    private val coroutineScope = CoroutineScope(Dispatchers.IO)

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        context = flutterPluginBinding.applicationContext
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "mts_analytics_plugin")
        channel.setMethodCallHandler(this)
    }


    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "init" -> handleGetInstance(call, result)
            "getWebSessionQuery" -> handleGetWebSessionQueryItem(call, result)
            "updateConfig" -> handleUpdateConfig(call, result)
            "track" -> handleTrack(call, result)
            "sendAuthenticationEvent" -> handleSendAuthenticationEvent(call, result)
            "setLocation" -> handleSetLocation(call, result)
            "trackUri" -> handleTrackUri(call, result)
            "resolveLink" -> resolveLink(call, result)
            else -> {
                result.notImplemented()
            }
        }
    }

    private fun handleGetInstance(call: MethodCall, result: MethodChannel.Result) {
        context?.let {
            val parameters = call.argument("parameters") as? Map<String, Any?>
            val mtsAnalyticsConfig =
                parameters?.toMtsAnalyticsConfig() ?: MtsAnalyticsConfig2.Builder(flowId = "")
                    .build()
            if (mtsAnalyticsConfig.flowId.isEmpty()) {
                throw Exception("flowId is not be empty")
            }
            mtsAnalytics = MTSAnalytics.getInstance(it, mtsAnalyticsConfig)
        }
        result.success(null)
    }

    private fun handleSendAuthenticationEvent(call: MethodCall, result: MethodChannel.Result) {
        val ssoState = call.argument<String>("ssoState") as String
        val redirectUrl = call.argument<String?>("redirectUrl") as String?
        mtsAnalytics.sendAuthenticationEvent(
            ssoState = ssoState,
            redirectUrl = redirectUrl
        )
        result.success(null)
    }

    private fun handleTrack(call: MethodCall, result: Result) {
        val parameters = call.argument("parameters") as? Map<String, Any?>
        parameters?.toEvent()?.let {
            mtsAnalytics.track(it)
        }
        result.success(null)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
        context = null
    }

    private fun handleGetWebSessionQueryItem(call: MethodCall, result: Result) {
        val url = call.argument<String?>("url")
        result.success(mtsAnalytics.getWebSessionQueryItemBlocking(url ?: ""))
    }

    private fun handleUpdateConfig(call: MethodCall, result: Result) {
        val parameters = call.argument<Map<String, Any?>>("parameters")
        parameters?.let {
            mtsAnalytics.updateConfig(it.toMtsAnalyticsConfig())
        }

        result.success(null)
    }

    private fun handleSetLocation(call: MethodCall, result: Result) {
        val latitude = call.argument<Double?>("latitude") as Double?
        val longitude = call.argument<Double?>("longitude") as Double
        mtsAnalytics.setLocation(
            latitude = latitude,
            longitude = longitude
        )
        result.success(null)
    }

    private fun handleTrackUri(call: MethodCall, result: Result) {
        val uriString = call.argument<String>("uri") as String
        val map = call.argument<Map<String, Any?>?>("map") as Map<String, Any?>?
        mtsAnalytics.track(
            uri = Uri.parse(uriString),
            map = map
        )
        result.success(null)
    }

    private fun resolveLink(call: MethodCall, result: Result) {
        coroutineScope.launch {
            runCatching {
                val deepLinkResult =
                    mtsAnalytics.resolveLink(Uri.parse(call.argument<String>("uri")))
                result.success(deepLinkResult.toMap())
            }.onFailure { error ->
                val map = mapOf(
                    "type" to "error",
                    "error" to error.message,
                )
                result.success(map)
            }
        }
    }
}
