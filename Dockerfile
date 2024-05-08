FROM ubuntu:jammy

# Replace 1000 with your user / group id
ARG uid=1000
ARG gid=1000
ARG user=user

###
ARG JDK_VER=21
ARG GOLANG_VER=1.21
###

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Tokyo

# Allow access to port 8888
EXPOSE 8888
 
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN apt update && \
    apt upgrade -y && \
    apt install -y tzdata sudo net-tools binutils file git vim \
	telnet netcat wget curl lsof \
        iputils-ping iproute2 ethtool traceroute && \
    apt install -y python3 python3-pip && \
    pip install pip-review && \
    pip-review --auto && \
    pip install jupyterlab && \
    pip install jupyterlab-language-pack-ja-JP \
    pip install grpcio grpcio-tools grpcio-reflection && \
    apt install -y golang-${GOLANG_VER}-go protobuf-compiler && \
    ln -s ../lib/go-${GOLANG_VER}/bin/go /usr/bin/go && \
    ln -s ../lib/go-${GOLANG_VER}/bin/gofmt /usr/bin/gofmt && \
    apt install -y openjdk-${JDK_VER}-jdk && \
    apt install -y libgrpc-java libprotobuf-java libguava-java libnetty-java \
	libperfmark-java protobuf-compiler-grpc-java-plugin && \
    (cd /usr/share/java; wget https://repo1.maven.org/maven2/io/grpc/grpc-services/1.26.0/grpc-services-1.26.0.jar ) && \
    pip install jbang && \
    pip cache purge && \
    apt clean

RUN groupadd -g ${uid} ${user} && \
    useradd -u ${gid} -g ${user} -G sudo -r ${user} -s /bin/bash && \
    echo 'Defaults visiblepw'		>> /etc/sudoers && \
    echo ${user} ' ALL=(ALL) NOPASSWD:ALL'	>> /etc/sudoers && \
    mkdir /home/${user} && \
    chown ${uid}:${gid} -R /home/${user}

USER ${user}
WORKDIR /home/${user}

RUN jupyter-lab --generate-config && \
    echo 'c.ServerApp.ip = "*"' >> ~/.jupyter/jupyter_lab_config.py && \
    echo 'c.ServerApp.open_browser = False' >> ~/.jupyter/jupyter_lab_config.py && \
    echo 'export PATH=`go env GOPATH`/bin:${PATH}' >> ${HOME}/.bashrc && \
    go install github.com/janpfeifer/gonb@latest && \
    go install golang.org/x/tools/cmd/goimports@latest && \
    go install golang.org/x/tools/gopls@latest && \
    go install google.golang.org/protobuf/cmd/protoc-gen-go@latest && \
    go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest && \
    go install github.com/fullstorydev/grpcurl/cmd/grpcurl@latest && \
    /bin/bash -c 'source $HOME/.bashrc; gonb --install' && \
    go clean --modcache && \
    python3 -c "import jbang; jbang.exec('trust add https://github.com/jupyter-java'); jbang.exec('install-kernel@jupyter-java')"

