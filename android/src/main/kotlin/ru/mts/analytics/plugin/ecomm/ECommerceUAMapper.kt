package ru.mts.analytics.plugin.ecomm

import ru.mts.analytics.sdk.publicapi.event2.ecommercecontract.ua.ActionField
import ru.mts.analytics.sdk.publicapi.event2.ecommercecontract.ua.Add
import ru.mts.analytics.sdk.publicapi.event2.ecommercecontract.ua.Checkout
import ru.mts.analytics.sdk.publicapi.event2.ecommercecontract.ua.CheckoutOption
import ru.mts.analytics.sdk.publicapi.event2.ecommercecontract.ua.Click
import ru.mts.analytics.sdk.publicapi.event2.ecommercecontract.ua.Detail
import ru.mts.analytics.sdk.publicapi.event2.ecommercecontract.ua.EcommerceUA
import ru.mts.analytics.sdk.publicapi.event2.ecommercecontract.ua.EcommerceUAName
import ru.mts.analytics.sdk.publicapi.event2.ecommercecontract.ua.Impressions
import ru.mts.analytics.sdk.publicapi.event2.ecommercecontract.ua.Product
import ru.mts.analytics.sdk.publicapi.event2.ecommercecontract.ua.PromoClick
import ru.mts.analytics.sdk.publicapi.event2.ecommercecontract.ua.PromoView
import ru.mts.analytics.sdk.publicapi.event2.ecommercecontract.ua.Promotion
import ru.mts.analytics.sdk.publicapi.event2.ecommercecontract.ua.Purchase
import ru.mts.analytics.sdk.publicapi.event2.ecommercecontract.ua.Refund
import ru.mts.analytics.sdk.publicapi.event2.ecommercecontract.ua.Remove

internal fun String.toEcommerceUAName(): EcommerceUAName =
    when (this) {
        "purchase" -> EcommerceUAName.Purchase()
        "add" -> EcommerceUAName.Add()
        "checkout_option" -> EcommerceUAName.CheckoutOption()
        "checkout" -> EcommerceUAName.Checkout()
        "refund" -> EcommerceUAName.Refund()
        "remove" -> EcommerceUAName.Remove()
        "click" -> EcommerceUAName.Click()
        "promo_click" -> EcommerceUAName.PromoClick()
        "detail" -> EcommerceUAName.Detail()
        "impressions" -> EcommerceUAName.Impressions()
        "promo_view" -> EcommerceUAName.PromoView()
        else -> EcommerceUAName.Add()
    }

internal fun Map<String, Any?>.toEcommerceUA(): EcommerceUA =
    EcommerceUA(
        currencyCode = this["currencyCode"] as? String?,
        purchase = getMapOrNull("purchase")?.let { purchase ->
            Purchase(
                actionField = purchase.toActionField(),
                products = purchase.toListProduct()
            )
        },
        checkoutOption = getMapOrNull("checkoutOption")?.let { checkoutOption ->
            CheckoutOption(
                actionField = checkoutOption.toActionField(),
                products = checkoutOption.toListProduct()
            )
        },
        checkout = getMapOrNull("checkout")?.let { checkout ->
            Checkout(
                actionField = checkout.toActionField(),
                products = checkout.toListProduct()
            )
        },
        add = getMapOrNull("add")?.let { add ->
            Add(
                actionField = add.toActionField(),
                products = add.toListProduct()
            )
        },
        refund = getMapOrNull("refund")?.let { refund ->
            Refund(
                actionField = refund.toActionField(),
                products = refund.toListProduct()
            )
        },
        remove = getMapOrNull("remove")?.let { refund ->
            Remove(
                actionField = refund.toActionField(),
                products = refund.toListProduct()
            )
        },
        detail = getMapOrNull("detail")?.let { detail ->
            Detail(
                actionField = detail.toActionField(),
                products = detail.toListProduct()
            )
        },
        click = getMapOrNull("click")?.let { click ->
            Click(
                actionField = click.toActionField(),
                products = click.toListProduct()
            )
        },
        promoClick = getMapOrNull("promoClick")?.toListPromotion()?.let { promotions ->
            PromoClick(promotions)
        },
        promoView = getMapOrNull("promoView")?.toListPromotion()?.let { promotions ->
            PromoView(promotions)
        },
        impressions = getMapOrNull("impressions")?.toListProduct()?.let { products ->
            Impressions(products)
        }
    )

internal fun Map<String, Any?>.toActionField(): ActionField? =
    try {
        (this["actionField"] as? Map<*, *>)?.let { actionField ->
            ActionField(
                id = actionField["id"] as? String,
                affiliation = actionField["affiliation"] as? String?,
                revenue = actionField["revenue"] as? String,
                tax = actionField["tax"] as? String?,
                shipping = actionField["shipping"] as? String?,
                coupon = actionField["coupon"] as? String?,
                step = actionField["step"] as? String?,
                option = actionField["option"] as? String?,
                list = actionField["list"] as? String?,
                parameters = @Suppress("UNCHECKED_CAST") (actionField["parameters"] as? HashMap<String, Any?>?)
            )
        }
    } catch (e: Exception) {
        null
    }

internal fun Map<String, Any?>.toListProduct(): List<Product>? =
    try {
        @Suppress("UNCHECKED_CAST")
        (this["products"] as? List<Map<String, Any?>>?)?.mapNotNull { it.toProduct() }
    } catch (e: Exception) {
        null
    }

internal fun Map<String, Any?>.toProduct(): Product? =
    try {
        Product(
            id = this["id"] as String,
            name = this["name"] as String,
            price = this["price"] as? String?,
            brand = this["brand"] as? String?,
            category = this["category"] as? String?,
            variant = this["variant"] as? String?,
            quantity = this["quantity"] as? String?,
            coupon = this["coupon"] as? String?,
            list = this["list"] as? String?,
            position = this["position"] as? String?,
            parameters = @Suppress("UNCHECKED_CAST")
            (this["parameters"] as? HashMap<String, Any?>?)
        )
    } catch (e: Exception) {
        null
    }

internal fun Map<String, Any?>.toListPromotion(): List<Promotion>? =
    try {
        @Suppress("UNCHECKED_CAST")
        (this["promotion"] as? List<Map<String, Any?>>)?.mapNotNull { it.toPromotion() }
    } catch (e: Exception) {
        null
    }

internal fun Map<String, Any?>.toPromotion(): Promotion? =
    try {
        Promotion(
            id = this["id"] as String,
            name = this["name"] as String,
            creative = this["position"] as? String?,
            position = this["position"] as? String?,
        )
    } catch (e: Exception) {
        null
    }


@Suppress("UNCHECKED_CAST")
internal fun Map<String, Any?>.getMapOrNull(key: String): Map<String, Any?>? =
    (this["ecommerce"] as? Map<String, Any?>?)?.get(key) as? Map<String, Any?>