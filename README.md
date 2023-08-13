# Viridian
[![Flutter Build](https://github.com/conrad-mo/viridian/actions/workflows/main.yml/badge.svg?branch=master)](https://github.com/conrad-mo/viridian/actions/workflows/main.yml)
![Github releases](https://img.shields.io/github/v/release/conrad-mo/viridian)
![Github License](https://img.shields.io/github/license/conrad-mo/viridian)

A chat app built with flutter and firebase

![Screenshot of Viridian Homescreen in Light Mode](.github/light.png?raw=true)
![Screenshot of Viridian Chatscreen in Dark Mode](.github/dark.png?raw=true)

## Installation

Download from [releases](https://github.com/conrad-mo/viridian/releases).

- iOS: Download the ipa. Sideload the ipa onto your device via [altstore](https://altstore.io/) or other signing tools/services.
- Android: Download the appbundle or apk for your respective device architecture. Sideload the app onto your device by opening it on your device

## Building and setup

### For apple silicon macs
```bash
cd ios
pod repo update
arch -x86_64 pod install
```
### For non apple silicon macs
```bash
cd ios
pod repo update
pod install
```

## Troubleshooting while compiling

### If following warning related to "initialize an object with an unknown UDID" occurs during pod install
```bash
pod deintegrate Runner.xcodeproj
pod repo update

#for intel macs
pod install

#for apple silicon macs
arch -x86_64 pod install
```

### Issues related to linking firebase and generating hashes for android with lts jdk (11.x.x)
```bash
flutterfire configure
cd android
keytool -genkey -v -keystore ~/.android/debug.keystore -storepass android -alias androiddebugkey -keypass android -dname "CN=Android Debug,O=Android,C=US"
./gradlew signingReport
```
