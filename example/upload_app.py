"""把 funapp 构建出的 release APK 上传到蓝奏云。

用法::

    python example/upload_app.py [apk 路径]

不传路径时默认取 ``funapp/build/app/outputs/flutter-apk/app-arm64-v8a-release.apk``
（相对本仓库根目录）。目标文件夹 id 可用环境变量 ``LANZOU_FOLDER_ID`` 覆盖，
凭据由 ``fundrive`` 自己从配置里读取，不在本文件里硬编码。
"""

import os
import sys
from pathlib import Path

from fundrive.drives.lanzou import LanZouDrive

#: 仓库根目录（本文件位于 <repo>/example/ 下）
REPO_ROOT = Path(__file__).resolve().parent.parent

#: 默认的 release APK 产物路径
DEFAULT_APK = (
    REPO_ROOT
    / "funapp"
    / "build"
    / "app"
    / "outputs"
    / "flutter-apk"
    / "app-arm64-v8a-release.apk"
)

#: 蓝奏云目标文件夹 id，可用环境变量覆盖
DEFAULT_FOLDER_ID = 4801466


def upload(apk_path: Path, folder_id: int) -> object:
    """把 ``apk_path`` 上传到蓝奏云 ``folder_id`` 文件夹，返回 fundrive 的上传结果。

    :param apk_path: 待上传的 APK 文件路径，必须已存在。
    :param folder_id: 蓝奏云目标文件夹 id。
    :raises FileNotFoundError: ``apk_path`` 不存在时抛出。
    """
    if not apk_path.is_file():
        raise FileNotFoundError(
            f"APK 不存在：{apk_path}，请先在 funapp/ 下执行 flutter build apk --release"
        )

    drive = LanZouDrive()
    drive.ignore_limit()
    drive.login()
    return drive.upload_file(str(apk_path), fid=folder_id)


def main(argv: list[str] | None = None) -> int:
    """命令行入口：解析参数、上传并打印结果，成功返回 0。"""
    args = sys.argv[1:] if argv is None else argv
    apk_path = Path(args[0]).expanduser().resolve() if args else DEFAULT_APK
    folder_id = int(os.environ.get("LANZOU_FOLDER_ID", DEFAULT_FOLDER_ID))
    print(upload(apk_path, folder_id))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
