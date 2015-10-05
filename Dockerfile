FROM jenkins

# Modify the UID of the jenkins user to automatically match the mounted volume.
# Use it just like the original: https://hub.docker.com/_/jenkins/

USER root

# grab gosu for easy step-down from root
ADD https://github.com/tianon/gosu/releases/download/1.5/gosu-amd64 /usr/local/bin/gosu
RUN chmod 755 /usr/local/bin/gosu

ENTRYPOINT usermod -u $(stat -c "%u" /var/jenkins_home) jenkins && \
        gosu jenkins /bin/tini -- /usr/local/bin/jenkins.sh

