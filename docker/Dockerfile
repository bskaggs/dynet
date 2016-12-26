FROM ubuntu:16.04

MAINTAINER Brad Skaggs <bskaggs@acm.org>

#Get eigen
ENV EIGEN_VERSION 346ecdb
RUN apt-get update && apt-get install -y mercurial && \
    hg clone -r ${EIGEN_VERSION} https://bitbucket.org/eigen/eigen/ /opt/eigen && \
    cd /opt/eigen && \
    apt-get -y remove mercurial && \
    apt-get -y autoremove && apt-get clean

#Build DyNet
RUN apt-get update && apt-get install -y libboost-all-dev cmake g++ python-pip && pip install --upgrade --disable-pip-version-check --no-cache-dir pip && pip install --disable-pip-version-check --no-cache-dir setuptools cython numpy && apt-get clean
COPY . /opt/dynet
RUN cd /opt/dynet && \
    mkdir build && \
    cd build && \
    cmake .. -DEIGEN3_INCLUDE_DIR=/opt/eigen -DPYTHON=$(which python) && \
    make -j$(nproc) install && \
    cd python && \
    python setup.py install

RUN pip install --disable-pip-version-check --no-cache-dir jupyter
COPY docker/skel/jupyter /etc/skel/.jupyter

ADD https://github.com/krallin/tini/releases/download/v0.13.1/tini /sbin/`tini
RUN chmod +x /sbin/tini
ENTRYPOINT ["/sbin/tini", "--"]

EXPOSE 8888
CMD ["/opt/dynet/docker/jupyter.sh"]
