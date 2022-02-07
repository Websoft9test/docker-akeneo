# Akeneo

## 安装

### 解读

官方仅提供了定制的 [PHP 镜像](https://hub.docker.com/r/akeneo/pim-php-base)，其中仅包含了 php, php-cli, fpm, composer。  

### 镜像寻找

目前没有找到满足需求的镜像

### 方案

目前确认可行的方案是基于 Akeneo 官方镜像的基础上进行研发，具体需求：

* 安装 apache 以及连接 php-fpm
* 安装 Akeneo，提取数据库连接和管理员账号的环境变量
* Apache 日志转发到 docker logs
* Apache 服务的健壮性研究
