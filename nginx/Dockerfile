FROM alpine:latest

# Optimize for cache
COPY nginx.sh /nginx.sh

# Nginx build
RUN /nginx.sh && \
  rm /nginx.sh

EXPOSE 80 443
CMD ["nginx"]
