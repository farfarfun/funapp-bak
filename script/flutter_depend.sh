# 安装sdk
# sdk 管理工具  https://developer.android.com/studio/command-line/sdkmanager
sdkmanager  --sdk_root=/notechats/bingtao/opt/android-sdk --update
sdkmanager  --sdk_root=/notechats/bingtao/opt/android-sdk --list 
sdkmanager  --sdk_root=/notechats/bingtao/opt/android-sdk 'build-tools;31.0.0' 'platform-tools' 'platforms;android-31' 'tools'
sdkmanager  --sdk_root=/notechats/bingtao/opt/android-sdk --install "cmdline-tools;latest"


flutter config --android-studio-dir /notechats/bingtao/opt/android-studio
flutter config --android-sdk /notechats/bingtao/opt/android-sdk
flutter upgrade

flutter doctor
flutter doctor --android-licenses

export ANDROID_SDK_ROOT=/notechats/bingtao/opt/android-sdk


sudo chown -R $USER /snap/bin/flutter
sudo chown -R $USER /notechats


# 启动
flutter run -d chrome --web-port 8446  --web-hostname 0.0.0.0

# software-properties-common
sudo apt-get install software-properties-common
sudo apt-get install openjdk-8-jdk
sudo apt-get install libc6-dev-i386 lib32z1 openjdk-8-jdk

clear && flutter clean && flutter packages get && flutter build apk
