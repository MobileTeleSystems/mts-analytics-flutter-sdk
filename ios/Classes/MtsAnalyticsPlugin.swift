import Flutter
import Foundation
import MTMetrics
import CoreLocation

public class MtsAnalyticsPlugin: NSObject, FlutterPlugin {
    
    private let flutterErrorCode = "MTSACallsHandlerError"
    private var mtsAnalytics: MTAnalyticsProvider?
    private var logLevel: MTLogLevel?

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "mts_analytics_plugin", binaryMessenger: registrar.messenger())
        let instance = MtsAnalyticsPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "init":
            handleGetInstanceWithConfiguration(call: call, result: result)
        case "updateConfig":
            handleUpdateConfiguration(call: call, result: result)
        case "track":
            handleTrack(call: call, result: result)
        case "trackUri":
            handleTrackUri(call: call, result: result)
        case "resolveLink":
            handleResolveLink(call: call, result: result)
        case "sendAuthenticationEvent":
            handleSendAuthenticationEvent(call: call, result: result)
        case "getWebSessionQuery":
            handleGetWebSessionQueryItem(call: call, result: result)
        case "setLocation":
            handleSetLocation(call: call, result: result)
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    private func handleGetInstanceWithConfiguration(call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let arguments = call.arguments as? [String: Any],
              let params = arguments["parameters"] as? [String: Any]
        else {
            result(FlutterError(code: flutterErrorCode, message: "Wrong args", details: nil))
            return
        }

        guard let configuration = configureMtsAnalyticsConfig(params) else {
            result(FlutterError(code: flutterErrorCode, message: "Missing analytics configuration", details: nil))
            return
        }

        mtsAnalytics = MTAnalytics.getInstance(configuration: configuration)
        mtsAnalytics?.logLevel = logLevel ?? MTLogLevel.off
        result(0)
    }

    private func handleUpdateConfiguration(call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let mtsAnalytics = mtsAnalytics else {
            result(FlutterError(code: flutterErrorCode, message: "Tracker has not been initialised", details: nil))
            return
        }

        guard let arguments = call.arguments as? [String: Any],
              let params = arguments["parameters"] as? [String: Any] else {
            result(FlutterError(code: flutterErrorCode, message: "Wrong args", details: nil))
            return
        }

        guard let configuration = configureMtsAnalyticsConfig(params) else {
            result(FlutterError(code: flutterErrorCode, message: "Missing analytics configuration", details: nil))
            return
        }

        mtsAnalytics.logLevel = logLevel ?? MTLogLevel.off
        mtsAnalytics.update(with: configuration)
        result(0)
    }
    
    private func handleTrack(call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let mtsAnalytics = mtsAnalytics else {
            result(FlutterError(code: flutterErrorCode, message: "Tracker has not been initialised", details: nil))
            return
        }

        guard let arguments = call.arguments as? [String: Any],
              let params = arguments["parameters"] as? [String: Any]
        else {
            result(FlutterError(code: flutterErrorCode, message: "Wrong args", details: nil))
            return
        }

        let eventName = params["event"] as? String
        let eventType = params["eventType"] as? String
        let screenName = params["title"] as? String
        let contentObject = params["contentObject"] as? [String: Any]

        guard let eventType = eventType else {
             result(FlutterError(code: flutterErrorCode, message: "Missing event type", details: nil))
             return
         }
        
        switch eventType {
        case "custom_error":
            let error = MTError(
                errorName: eventName ?? "",
                stacktrace: params["stackTrace"] as? String,
                parameters: contentObject
            )
            mtsAnalytics.track(error: error)
        case "screenview":
            let screenEvent = MTScreen(
                eventName: eventName ?? "",
                screenName: screenName,
                parameters: contentObject
            )
            mtsAnalytics.track(event: screenEvent)
        case "ecommerce_ga4":
            let event = convertECommerceGA4Event(params, eventName ?? "")
            mtsAnalytics.track(event: event)
        case "ecommerce_ua":
            let event = convertECommerceUAEvent(params, eventName ?? "")
            mtsAnalytics.track(event: event)
        default:
            let customEvent = MTCustomEvent(
                eventType: .custom(name: eventType),
                eventName: eventName ?? "",
                screenName: screenName,
                parameters: contentObject
            )
            mtsAnalytics.track(event: customEvent)
        }
        
        result(0)
    }
    
    private func handleTrackUri(call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let mtsAnalytics = mtsAnalytics else {
            result(FlutterError(code: flutterErrorCode, message: "Tracker has not been initialised", details: nil))
            return
        }

        guard let arguments = call.arguments as? [String: Any],
              let uriString = arguments["uri"] as? String,
              let url = URL(string: uriString)
        else {
            result(FlutterError(code: flutterErrorCode, message: "Wrong args", details: nil))
            return
        }
        
        let customParameters = arguments["map"] as? [String: Any?]
        
        mtsAnalytics.track(url: url, parameters: customParameters)
        result(0)
    }

    private func handleResolveLink(call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let mtsAnalytics = mtsAnalytics else {
            result(FlutterError(code: flutterErrorCode, message: "Tracker has not been initialised", details: nil))
            return
        }

        guard let arguments = call.arguments as? [String: Any],
           let uriString = arguments["uri"] as? String,
           let url = URL(string: uriString)
        else {
            result(FlutterError(code: flutterErrorCode, message: "Wrong args", details: nil))
            return
        }

        mtsAnalytics.resolveLink(url: url) { resolveResult in
            switch resolveResult {
            case .success(let link):
                let success: [String: Any] = [
                    "type": "success",
                    "location": link.location,
                    "params": link.params
                ]
                result(success)
            case .failure(let error):
                let error: [String: Any] = [
                    "type": "error",
                    "error": error.localizedDescription
                ]
                result(error)
            }
        }
    }

    private func handleSendAuthenticationEvent(call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let mtsAnalytics = mtsAnalytics else {
            result(FlutterError(code: flutterErrorCode, message: "Tracker has not been initialised", details: nil))
            return
        }

        guard let arguments = call.arguments as? [String: Any],
              let ssoState = arguments["ssoState"] as? String
        else {
            result(FlutterError(code: flutterErrorCode, message: "Wrong args", details: nil))
            return
        }

        let redirectUrl = arguments["redirectUrl"] as? String

        mtsAnalytics.sendAuthenticationEvent(ssoState: ssoState, redirectUrl: redirectUrl)
        result(0)
    }

    private func handleGetWebSessionQueryItem(call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let mtsAnalytics = mtsAnalytics else {
            result(FlutterError(code: flutterErrorCode, message: "Tracker has not been initialised", details: nil))
            return
        }

        guard let arguments = call.arguments as? [String: Any],
              let url = arguments["url"] as? String,
              let queryItem = mtsAnalytics.webSessionQueryItem(url: url),
              let queryItemValue = queryItem.value
        else {
            result(FlutterError(code: flutterErrorCode, message: "Wrong args", details: nil))
            return
        }

        result("\(queryItem.name):\(queryItemValue)")
    }

    private func handleSetLocation(call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let mtsAnalytics = mtsAnalytics else {
            result(FlutterError(code: flutterErrorCode, message: "Tracker has not been initialised", details: nil))
            return
        }

        guard let arguments = call.arguments as? [String: Any],
              let latitude = arguments["latitude"] as? Double,
              let longitude = arguments["longitude"] as? Double
        else {
            result(FlutterError(code: flutterErrorCode, message: "Wrong args", details: nil))
            return
        }

        mtsAnalytics.setLocation(CLLocation(latitude: latitude, longitude: longitude))
        result(0)
    }

    private func configureMtsAnalyticsConfig(_ parameters: [String: Any]) -> MTAnalyticsConfiguration? {
        guard let flowId = parameters["iosFlowId"] as? String else { return nil }
        var configuration = MTAnalyticsConfiguration(flowId: flowId)

        if let flowId = parameters["iosFlowId"] as? String {
            configuration = MTAnalyticsConfiguration(flowId: flowId)
        }
        if let activeTimeout = parameters["activeTimeout"] as? Int {
            configuration.activeTimeout = activeTimeout
        }
        if let backgroundTimeout = parameters["backgroundTimeout"] as? Int {
            configuration.backgroundTimeout = backgroundTimeout
        }
        if let eventStorageLimit = parameters["eventStorageLimit"] as? Int {
            configuration.eventStorageLimit = eventStorageLimit
        }
        if let networkTrafficEnabled = parameters["networkTrafficEnabled"] as? Int {
            configuration.networkTraffic = networkTrafficEnabled == 0 ? .off : .on
        }
        if let logLevelInt = parameters["logLevel"] as? Int {
            logLevel = logLevelInt.toLogLevel
        }
        return configuration
    }
}

