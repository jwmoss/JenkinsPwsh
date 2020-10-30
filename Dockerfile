## choose alpine image
FROM jenkins/jenkins:lts-alpine

# To run apt
USER root

## Create location to place config as code
RUN mkdir $JENKINS_HOME/casc_configs

# Environment variables
ENV CASC_JENKINS_CONFIG $JENKINS_HOME/casc_configs
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false 

## Copy plugins 
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt

## Copy jenkins config as code
COPY jenkins.yaml $JENKINS_HOME/casc_configs

## Install the plugins
RUN jenkins-plugin-cli -f /usr/share/jenkins/ref/plugins.txt

# install the requirements for pwsh
RUN apk add --no-cache \
    ca-certificates \
    less \
    ncurses-terminfo-base \
    krb5-libs \
    libgcc \
    libintl \
    libssl1.1 \
    libstdc++ \
    tzdata \
    userspace-rcu \
    zlib \
    icu-libs \
    curl

RUN apk -X https://dl-cdn.alpinelinux.org/alpine/edge/main add --no-cache \
    lttng-ust

# Download the powershell '.tar.gz' archive
RUN curl -L https://github.com/PowerShell/PowerShell/releases/download/v7.0.3/powershell-7.0.3-linux-alpine-x64.tar.gz -o /tmp/powershell.tar.gz

# Create the target folder where powershell will be placed
RUN mkdir -p /opt/microsoft/powershell/7

# Expand powershell to the target folder
RUN tar zxf /tmp/powershell.tar.gz -C /opt/microsoft/powershell/7

# Set execute permissions
RUN chmod +x /opt/microsoft/powershell/7/pwsh

# Create the symbolic link that points to pwsh
RUN ln -s /opt/microsoft/powershell/7/pwsh /usr/bin/pwsh

# Drop back to the jenkins user
USER jenkins

VOLUME /jenkins_configs
VOLUME /var/jenkins_home