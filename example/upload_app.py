from os import path

from notebuild.tool import read_version
from notedrive.lanzou import CodeDetail, LanZouCloud, download
from setuptools import find_packages, setup

version = read_version(path.join(path.abspath(path.dirname(__file__)), 'script/__version__.md'))
file_path = f'/home/bingtao/workspace/notechats/noteapp/bin/notechats-{version}-arm64-v8a-debug.apk'
print(version)

downer = LanZouCloud()
downer.ignore_limits()
downer.login_by_cookie()
res = downer.upload_file(file_path, folder_id=4801466)

print(res)
