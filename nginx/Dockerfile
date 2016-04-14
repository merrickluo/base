FROM alpine:latest


# Optimize for cache
# COPY init.d.nginx /etc/init.d/nginx
COPY nginx.sh /nginx.sh

# TODO: init.d?
# TODO: nginx conf

# Nginx build dependencies
RUN /nginx.sh && \
  rm /nginx.sh

EXPOSE 80 443
CMD ["nginx"]
