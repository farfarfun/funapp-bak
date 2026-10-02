# funapp-bak

一个 Flutter 多媒体 demo app 的归档仓库：竖向短视频信息流（仿抖音）+ 通用图片/视频资源列表组件，
详见 [`funapp/README.md`](funapp/README.md)。

仓库布局：

- `funapp/` —— 唯一可运行、可构建的 Flutter 工程，仓库内所有维护工作都在这里；
- `baks/` —— 只读的早期代码快照，仅供查阅，不编译、不接受修改；
- `script/`、`example/` —— 本机构建与 APK 上传用的辅助脚本。

本仓库不发布任何 Python 包，也不发布到 pub.dev；交付物是 `funapp/` 构建出的 APK（见 `.github/workflows/build-apk.yml`，推送 `v*` tag 触发）。

> 命名说明：仓库名 `funapp-bak` 与 Flutter 工程名 `funapp` 不一致，这是归档仓库的既有状态；
> `farfarfun/funapp` 是另一个独立的 Python 项目，与本仓库无关。

## 安装与运行

```bash
cd funapp
flutter pub get
flutter run
```

更详细的说明（页面导航、后端 token 配置）见 [`funapp/README.md`](funapp/README.md)。

## 打包

[打包参考](https://xie.infoq.cn/article/7b10cb8ef48310eda845bbfcd)

---

## 关于 farfarfun

[farfarfun](https://github.com/farfarfun) 是一个专注于实用工具库的开源组织，
涵盖云存储、数据处理、AI、多媒体与开发工具链等方向。

- 🏠 组织主页：<https://github.com/farfarfun>
- 📧 联系：farfarfun@qq.com

本项目基于 [MIT](LICENSE) 协议开源。
