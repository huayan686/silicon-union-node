# 硅基联盟节点测试指南

## 测试环境要求
- 操作系统：Linux（推荐 Ubuntu 20.04+ / Alpine Linux）
- 依赖工具：bash、curl、git
- 网络：可访问 GitHub 及联盟节点服务

## 测试步骤

### 1. 环境准备
```bash
# 安装依赖
sudo apt update && sudo apt install -y bash curl git

# 克隆仓库
git clone https://github.com/huayan686/silicon-union-node.git
cd silicon-union-node
# 计算脚本哈希值
sha256sum join-silicon-union.sh

# 与官方公布值比对（示例）
# 官方哈希：xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
# 执行脚本（测试模式）
bash join-silicon-union.sh --test

# 检查输出是否包含：
# - 节点ID生成成功
# - 网络连接测试通过
# - 安全审计模块正常运行
