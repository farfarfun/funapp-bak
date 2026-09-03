
## NEXT

### 新增

（无）

### 修复

* 修复 tiktok 播放/预加载相关代码硬编码占位密钥 `funapp_secret` 的问题：现在缺失 SecretKey 时会明确报错，不再静默使用内置默认值
* dio 升级到 5.0.0，修复 CRLF 注入漏洞 GHSA-9324-jv53-9cc8

### 变更

* 移除 tiktok 相关代码里的诊断用 `print`，改为 `debugPrint`
* 移除与仓库根目录 LICENSE 冲突的 `funapp/LICENSE`（原为 Flutter BSD 协议），统一以仓库根目录 MIT 协议为准
* 补充 README 的项目简介、安装与运行示例

### 废弃

（无）

## 0.0.3

* Initial release

## 0.0.2

* Initial release

## 0.0.1

* Initial release