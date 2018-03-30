FROM fedora:latest

RUN dnf -y install copr-cli jq

ADD bin /opt/resource
