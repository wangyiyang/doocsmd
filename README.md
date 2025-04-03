# doocsmd 项目

这是一个基于 Docker Compose 的 `doocs/md` 服务部署项目，通过 Nginx 反向代理添加了基本的 HTTP 认证。项目包含了健康检查、日志管理、资源压缩等功能。

## 项目特点

- **认证保护**：通过 Nginx 提供的基本 HTTP 认证保护服务
- **网络隔离**：使用 Docker 网络隔离各服务
- **资源优化**：启用 gzip 压缩前端资源
- **健康检查**：自动监控服务状态
- **日志管理**：集中收集 Nginx 日志

## 项目结构

- `docker-compose.yml`：Docker Compose 配置文件，用于启动服务
- `nginx.conf`：Nginx 配置文件，设置反向代理和认证
- `setup.sh`：自动化脚本，生成认证文件并启动服务
- `.env`：环境变量配置文件，管理端口号等参数
- `.gitignore`：Git 忽略文件，排除敏感信息

## 使用方法

### 1. 克隆项目

```bash
git clone https://github.com/wangyiyang/doocsmd.git
cd doocsmd
```

### 2. 运行设置脚本

```bash
chmod +x setup.sh
./setup.sh
```

脚本会创建必要的目录，生成认证文件并启动服务。按提示输入用户名和密码。

### 3. 访问服务

服务启动后，访问：

http://localhost:80

### 健康检查

Nginx 和 `doocs/md` 服务都配置了健康检查，确保服务正常运行。

### 日志管理

Nginx 的日志文件存储在 `./logs/nginx` 目录下，方便查看和管理。

### 环境变量配置

通过 `.env` 文件管理配置参数，如端口号等，使配置更灵活。

### 安全加强

建议进一步增强 Nginx 配置的安全性，如添加 HTTPS 支持和安全头信息。

## 注意事项

- 请确保 `htpasswd` 文件的安全性，避免泄露。
- 如果需要修改认证信息，可以重新运行 `setup.sh` 脚本生成新的 `htpasswd` 文件。

## 贡献

欢迎提交 Issue 或 Pull Request 来改进本项目。