# funapp

一个 Flutter 多媒体 demo app，包含一个仿抖音的竖向短视频信息流（`lib/tiktok/`，播放、点赞手势、评论弹层、用户主页）、
一套通用的图片/视频资源卡片与列表组件（`lib/common/`），以及若干示例入口页面（`lib/example/`、`lib/page/`）。
项目主要用于验证 `fijkplayer`/`video_player` 播放器、`dio` 网络请求、`carousel_slider` 轮播等能力的组合使用。

> 本仓库为 `funapp` 的备份仓库（仓库名带 `-bak` 后缀），当前是本仓库内唯一还在维护的源码目录。

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

其中 tiktok 相关页面需要连接一个后端资源接口（默认地址见 `lib/page/route.dart` 里的 `WGRouter.url`），
并需要在应用内「设置」页填写 `SecretKey`（对应后端接口的 `token`）后才能正常拉取数据，
应用不再内置默认密钥。

## 打包

[Flutter 打包参考](https://xie.infoq.cn/article/7b10cb8ef48310eda845bbfcd)

---

## 关于 farfarfun

[farfarfun](https://github.com/farfarfun) 是一个专注于实用工具库的开源组织，
涵盖云存储、数据处理、AI、多媒体与开发工具链等方向。

- 🏠 组织主页：<https://github.com/farfarfun>
- 📧 联系：farfarfun@qq.com

本项目基于 [MIT](../LICENSE) 协议开源。
