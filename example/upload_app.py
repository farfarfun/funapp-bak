from os import path

from notebuild.tool import read_version
from notedrive.lanzou import CodeDetail, LanZouCloud, download
from setuptools import find_packages, setup

file_path = f'/notechats/bingtao/workspace/notechats/noteapp/noteapp/build/app/outputs/flutter-apk/app-arm64-v8a-release.apk'

downer = LanZouCloud()
downer.ignore_limits()
downer.login_by_cookie()
res = downer.upload_file(file_path, folder_id=4801466)

print(res)
