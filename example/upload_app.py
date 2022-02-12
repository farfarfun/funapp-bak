from notedrive.lanzou import CodeDetail, LanZouCloud, download

downer = LanZouCloud()
downer.ignore_limits()

downer.login_by_cookie()

file_path = '/home/bingtao/workspace/notechats/noteapp/bin/notechats-0.0.8-arm64-v8a-debug.apk'
res = downer.upload_file(file_path, folder_id=4801466)

print(res)
