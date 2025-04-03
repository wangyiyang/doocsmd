#!/bin/bash

# 创建日志目录
mkdir -p ./logs/nginx

# 创建 .env 文件（如果不存在）
if [ ! -f .env ]; then
    echo "NGINX_PORT=18481" > .env
    echo "已创建 .env 文件，设置默认端口为 18481"
fi

# 检查是否已安装 htpasswd 工具
if ! command -v htpasswd &> /dev/null; then
    echo "htpasswd 工具未安装，正在安装..."
    if command -v apt-get &> /dev/null; then
        sudo apt-get update
        sudo apt-get install -y apache2-utils
    elif command -v yum &> /dev/null; then
        sudo yum install -y httpd-tools
    elif command -v brew &> /dev/null; then
        brew install httpd
    else
        echo "无法安装 htpasswd 工具，请手动安装后再运行此脚本。"
        exit 1
    fi
fi

# 提示用户输入用户名
read -p "请输入用户名: " username

# 生成 htpasswd 文件
htpasswd -c ./htpasswd $username

# 检查是否成功生成 htpasswd 文件
if [ -f "./htpasswd" ]; then
    echo "htpasswd 文件已成功生成。"
else
    echo "生成 htpasswd 文件失败，请检查权限或路径。"
    exit 1
fi

# 启动 Docker Compose 服务
echo "正在启动 Docker Compose 服务..."
docker compose up -d

# 获取当前配置的端口
PORT=$(grep NGINX_PORT .env | cut -d= -f2)
if [ -z "$PORT" ]; then
    PORT=80
fi

echo "服务已启动，请访问 http://localhost:$PORT 并使用设置的用户名和密码进行认证。" 