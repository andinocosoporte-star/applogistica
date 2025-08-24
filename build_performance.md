# Build Performance Optimizations

## Flutter Build Commands

### 1. Release Build (Optimized)
```bash
# Android APK with performance optimizations
flutter build apk --release --target-platform android-arm64

# iOS with performance optimizations
flutter build ios --release --no-codesign

# Web with performance optimizations
flutter build web --release --web-renderer html --dart-define=FLUTTER_WEB_USE_SKIA=true
```

### 2. Performance Analysis Build
```bash
# Enable performance profiling
flutter build apk --profile --analyze-size

# Check bundle size
flutter build apk --analyze-size
```

## Android Optimizations

### 1. ProGuard Configuration
Create `android/app/proguard-rules.pro`:
```proguard
# Flutter specific rules
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }

# Keep your app's main classes
-keep class com.example.catech_inventory_routes.** { *; }

# Remove logging in release
-assumenosideeffects class android.util.Log {
    public static *** d(...);
    public static *** v(...);
}
```

### 2. Gradle Optimizations
Add to `android/app/build.gradle`:
```gradle
android {
    // Enable R8 full mode
    buildTypes {
        release {
            minifyEnabled true
            shrinkResources true
            proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
        }
    }
    
    // Enable multidex for large apps
    defaultConfig {
        multiDexEnabled true
    }
}
```

## iOS Optimizations

### 1. Build Settings
In Xcode, enable:
- Bitcode: Yes
- Optimization Level: Fastest, Smallest [-Os]
- Strip Debug Symbols During Copy: Yes
- Strip Linked Product: Yes

### 2. Podfile Optimizations
Add to `ios/Podfile`:
```ruby
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['ENABLE_BITCODE'] = 'YES'
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
    end
  end
end
```

## Web Optimizations

### 1. Web Renderer
```bash
# Use HTML renderer for better performance
flutter build web --web-renderer html

# Or use CanvasKit for better graphics performance
flutter build web --web-renderer canvaskit
```

### 2. Web-specific Optimizations
```dart
// In main.dart for web
import 'package:flutter/foundation.dart';

void main() {
  if (kIsWeb) {
    // Web-specific optimizations
    WidgetsFlutterBinding.ensureInitialized();
  }
  runApp(MyApp());
}
```

## Performance Monitoring

### 1. Build Time Analysis
```bash
# Measure build time
time flutter build apk --release

# Profile build process
flutter build apk --profile --analyze-size
```

### 2. Bundle Size Analysis
```bash
# Analyze APK size
flutter build apk --analyze-size

# Analyze iOS bundle
flutter build ios --analyze-size
```

## Continuous Integration

### 1. GitHub Actions Performance Build
```yaml
name: Performance Build
on: [push, pull_request]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.19.0'
      
      - name: Build with performance analysis
        run: |
          flutter build apk --release --analyze-size
          flutter build ios --release --analyze-size
```

## Performance Testing

### 1. Run Performance Tests
```bash
# Run all tests including performance
flutter test --coverage

# Run specific performance tests
flutter test test/performance/
```

### 2. Benchmarking
```bash
# Run benchmarks
flutter drive --target=test_driver/performance_test.dart
```

## Summary

These build optimizations will:
- Reduce APK/IPA bundle sizes
- Improve app startup time
- Optimize runtime performance
- Enable better code shrinking
- Provide performance monitoring tools

Remember to test thoroughly after applying optimizations to ensure functionality is preserved.