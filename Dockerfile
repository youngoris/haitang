# 选择一个包含 Node.js 的基础镜像
FROM node:18-alpine

# 设置工作目录
WORKDIR /app

# 复制 package.json 和 yarn.lock 文件
COPY package.json ./

# 安装项目依赖
RUN yarn install --frozen-lockfile

# 复制剩余的项目文件
COPY . .

# 构建静态文件
RUN yarn build

# 安装 serve 来服务静态文件
RUN yarn global add serve

