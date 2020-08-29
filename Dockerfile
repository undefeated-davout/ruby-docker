FROM centos:8

ENV RUBY_VERSION 2.6.5

# yum
RUN set -x \
 && yum update -y \
 && yum -y install \
            epel-release \
            gcc-c++ \
            glibc-headers \
            openssl-devel \
            readline \
            readline-devel \
            zlib \
            zlib-devel \
            sqlite-devel \
            bzip2 \
            git \
            make \
            autoconf \
            curl \
            wget \
            sudo \
            unzip \
 && rm -rf /var/cache/yum/* \
 && yum clean all

# Japanese Locale setting
#RUN localedef -f UTF-8 -i ja_JP ja_JP.UTF-8
#ENV LANG="ja_JP.UTF-8" \
#    LANGUAGE="ja_JP:ja" \
#    LC_ALL="ja_JP.UTF-8"

# Ruby install 
ENV HOME /root
ENV RBENV_ROOT $HOME/.rbenv
ENV PATH $RBENV_ROOT/bin:$PATH
RUN git clone https://github.com/sstephenson/rbenv.git $HOME/.rbenv
RUN git clone https://github.com/sstephenson/ruby-build.git $HOME/.rbenv/plugins/ruby-build
RUN echo 'eval "$(rbenv init -)"' >> ~/.bashrc \
 && eval "$(rbenv init -)"
RUN rbenv install ${RUBY_VERSION} \
 && rbenv global ${RUBY_VERSION}

# work directory
RUN mkdir /share
WORKDIR /share
