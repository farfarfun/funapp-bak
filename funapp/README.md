# funapp

一个 Flutter 多媒体 demo app，包含一个仿抖音的竖向短视频信息流（`lib/tiktok/`，播放、点赞手势、评论弹层、用户主页）、
一套通用的图片/视频资源卡片与列表组件（`lib/common/`），以及若干示例入口页面（`lib/example/`、`lib/page/`）。
项目主要用于验证 `fijkplayer`/`video_player` 播放器、`dio` 网络请求、`carousel_slider` 轮播等能力的组合使用。

> 本目录是 `farfarfun/funapp-bak` 仓库内唯一可运行、可构建的源码目录；同级 `../baks/` 下的快照为只读存档。

## 安装

```bash
flutter pub get
```

## 运行示例

```bash
# 桌面/移动端调试
flutter run

# 或者以 Web 方式运行
flutter run -d chrome
```

运行后从首页可以进入「播放视频」「视频列表」「图片列表」「资源列表」「tiktok」等各个演示页面（见 `lib/page/route.dart`）。

其中 tiktok 相关页面需要连接一个后端资源接口（默认地址为本机 `http://127.0.0.1:8446/`，可用
`--dart-define=FUNAPP_API_URL=https://example.invalid/` 覆盖），
并需要在启动时注入 `SecretKey`（对应后端接口的 `token`）后才能正常拉取数据：

```bash
flutter run --dart-define=FUNAPP_SECRET_KEY=your-secret-key
```

应用不内置默认密钥，也不会将其写入普通应用设置；未注入时 `DataGenerate` 会抛
`StateError`。升级自 0.3.7 或更早版本时，旧的设置页密钥会在首次启动时删除，请改用
上述启动参数或由 CI/CD 注入同名 `--dart-define`。

## 检查与测试

```bash
# 静态分析（含 analysis_options.yaml 里的 lint 规则）
flutter analyze

# 单元测试
flutter test
```

## 打包

[Flutter 打包参考](https://xie.infoq.cn/article/7b10cb8ef48310eda845bbfcd)

---

## 关于 farfarfun

[farfarfun](https://github.com/farfarfun) 是一个专注于实用工具库的开源组织，
涵盖云存储、数据处理、AI、多媒体与开发工具链等方向。

- 🏠 组织主页：<https://github.com/farfarfun>
- 📧 联系：farfarfun@qq.com

本项目基于 [MIT](../LICENSE) 协议开源。