// MARK: ECommerce configuration

private extension MtsAnalyticsPlugin {
    private func convertECommerceGA4Event(_ parameters: [String: Any?], _ eventName: String) -> MTECommerceGA4Event {
        var eventParams = parameters["eventData"] as? [String: Any]
        let transactionId = eventParams?["transactionId"] as? String
        let affliation = eventParams?["affiliation"] as? String
        let value = eventParams?["value"] as? String
        let currency = eventParams?["currency"] as? String
        let tax = eventParams?["tax"] as? String
        let shipping = eventParams?["shipping"] as? String
        let shippingTier = eventParams?["shippingTier"] as? String
        let paymentType = eventParams?["paymentType"] as? String
        let coupon = eventParams?["coupon"] as? String
        let itemListName = eventParams?["itemListName"] as? String
        let itemListId = eventParams?["itemListId"] as? String
        let creativeName = eventParams?["creativeName"] as? String
        let creativeSlot = eventParams?["creativeSlot"] as? String
        let promotionId = eventParams?["promotionId"] as? String
        let promotionName = eventParams?["promotionName"] as? String
        var ecomData = eventParams?["customData"] as? [String: Any?]
        let pluginVersion = ecomData?.removeValue(forKey: "ma_flutter_plg_version") as? String

        let items = (eventParams?.removeValue(forKey: "items") as? [[String: Any]])?.compactMap { itemData in
            let itemId = itemData["itemId"] as? String
            let itemName = itemData["itemName"] as? String
            let itemListName = itemData["itemListName"] as? String
            let itemListId = itemData["itemListId"] as? String
            let index = itemData["index"] as? String
            let itemBrand = itemData["itemBrand"] as? String
            let itemCategory = itemData["itemCategory"] as? String
            let itemCategory2 = itemData["itemCategory2"] as? String
            let itemCategory3 = itemData["itemCategory3"] as? String
            let itemCategory4 = itemData["itemCategory4"] as? String
            let itemCategory5 = itemData["itemCategory5"] as? String
            let itemVariant = itemData["itemVariant"] as? String
            let affiliation = itemData["affiliation"] as? String
            let discount = itemData["discount"] as? String
            let coupon = itemData["coupon"] as? String
            let price = itemData["price"] as? String
            let currency = itemData["currency"] as? String
            let quantity = itemData["quantity"] as? String
            let locationId = itemData["locationId"] as? String
            let creativeName = itemData["creativeName"] as? String
            let creativeSlot = itemData["creativeSlot"] as? String
            let promotionId = itemData["promotionId"] as? String
            let promotionName = itemData["promotionName"] as? String
            let customData = itemData["customData"] as? [String: Any]

            if let itemId, let itemName {
                return MTEcommerceGA4EventItem(
                    itemId: itemId,
                    itemName: itemName,
                    itemListName: itemListName,
                    itemListId: itemListId,
                    index: index,
                    itemBrand: itemBrand,
                    itemCategory: itemCategory,
                    itemCategory2: itemCategory2,
                    itemCategory3: itemCategory3,
                    itemCategory4: itemCategory4,
                    itemCategory5: itemCategory5,
                    itemVariant: itemVariant,
                    affiliation: affiliation,
                    discount: discount,
                    coupon: coupon,
                    price: price,
                    currency: currency,
                    quantity: quantity,
                    locationId: locationId,
                    creativeName: creativeName,
                    creativeSlot: creativeSlot,
                    promotionId: promotionId,
                    promotionName: promotionName,
                    parameters: customData
                )
            }
            return nil
        }

       return MTECommerceGA4Event(
            eventName: MTEcommerceGA4EventName(rawValue: eventName) ?? .addPaymentInfo,
            ecommerceParameters: ecomData,
            transactionId: transactionId,
            affiliation: affliation,
            value: value,
            currency: currency,
            tax: tax,
            shipping: shipping,
            shippingTier: shippingTier,
            paymentType: paymentType,
            coupon: coupon,
            itemListName: itemListName,
            itemListId: itemListId,
            items: items,
            creativeName: creativeName,
            creativeSlot: creativeSlot,
            promotionId: promotionId,
            promotionName: promotionName,
            customParameters: ["ma_flutter_plg_version": pluginVersion]
        )
    }

