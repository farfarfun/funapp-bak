import sys
from os import path

from setuptools import find_packages, setup


def read_version(version_path, step=32):
    if path.exists(version_path):
        with open(version_path, 'r') as f:
            version1 = [int(i) for i in f.read().split('.')]
    else:
        version1 = [0, 0, 1]

    version3 = '{}.{}.{}'.format(*version1)
    with open(version_path, 'w') as f:
        f.write(version3)
    return version3


version_path = path.join(path.abspath(path.dirname(__file__)), 'script/__version__.md')

version = read_version(version_path)

# 注意：find_packages() 在本仓库当前实际返回空列表——仓库里没有任何
# 带 __init__.py 的 Python 包目录（`funapp/` 是 Flutter 项目目录，不是 Python
# 包）。这里打出来的一直是一个不含任何代码的空 wheel，install_requires 列出的
# 依赖并没有被任何代码实际导入。funbuild 是构建期工具，不应留在运行时依赖里。
install_requires = ['tqdm>=4.60', 'numpy>=1.24', 'pandas>=1.5', 'pillow>=9.0']
extras_require = {'dev': ['funbuild>=1.6.66']}

setup(name='funapp',
      version=version,
      description='funapp',
      author='bingtao',
      author_email='1007530194@qq.com',
      url='https://github.com/1007530194',

      packages=find_packages(),
      package_data={"": ["*.*"]},
      include_package_data=True,
      install_requires=install_requires,
      extras_require=extras_require,
      )
