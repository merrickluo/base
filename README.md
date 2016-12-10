# Base Image

[![Circle CI](https://circleci.com/gh/ahxxm/base/tree/master.svg?style=svg)](https://circleci.com/gh/ahxxm/base/tree/master)

for personal use.

List:

- `nginx`: with http2 and chacha20, default user is `www-data`.

- `shadowsocks-libev`: latest master, Dockerfile mostly copied from `docker/alpine/Dockerfile` of origin repo.

- `ipython`: python3 ipython notebook with `numpy`, `pandas` and `matplotlib` installed. 


## Notes

The IPython image use `/tmp/ipython` as notebook directory, run with `volumes` to store notebooks on host machine.

Default port is 8888, password is `L1b&MQ`, set them through `$PASSWORD` and `$NOTEBOOK_PORT`.

