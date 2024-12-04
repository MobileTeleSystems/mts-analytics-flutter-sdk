package ru.mts.analytics.plugin.ecomm

import ru.mts.analytics.sdk.publicapi.event2.ecommercecontract.g4.EcommerceGA4
import ru.mts.analytics.sdk.publicapi.event2.ecommercecontract.g4.EcommerceGA4Item
import ru.mts.analytics.sdk.publicapi.event2.ecommercecontract.g4.EcommerceGA4Name

internal fun String.toEcommerceGA4Name(): EcommerceGA4Name =
    when (this) {
        "add_payment_info" -> EcommerceGA4Name.AddPaymentInfo()
        "add_shipping_info" -> EcommerceGA4Name.AddShippingInfo()
        "add_to_cart" -> EcommerceGA4Name.AddToCart()
        "add_to_wishlist" -> EcommerceGA4Name.AddToWishlist()
        "begin_checkout" -> EcommerceGA4Name.BeginCheckout()
        "purchase" -> EcommerceGA4Name.Purchase()
        "refund" -> EcommerceGA4Name.Refund()
        "remove_from_cart" -> EcommerceGA4Name.RemoveFromCart()
        "select_item" -> EcommerceGA4Name.SelectItem()
        "select_promotion" -> EcommerceGA4Name.SelectPromotion()
        "view_cart" -> EcommerceGA4Name.ViewCart()
        "view_item" -> EcommerceGA4Name.ViewItem()
        "view_item_list" -> EcommerceGA4Name.ViewItemList()
        "view_promotion" -> EcommerceGA4Name.ViewPromotion()
        else -> EcommerceGA4Name.AddPaymentInfo()
    }

@Suppress("UNCHECKED_CAST")
internal fun Map<String, Any?>.toEcommerceGA4(): EcommerceGA4 = EcommerceGA4(
    transactionId = this["transactionId"] as? String?,
    affiliation = this["affiliation"] as? String?,
    value = this["value"] as? String?,
    currency = this["currency"] as? String?,
    tax = this["tax"] as? String?,
    shipping = this["shipping"] as? String?,
    shippingTier = this["shippingTier"] as? String?,
    paymentType = this["paymentType"] as? String?,
    coupon = this["coupon"] as? String?,
    itemListName = this["itemListName"] as? String?,
    itemListId = this["itemListId"] as? String?,
    creativeName = this["creativeName"] as? String?,
    creativeSlot = this["creativeSlot"] as? String?,
    promotionId = this["promotionId"] as? String?,
    promotionName = this["promotionName"] as? String?,
    parameters = this["parameters"] as? HashMap<String, Any?>?,
    items = (this["items"] as? List<Map<String, Any?>>)?.map { it.toEcommerceGA4Item() } ?: listOf()
)

internal fun Map<String, Any?>.toEcommerceGA4Item() =
    @Suppress("UNCHECKED_CAST")
    EcommerceGA4Item(
        itemId = this["itemId"] as String,
        itemName = this["itemName"] as String,
        itemListName = this["itemListName"] as? String?,
        itemListId = this["itemListId"] as? String?,
        index = this["index"] as? String?,
        itemBrand = this["itemBrand"] as? String?,
        itemCategory = this["itemCategory"] as? String?,
        itemCategory2 = this["itemCategory2"] as? String?,
        itemCategory3 = this["itemCategory3"] as? String?,
        itemCategory4 = this["itemCategory4"] as? String?,
        itemCategory5 = this["itemCategory5"] as? String?,
        itemVariant = this["itemVariant"] as? String?,
        affiliation = this["affiliation"] as? String?,
        discount = this["discount"] as? String?,
        coupon = this["coupon"] as? String?,
        price = this["price"] as? String?,
        currency = this["currency"] as? String?,
        quantity = this["quantity"] as? String?,
        locationId = this["locationId"] as? String?,
        creativeName = this["creativeName"] as? String?,
        creativeSlot = this["creativeSlot"] as? String?,
        promotionId = this["promotionId"] as? String?,
        promotionName = this["promotionName"] as? String?,
        parameters = (this["customData"] as? HashMap<String, Any?>?)
    )
