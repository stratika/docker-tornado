## Docker File for TornadoVM on NVIDIA GPUs

FROM nvidia/opencl

LABEL MAINTAINER Juan Fumero <juan.fumero@manchester.ac.uk>

RUN apt-get update
RUN apt-get install vim git cmake -y
RUN apt-get install maven -y
RUN apt-get install openjdk-8-jdk -y 
RUN apt-get update -q && apt-get install -qy \
    python-pip \
    && rm -rf /var/lib/apt/lists/*

COPY settings.xml /root/.m2/settings.xml

RUN java -version
RUN javac -version

ENV PATH /usr/lib/jvm/java-8-openjdk-amd64/bin:$PATH

## Compile Graal-JVMCI-8
WORKDIR /tornado
RUN git clone --depth 1 https://github.com/beehive-lab/mx 
ENV PATH /tornado/mx:$PATH 
RUN git clone --depth 1 https://github.com/beehive-lab/graal-jvmci-8
WORKDIR /tornado/graal-jvmci-8
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
RUN echo "JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" >> /tornado/graal-jvmci-8/mx.jvmci/env
RUN cat /tornado/graal-jvmci-8/mx.jvmci/env
RUN mx build -p; exit 0 ### XXX 
RUN mx build -p 

## Compile Tornado
WORKDIR /tornado
RUN git clone https://github.com/beehive-lab/TornadoVM.git tornado
ENV JAVA_HOME /tornado/graal-jvmci-8/openjdk1.8.0_242/linux-amd64/product
ENV PATH /tornado/tornado/bin/bin:$PATH
ENV PATH $JAVA_HOME/bin:$PATH
ENV TORNADO_SDK /tornado/tornado/bin/sdk
WORKDIR /tornado/tornado
RUN mvn -Pjdk-8 package

RUN cd /tornado/tornado/bin && ln -s /tornado/tornado/dist/tornado-sdk/tornado-sdk-*/bin/ bin
RUN cd /tornado/tornado/bin && ln -s /tornado/tornado/dist/tornado-sdk/tornado-sdk-*/ sdk

# Tornado ENV-Variables
ENV PATH /tornado/tornado/bin/bin:$PATH
ENV PATH $JAVA_HOME/bin:$PATH
ENV TORNADO_SDK /tornado/tornado/bin/sdk 

# CUDA-OpenCL ENV-variables
ENV CPLUS_INCLUDE_PATH /usr/local/cuda/include
ENV LD_LIBRARY_PATH /usr/local/cuda/lib64
ENV PATH /usr/local/cuda/bin/:$PATH

WORKDIR /data
VOLUME ["/data"]

RUN echo "Tornado BUILD done"
