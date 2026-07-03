//begin tambahkan kode dibawah ini untuk proses upload ke playstore
import java.util.Properties
val keystoreProperties = Properties().apply {
 val f = rootProject.file("key.properties")
 if (f.exists()) {
 load(f.inputStream())
 }
}
//end tambahkan kode dibawah ini untuk proses upload ke playstore

plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    // END: FlutterFire Configuration
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.ppkd.sintakqu"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.ppkd.sintakqu"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

//begin tambahkan kode berikut untuk membaca file release-key dan key.propertease
    signingConfigs {
     if (keystoreProperties.isNotEmpty()) {
            create("release") {
                keyAlias = keystoreProperties["keyAlias"] as String
                keyPassword = keystoreProperties["keyPassword"] as String
                storeFile = file(keystoreProperties["storeFile"] as String)
                storePassword = keystoreProperties["storePassword"] as String
            }
        }
   
  }
  //end tambahkan kode berikut untuk membaca file release-key dan key.propertease

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
           // signingConfig = signingConfigs.getByName("debug")
           signingConfig = signingConfigs.getByName("release") //ganti ke mode release untuk playstore
        }
    }
}

flutter {
    source = "../.."
}
