from fundrive.drives.lanzou import LanZouDrive

file_path = f'/notechats/bingtao/workspace/notechats/noteapp/noteapp/build/app/outputs/flutter-apk/app-arm64-v8a-release.apk'

downer = LanZouDrive()
downer.ignore_limit()
downer.login()
res = downer.upload_file(file_path, fid=4801466)

print(res)
