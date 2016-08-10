# Set $PASSWORD and $NOTEBOOK_PORT before use

FROM alpine:latest
WORKDIR /root/.jupyter/
ADD . ./
RUN ./build.sh
CMD ["/root/.jupyter/start.sh"]
