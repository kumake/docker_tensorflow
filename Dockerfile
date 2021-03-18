FROM tensorflow/tensorflow:2.4.1

#MAINTAINER NGINX Docker Maintainers "docker-maint@nginx.com"


#设置镜像源
#COPY ./sources.list  /etc/apt/sources.list.2

#设置中文
ENV LANG C.UTF-8

WORKDIR /root

RUN apt-get update \
        && apt-get install -y  vim lrzsz curl net-tools inetutils-ping zip \
        # jupyter支持python3
        && python3 -m pip install  ipykernel \
        && python3 -m ipykernel install --user \
        #安装jupyterlab
        && pip3 install  jupyterlab \
        #安装pyecharts v1.0版本仅支持python3.6以上
        && pip3 install  pyecharts \
        #图像增广库
        && pip3 install  imgaug \
                # 用完包管理器后安排打扫卫生可以显著的减少镜像大小
                && apt-get clean \
                && apt-get autoclean \
                && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#拷贝jupyter配置文件
COPY ./jupyter_notebook_config.py  /root/.jupyter/jupyter_notebook_config.py

CMD ["/bin/bash"]
