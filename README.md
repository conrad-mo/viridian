# textsync
A chat app built with flutter and firebase

# Setup

## For M1 macs
```bash
cd ios
arch -x86_64 pod install
```
## For non M1 macs
```bash
cd ios
pod install
```

### If following warning related to "initialize an object with an unknown UDID" occurs during pod install
```bash
pod deintegrate Runner.xcodeproj
pod install
```

## Generating linking firebase (using jdk 11)
```bash
flutterfire configure
cd android
keytool -genkey -v -keystore ~/.android/debug.keystore -storepass android -alias androiddebugkey -keypass android -dname "CN=Android Debug,O=Android,C=US"
./gradlew signingReport
```