    private func convertECommerceUAEvent(_ parameters: [String: Any?], _ eventName: String) -> MTEcommerceUAEvent {
        let eventParams = parameters["eventData"] as? [String: Any]
        let ecommerceData = eventParams?["ecommerce"] as? [String: Any]
        var ecomParams = eventParams?["customData"] as? [String: Any?]
        let pluginVersion = ecomParams?.removeValue(forKey: "ma_flutter_plg_version") as? String

        let ecommerce = MTECommerceUA(
            purchase: convertPurchase(ecommerceData?["purchase"] as? [String: Any]),
            checkoutOption: convertCheckoutOption(ecommerceData?["purchase"] as? [String: Any]),
            add: convertAdd(ecommerceData?["add"] as? [String: Any]),
            checkout: convertCheckout(ecommerceData?["checkout"] as? [String: Any]),
            refund: convertRefund(ecommerceData?["refund"] as? [String: Any]),
            remove: convertRemove(ecommerceData?["remove"] as? [String: Any]),
            click: convertClick(ecommerceData?["click"] as? [String: Any]),
            promoClick: convertPromoСlick(ecommerceData?["promoClick"] as? [String: Any]),
            detail: convertDetail(ecommerceData?["detail"] as? [String: Any]),
            impressions: convertImpressions(ecommerceData?["impressions"] as? [String: Any]),
            promoView: convertPromoView(ecommerceData?["promoView"] as? [String: Any])
        )
        return MTEcommerceUAEvent(
            eventName: MTEcommerceUAEventName(rawValue: eventName) ?? .add,
            ecommerceParameters: ecommerceData,
            ecommerce: ecommerce,
            currencyCode: eventParams?["currencyCode"] as? String,
            customParameters: ["ma_flutter_plg_version": pluginVersion]
        )
    }

