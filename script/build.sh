cd noteapp
clear
flutter clean
#yes y|flutter pub cache clean
#flutter pub cache repair 
flutter packages get

#flutter build apk
#flutter build apk --release
#flutter build apk --target-platform android-arm64,android-arm,android-x64 --split-per-abi
flutter build apk --target-platform android-arm64 --split-per-abi

cd ../example && python upload_app.py