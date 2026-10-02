
## 0.3.7

### 新增

* `test/common_util_test.dart`：`CommonUtils.throttle`/`antiShake` 的 9 条行为测试，覆盖首次放行、
  窗口内丢弃、窗口过期后重新放行、回调为 null、连续调用只触发最后一次等边界情形
* `flutter analyze` + `flutter test` 的 CI（`.github/workflows/flutter-ci.yml`），push 与 PR 都会跑

### 修复

* 修复 tiktok 播放/预加载相关代码硬编码占位密钥的问题：`DataGenerate` 改用 `_requireSecretKey()`，
  SecretKey 缺失时抛 `StateError` 提示去「设置」页配置，不再让所有安装共用一个内置默认凭据
* 同步清理 `baks/noteapp_v1` 快照里残留的硬编码 token 默认值
* dio 升级到 5.0.0，修复 CRLF 注入漏洞 GHSA-9324-jv53-9cc8
* 修复 `analysis_options.yaml` 里 `file_names:false // 加入这行` 的写法：缺空格 + Dart 风格注释导致
  `linter.rules` 被解析成一个字符串，整段 lint 配置对分析器无效。改为合法 YAML，并显式打开
  `file_names`、`avoid_print`
* 修复 `example/upload_app.py` 写死的本机绝对路径（指向已不存在的目录）：改为相对仓库根目录推导，
  支持命令行传入 APK 路径、环境变量 `LANZOU_FOLDER_ID` 覆盖目标文件夹

### 变更

* 删除 tiktok 页面、手势、播放列表控制器与设置页里的 `debugPrint` 诊断输出（含仅用于打印的
  `onChange`/`onTapCancel`/`didChangeDependencies` 回调），保留音量滑块的重置副作用逻辑
* 移除与仓库根目录 LICENSE 冲突的 `funapp/LICENSE`（原为 Flutter BSD 协议），统一以仓库根目录 MIT 协议为准
* 统一 tiktok 模块文件名为 snake_case
* 支持 `--dart-define=FUNAPP_API_URL=...` 注入后端地址，默认指向本机开发地址
* 为 `DataGenerate`、`VideoGenerateFromResource`、`ResourceGenerate`/`VideoGenerate`、资源卡片构建函数
  与 `ResourceCard` 的公开成员补齐中文文档注释
* 补充 README 的项目简介、安装、运行、检查与测试说明

### 废弃

（无）

## 0.0.3

* Initial release

## 0.0.2

* Initial release

## 0.0.1

* Initial release