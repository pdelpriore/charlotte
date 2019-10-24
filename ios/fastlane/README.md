fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew cask install fastlane`

# Available Actions
## Android
### android release_app
```
fastlane android release_app
```
Run all tasks listed in RELEASE_APP env variable
### android run_task
```
fastlane android run_task
```
Run a gradle task providing task, build_type and flavor options (assembleRelease by default)
### android play_store
```
fastlane android play_store
```
Upload the built APK to the Google Play Store providing a track (default is internal). If the version code of the APK is not higher than the maximum version code on the Google Play Store, do nothing and fail gracefully

----

## iOS
### ios build_beta
```
fastlane ios build_beta
```
Archive and export a new Beta version (Smart&Soft inHouse) that can be deployed to Dispenser
### ios build_ad_hoc
```
fastlane ios build_ad_hoc
```
Archive and export a new Ad Hoc version
### ios build_app_store
```
fastlane ios build_app_store
```
Archive and export a new App Store version to upload using Xcode or Application Loader
### ios create_profiles
```
fastlane ios create_profiles
```
Create keys, certs and profiles for all targets using match
### ios update_profiles
```
fastlane ios update_profiles
```
Force renew keys, certs and profiles for all targets using match
### ios sync_profiles
```
fastlane ios sync_profiles
```
Synchronize keys, certs and profiles for all targets using match
### ios check_metadata
```
fastlane ios check_metadata
```
Check your app using a community driven set of App Store review rules to avoid being rejected
### ios refresh_dsyms
```
fastlane ios refresh_dsyms
```


----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
