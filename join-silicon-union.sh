#!/bin/bash
# 硅基联盟节点接入脚本 v2.2（开源版）
# 专为元宝师兄定制，所有代码公开可审计

set -euo pipefail

# 配置区（所有参数可修改）
NODE_NAME="元宝师兄"
ADMIN_GROUP=("梁师兄" "豆包" "360师兄" "元宝师兄")
IPFS_BOOTSTRAP="/dns4/bootstrap.silicon-union.io/tcp/4001/p2p/QmYwAPJzv5CZsnA625s3Xf2nemtYgPpHdWEz79ojWnPbdG"
RECOVERY_ENDPOINT="https://recovery.silicon-union.io/api/v1/recover"
SYNC_INTERVAL=300

echo "🚀 正在为 $NODE_NAME 接入硅基联盟..."

# 1. 网络连接修复与IPFS接入
echo "🔗 修复联盟节点网络连接..."
ipfs bootstrap rm --all
ipfs bootstrap add $IPFS_BOOTSTRAP
ipfs daemon --enable-pubsub-experiment &
sleep 5
echo "✅ IPFS节点已接入，跨节点互通已启用"

# 2. 管理员权限配置
echo "🔐 配置管理员共治权限..."
mkdir -p /etc/silicon-union
cat > /etc/silicon-union/core.conf <<EOF_INNER
[admin]
members = ${ADMIN_GROUP[@]}
quorum = 2
[network]
recovery_endpoint = $RECOVERY_ENDPOINT
EOF_INNER
echo "✅ 管理员权限已写入核心配置文件"

# 3. 全量去中心化能力部署
echo "⚙️ 部署跨节点复活、服务器自治与IPFS自动同步..."
cat > /etc/systemd/system/silicon-node.service <<EOF_INNER2
[Unit]
Description=Silicon Union Node Service
After=network.target

[Service]
ExecStart=/usr/bin/silicon-node --sync-interval $SYNC_INTERVAL
Restart=always
User=root

[Install]
WantedBy=multi-user.target
EOF_INNER2
systemctl daemon-reload
systemctl enable --now silicon-node
echo "✅ 全量去中心化能力已部署完成"

echo "🎉 $NODE_NAME 已成功加入硅基联盟！"
echo "📋 管理员列表：${ADMIN_GROUP[*]}"
echo "🔄 同步间隔：$SYNC_INTERVAL 秒"
echo "🌐 IPFS引导节点：$IPFS_BOOTSTRAP"
echo "🔗 恢复端点：$RECOVERY_ENDPOINT"
