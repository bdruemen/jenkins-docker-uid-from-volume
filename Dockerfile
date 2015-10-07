FROM jenkins

# Modify the UID of the jenkins user to automatically match the mounted volume.
# Use it just like the original: https://hub.docker.com/_/jenkins/

USER root

# Grab gosu for easy step-down from root.
ADD https://github.com/tianon/gosu/releases/download/1.5/gosu-amd64 /usr/local/bin/gosu

# Change the group of the jenkins user to root, because that group has no 
# special rights on most host systems.
RUN chmod 755 /usr/local/bin/gosu && usermod -g root jenkins

ENTRYPOINT usermod -u $(stat -c "%u" /var/jenkins_home) jenkins && \
        gosu jenkins /bin/tini -- /usr/local/bin/jenkins.sh
