FROM debian

## Set the user and group IDs inside the container
#ARG USER_ID
#ARG GROUP_ID
#
## Create a non-root user with the specified IDs
#RUN groupadd -g $GROUP_ID nut && \
#    useradd -u $USER_ID -g $GROUP_ID -m -s /bin/bash nut

# Install dependencies and NUT packages
#RUN apt-get update && \
#    apt-get install -y nut-client nut-server net-tools iputils-ping && \
#    rm -rf /var/lib/apt/lists/*

RUN apt-get update && \
    apt-get install -y \
    nut-client=2.8.0-7 \
    nut-server=2.8.0-7 \
    net-tools=2.10-0.1 \
    iputils-ping && \
    rm -rf /var/lib/apt/lists/*

# Copy the custom files
COPY ./etc/nut/ups.conf /etc/nut/ups.conf
COPY ./etc/nut/upsd.conf /etc/nut/upsd.conf
COPY ./etc/nut/nut.conf /etc/nut/nut.conf
COPY ./etc/nut/upsd.users /etc/nut/upsd.users
COPY ./etc/nut/upsmon.conf /etc/nut/upsmon.conf

COPY startup.sh /usr/local/bin/startup.sh
#RUN chmod +x /usr/local/bin/startup.sh

# Entry point
# Start the NUT service in the foreground and run the custom script
#CMD ["/bin/bash"]
CMD ["/usr/local/bin/startup.sh"]
