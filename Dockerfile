ARG BUILD_FROM=ghcr.io/hassio-addons/base-python/amd64:17.0.0
#ARG BUILD_FROM=ghcr.io/hassio-addons/debian-base/amd64:8.1.3

# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Setup base system
ARG BUILD_ARCH=amd64

# update python version
#RUN apt -y install python3.13 python3.13-venv

# Install requirements for add-on
RUN \
  apk add --no-cache \
    python3 py3-pip \
	py3-pydantic py3-pyserial py3-paho-mqtt
	
RUN python -m venv /opt/venv
# Enable venv
ENV PATH="/opt/venv/bin:$PATH"
	
#RUN pip3 install pip install --no-binary pydantic pydantic~=1.10.10
#RUN pip3 install pip install --no-binary pydantic
#RUN pip3 install pyserial~=3.5 paho-mqtt~=1.6.1 homeassistant~=2023.10.5 setuptools~=68.2.0 StrEnum~=0.4.15 ha-mqtt-discoverable~=0.9.0
RUN pip3 install homeassistant 
RUN pip3 install setuptools 
RUN pip3 install StrEnum 
RUN pip3 install ha-mqtt-discoverable

# Python 3 HTTP Server serves the current working dir
# So let's set it to our add-on persistent data directory.
WORKDIR /data

# Copy data for add-on
COPY run.sh /
RUN chmod a+x /run.sh
COPY ./ /pylontech/
RUN chmod a+x /pylontech/examples/mqtt/PylontechMqtt.py

RUN pip3 install /pylontech

CMD [ "/run.sh" ]
