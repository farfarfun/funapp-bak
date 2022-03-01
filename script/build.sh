notebuild build
# cd noteapp
# yes y|buildozer android clean
# yes y|buildozer android update
# yes y|buildozer android deploy
# yes y|buildozer android debug
# yes y|buildozer android release

rm -rf /home/bingtao/opt/.buildozer/android/platform/build-arm64-v8a/build/python-installs/notechats/noteapp*

yes y|buildozer android debug deploy --ignore-setup-py --ignore-setup-py

cd  example && python upload_app.py