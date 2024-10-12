# 使用 Node.js 的官方基础镜像
FROM node:18-alpine

# 安装系统依赖
RUN apk --no-cache add libgcc libstdc++

# 设置工作目录
WORKDIR /app

# 复制 'package.json' 和 'yarn.lock' 文件（如果使用 yarn 的话）
COPY package.json ./

# 安装项目依赖，包括 sharp
RUN yarn install  

# 复制项目文件到工作目录
COPY . .

# 设置环境变量
ENV PORT=3000 OUTPUT_MODE=server

# 构建静态文件
RUN yarn build

# 安装 serve 来服务静态文件
RUN yarn global add serve

# 开放端口
EXPOSE $PORT

# 启动服务器
CMD ["serve", "-s", "dist", "-l", "tcp://0.0.0.0:$PORT"]
