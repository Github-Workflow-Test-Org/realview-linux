FROM --platform=linux/amd64 centos:7 AS env

RUN yum update -y
RUN yum install -y centos-release-scl
RUN yum install -y make

RUN curl -s "https://cmake.org/files/v3.29/cmake-3.29.0-linux-x86_64.tar.gz" | tar --strip-components=1 -xz -C /usr/local

ENV PACKAGES libfdt-devel ccache \
  tar git gcc flex bison build-essential gstreamer-1.0 uuid-dev vcpkg GLIBCXX_3.4.19 wget gcc-c++.noarch \
   zlib-devel glib2-devel SDL-devel pixman-devel \
   epel-release
RUN yum install -y $PACKAGES

RUN echo "source /opt/rh/devtoolset-9/enable" >> /etc/bashrc
SHELL ["/bin/bash", "--login", "-c"]
RUN gcc --version

RUN yum -y install \
        alsa-lib-devel \
        automake \
        cairo-devel \
        cairo-gobject-devel \
        centos-release-scl \
        docker-latest \
        emacs \
        gcc \
        gcc-c++ \
        gettext-devel \
        gtk-doc \
        libffi-devel \
        libjpeg-turbo-devel \
        libcap-devel \
        libsrtp-devel \
        libva-devel \
        khrplatform-devel \
        krb5-devel \
        make \
	ncurses-devel \
        zip \
        unzip

COPY . /etc/realview
WORKDIR /etc/realview
ENTRYPOINT [ "/etc/realview" ]

# ----------

# DOCKER-COMMANDS
# docker build -t cpp-realview  . -f ./realview.build.Dockerfile
# docker run --platform linux/amd64  -it --entrypoint /bin/bash cpp-realview
# docker run -it --entrypoint /bin/bash cpp-realview
# docker rm -v -f $(docker ps -qa) 
# docker start -a -i 
# docker exec -it <CONTAINER-ID> bash #--> attach already running container

# ----------

# git repo link
# git clone https://github.com/Engrgit/realview

# ----------

# build command
# make build

# ----------

# find . -exec file {} \; | grep --color -i elf
# find . -type f -executable -print

