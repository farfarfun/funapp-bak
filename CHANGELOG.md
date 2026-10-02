# Changelog

## 0.3.7

逐条内容见 [`funapp/CHANGELOG.md`](funapp/CHANGELOG.md)，仓库层面的变化：

- 移除 Python 打包声明：本仓库只交付 `funapp/` 构建出的 APK，不发布 Python 包，也不发布到 pub.dev。
- 统一关键 TikTok 模块文件名为 snake_case。
- 支持通过 `FUNAPP_API_URL` 注入后端地址，默认指向本机开发地址。
- 补齐 `CommonUtils` 节流/防抖的 9 条 Flutter 测试，并新增在 push/PR 上跑 `flutter analyze` + `flutter test` 的 CI。
- tiktok 相关代码不再内置默认 SecretKey：缺失时直接抛 `StateError`；`baks/` 快照里残留的硬编码 token 默认值一并清掉。
- 删除 tiktok 页面与控制器里的 `debugPrint` 诊断输出。
- 修复 `funapp/analysis_options.yaml` 的非法 `linter.rules` 写法（原先整段 lint 配置对分析器无效）。
- 修复 `example/upload_app.py` 写死的本机绝对路径。
- README 改为只描述当前状态，明确 `funapp/`（在维护）与 `baks/`（只读存档）的分工。

## 0.3.6

- 保留原 `funapp` Flutter 示例应用和依赖锁文件。
