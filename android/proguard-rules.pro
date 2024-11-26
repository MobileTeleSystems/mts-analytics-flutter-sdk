# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# proguardFiles setting in build.gradle.kts.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

# Uncomment this to preserve the line number information for
# debugging stack traces.
#-keepattributes SourceFile,LineNumberTable

# If you keep the line number information, uncomment this to
# hide the original source file name.
#-keep class ru.mts.analytics.** { *;}
#
#-keep class MtsAnalyticsPlugin.** { *;}
#
#-keep class mts_analytics_plugin.** { *;}
#
#-keep class ru.mts.analytics.sdk.emitter.dao.**{*;}
#
#-keep class * {
#    public private *;
#}
#
#-keep class com.google.protobuf.**
## protobuf
#-keepclassmembers public class * extends com.google.protobuf.MessageLite {*;}
#-keepclassmembers public class * extends com.google.protobuf.MessageOrBuilder {*;}
#-keep public class google.** implements com.google.protobuf.MessageLiteOrBuilder { *; }
#-keep public class com.google.type.** implements com.google.protobuf.MessageLiteOrBuilder { *; }
#-keep public class com.google.protobuf.** implements com.google.protobuf.MessageLiteOrBuilder { *; }
#-keep public class * extends com.google.protobuf.GeneratedMessage { *; }
#-keep class * extends com.google.protobuf.GeneratedMessageLite { *; }
#-keep class com.google.protobuf.** { *; }
#-keep public class * extends com.google.protobuf.** { *; }
#-keep class com.google.protobuf.** { *; }
#-keep class com.google.protobuf.**$* { *; }
#
#-keep interface * extends com.google.protobuf.MessageLiteOrBuilder{*;}
#-keep class * extends com.google.protobuf.GeneratedMessageLite{*;}
#-keep class * implements ListMapsFieldOrBuilder{*;}
#-keep class * implements MapFieldOrBuilder{*;}
#-keep class * implements MessageRequestOrBuilder{*;}
#-keep enum * implements com.google.protobuf.Internal.EnumLite{*;}
#
#
##Flutter Wrapper
#-keep class io.flutter.app.** { *; }
#-keep class io.flutter.plugin.**  { *; }
#-keep class io.flutter.util.**  { *; }
#-keep class io.flutter.view.**  { *; }
#-keep class io.flutter.**  { *; }
#-keep class io.flutter.plugins.**  { *; }
#
## General
#-keepattributes *Annotation*
#-keepattributes LineNumberTable
#
## MTS Analytics
#-dontwarn ru.mts.analytics.**
#-keep interface ru.mts.analytics.sdk.** { *; }
#-keep class ru.mts.analytics.sdk.publicapi.** { *; }
#-keep class ru.mts.analytics.sdk.proto.** { *; }
#-keep class ru.mts.analytics.sdk.logger.** { *; }
#-keep class ru.mts.analytics.sdk.model.** { *; }
#-keep class ru.mts.analytics.sdk.** { *; }
#
#
#
#-keep class io.flutter.app.** { *; }
#-keep class io.flutter.plugin.** { *; }
#-keep class io.flutter.util.** { *; }
#-keep class io.flutter.view.** { *; }
#-keep class io.flutter.** { *; }
#-keep class io.flutter.plugins.** { *; }
#
#-keep class com.google.firebase.** { *; }
#
## Retrofit
#-keepattributes Signature
#-keepattributes Exceptions
#
## OkHTTP
#-dontwarn okhttp3.**
#-keep class okhttp3.**{ *; }
#-keep interface okhttp3.**{ *; }
#
## Other
#-keepattributes *Annotation*
#-keepattributes SourceFile, LineNumberTable
#
## Logging
#-assumenosideeffects class android.util.Log {
#    public static *** d(...);
#    public static *** v(...);
#    public static *** i(...);
#    public static *** w(...);
#    public static *** e(...);
#    public static *** wtf(...);
#}
#
#-assumenosideeffects class io.flutter.Log {
#    public static *** d(...);
#    public static *** v(...);
#    public static *** w(...);
#    public static *** e(...);
#}
#
#-assumenosideeffects class java.util.logging.Level {
#    public static *** w(...);
#    public static *** d(...);
#    public static *** v(...);
#}
#
#-assumenosideeffects class java.util.logging.Logger {
#    public static *** w(...);
#    public static *** d(...);
#    public static *** v(...);
#}
#
## Removes third parties logging
#-assumenosideeffects class org.slf4j.Logger {
#    public *** trace(...);
#    public *** debug(...);
#    public *** info(...);
#    public *** warn(...);
#    public *** error(...);
#}
#
#
#
## General
#-keepattributes *Annotation*
#-keepattributes LineNumberTable
#
## MTS Analytics
#-dontwarn ru.mts.analytics.**
#-keep interface ru.mts.analytics.sdk.** { *; }
#-keep class ru.mts.analytics.sdk.publicapi.** { *; }
#-keep class ru.mts.analytics.sdk.proto.** { *; }
#-keep class ru.mts.analytics.sdk.logger.** { *; }
#-ignorewarnings
#-keep class * {
#    public private *;
#}
#-keepattributes *Annotation*
#-keepattributes LineNumberTable
#
## MTS Analytics
#-keep interface ru.mts.analytics.sdk. { *; }
#-keep class ru.mts.analytics.sdk. { *; }
#
#-ignorewarnings
#-keep class * {
#    public private *;
#}
#
#-keep class com.google.protobuf.MessageSchema.*{*;}
#
#-keep class h6.* { *; }