    private func convertPurchase(_ parameters: [String: Any?]?) -> MTECommerceUA.Purchase? {
        if let actionField = parameters?["actionField"] as? [String: Any],
           let products = convertProducts(parameters?["products"] as? [[String: Any]]) {
            return MTECommerceUA.Purchase(actionField: convertActionField(actionField), products: products)
        }
        return nil
    }

    private func convertAdd(_ parameters: [String: Any?]?) -> MTECommerceUA.Add? {
        guard let products = convertProducts(parameters?["products"] as? [[String: Any]]) else {
            return nil
        }
        let actionField = (parameters?["actionField"] as? [String: Any]).flatMap { convertActionField($0) }

        return MTECommerceUA.Add(actionField: actionField, products: products)
    }

    private func convertCheckout(_ parameters: [String: Any?]?) -> MTECommerceUA.Checkout? {
        guard let products = convertProducts(parameters?["products"] as? [[String: Any]]) else {
            return nil
        }
        let actionField = (parameters?["actionField"] as? [String: Any]).flatMap { convertActionField($0) }

        return MTECommerceUA.Checkout(actionField: actionField, products: products)
    }

    private func convertRefund(_ parameters: [String: Any?]?) -> MTECommerceUA.Refund? {
        let actionField = parameters?["actionField"] as? [String: Any]
        guard let actionField else { return nil }
        let products = convertProducts(parameters?["products"] as? [[String: Any]])

        return MTECommerceUA.Refund(actionField: convertActionField(actionField), products: products)
    }

    private func convertRemove(_ parameters: [String: Any?]?) -> MTECommerceUA.Remove? {
        guard let products = convertProducts(parameters?["products"] as? [[String: Any]]) else {
            return nil
        }
        let actionField = (parameters?["actionField"] as? [String: Any]).flatMap { convertActionField($0) }

        return MTECommerceUA.Remove(actionField: actionField, products: products)
    }

    private func convertClick(_ parameters: [String: Any?]?) -> MTECommerceUA.Click? {
        guard let products = convertProducts(parameters?["products"] as? [[String: Any]]) else {
            return nil
        }
        let actionField = (parameters?["actionField"] as? [String: Any]).flatMap { convertActionField($0) }

        return MTECommerceUA.Click(actionField: actionField, products: products)
    }

