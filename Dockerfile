FROM amazonlinux:2

WORKDIR /root/
# Install dependencies
RUN yum install -y git curl g++-7 git python python3-dev python3-numpy sudo wget tar make gcc gcc-c++ patch autoconf automake libtool python-pip cmake3
RUN pip install future

# bazel version required is 0.26.1 anything else might not work!
ENV BAZEL_VERSION=0.26.1 
RUN yum install -y pkg-config zip g++ zlib1g-dev unzip
RUN wget -P /tmp https://github.com/bazelbuild/bazel/releases/download/${BAZEL_VERSION}/bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh
RUN chmod +x /tmp/bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh
RUN yum install -y which 
RUN /tmp/bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh
RUN rm /tmp/bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh
RUN bazel version

# Need CMake > 3.3
RUN ln -s /usr/bin/cmake3 /usr/bin/cmake

RUN git clone https://github.com/FloopCZ/tensorflow_cc.git tensorflow_cc
WORKDIR /root/tensorflow_cc/
RUN git checkout v1.15.0

WORKDIR /root/tensorflow_cc/tensorflow_cc/build
RUN cmake -D CMAKE_C_COMPILER="/usr/bin/gcc" -D CMAKE_CXX_COMPILER="/usr/bin/g++" -DTENSORFLOW_STATIC=OFF -DTENSORFLOW_SHARED=ON ..

# build and install
RUN make
RUN make install
RUN rm -rf /root/tensorflow_cc/

RUN export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib/:/usr/local/lib/tensorflow_cc/