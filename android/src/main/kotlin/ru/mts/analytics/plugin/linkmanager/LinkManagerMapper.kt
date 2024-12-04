package ru.mts.analytics.plugin.linkmanager

import ru.mts.analytics.sdk.publicapi.api.apicontract.DeepLinkResult

internal fun DeepLinkResult.toMap() = when (this) {
    is DeepLinkResult.Success -> {
        mapOf(
            TYPE to TYPE_SUCCESS,
            "location" to location,
            "params" to params,
        )
    }

    is DeepLinkResult.Error -> {
        mapOf(
            TYPE to TYPE_ERROR,
            "error" to error.message,
        )
    }

    else -> {
        mapOf(
            TYPE to TYPE_ERROR,
            "error" to "Result is not valid",
        )
    }
}

private const val TYPE = "type"
private const val TYPE_ERROR = "error"
private const val TYPE_SUCCESS = "success"