    private func convertDetail(_ parameters: [String: Any?]?) -> MTECommerceUA.Detail? {
        if let actionField = parameters?["actionField"] as? [String: Any],
           let products = convertProducts(parameters?["products"] as? [[String: Any]]) {
            return MTECommerceUA.Detail(actionField: convertActionField(actionField), products: products)
        }
        return nil
    }

    private func convertImpressions(_ parameters: [String: Any?]?) -> MTECommerceUA.Impressions? {
        guard let products = convertProducts(parameters?["products"] as? [[String: Any]]) else { return nil }
        return MTECommerceUA.Impressions(impressions: products)
    }

    private func convertPromoView(_ parameters: [String: Any?]?) -> MTECommerceUA.PromoView? {
        guard let promotions = convertPromotions(parameters?["promotions"] as? [[String: Any]]) else {
            return nil
        }
        let actionField = (parameters?["actionField"] as? [String: Any]).flatMap { convertActionField($0) }

        return MTECommerceUA.PromoView(actionField: actionField, promotions: promotions)
    }

    private func convertPromoСlick(_ parameters: [String: Any?]?) -> MTECommerceUA.PromoClick? {
        guard let promotions = convertPromotions(parameters?["promotions"] as? [[String: Any]]) else {
            return nil
        }
        let actionField = (parameters?["actionField"] as? [String: Any]).flatMap { convertActionField($0) }

        return MTECommerceUA.PromoClick(actionField: actionField, promotions: promotions)
    }

    private func convertCheckoutOption(_ parameters: [String: Any?]?) -> MTECommerceUA.CheckoutOption? {
        if let actionField = parameters?["actionField"] as? [String: Any] {
            return MTECommerceUA.CheckoutOption(actionField: convertActionField(actionField))
        }
        return nil
    }

    private func convertActionField(_ parameters: [String: Any?]) -> MTECommerceUA.ActionField {
        let id = parameters["id"] as? String
        let affiliation = parameters["affiliation"] as? String
        let revenue = parameters["revenue"] as? String
        let tax = parameters ["tax"] as? String
        let shipping = parameters["shipping"] as? String
        let coupon = parameters["coupon"] as? String
        let step = parameters ["step"] as? String
        let option = parameters["option"] as? String
        let list = parameters["list"] as? String
        let customData = parameters["customData"] as? [String: Any?]

        return MTECommerceUA.ActionField(
            id: id,
            affiliation: affiliation,
            revenue: revenue,
            tax: tax,
            shipping: shipping,
            coupon: coupon,
            step: step,
            option: option,
            list: list,
            parameters: customData
        )
    }

    private func convertProducts(_ parameters: [[String: Any?]]?) -> [MTECommerceUA.Product]? {
        guard let parameters else { return nil }
        var products: [MTECommerceUA.Product] = []
        for product in parameters {
            let name = product["name"] as? String
            let id = product["id"] as? String
            let price = product["price"] as? String
            let brand = product["brand"] as? String
            let category = product["category"] as? String
            let variant = product["variant"] as? String
            let quantity = product["quantity"] as? String
            let coupon = product["coupon"] as? String
            let list = product["list"] as? String
            let position = product["position"] as? String
            let customData = product["customData"] as? [String: Any]

            if let name, let id {
                products.append(
                    MTECommerceUA.Product(
                        name: name,
                        id: id,
                        price: price,
                        brand: brand,
                        category: category,
                        variant: variant,
                        quantity: quantity,
                        coupon: coupon,
                        list: list,
                        position: position,
                        parameters: customData
                    )
                )
            }
        }
        return products.isEmpty ? nil : products
    }

    private func convertPromotions(_ parameters: [[String: Any?]]?) -> [MTECommerceUA.Promotion]? {
        guard let parameters else { return nil }
        var promotions: [MTECommerceUA.Promotion] = []

        for promotion in parameters {
            let id = promotion["id"] as? String
            let name = promotion["name"] as? String
            let creative = promotion["creative"] as? String
            let position = promotion["position"] as? String

            promotions.append(
                MTECommerceUA.Promotion(
                    id: id,
                    name: name,
                    creative: creative,
                    position: position
                )
            )
        }
        return promotions.isEmpty ? nil : promotions
    }
}

extension Int {
    var toLogLevel: MTLogLevel {
        switch self {
            case 0: return .verbose
            case 1: return .debug
            case 2: return .warn
            case 3: return .error
            default: return .off
        }
    }
}
