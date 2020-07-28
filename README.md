# 📦 cgit-in-a-box

This configuration and docker image is build to be a quick and instantaneous way to setup a cgit.
It should not take more effort to deploy than to open a box.

This image provides a preconfigured cgit web interface, which can be easily attached to a reverse proxy.

## Usage

To build the container simply type:

```
$ make
```

And to run:

```
$ docker run -p 8080:80 -p 9418:9418 -v ./cgitrc:/etc/cgitrc -v /srv/git:/srv/git cgit-in-a-box
```

If ssh access to the container is required you can also add your public id to authorized keys
```
$ docker run -p 8080:80 -p 9418:9418 -p 2222:22 -v ./cgitrc:/etc/cgitrc -v /srv/git:/srv/git -v ./id_rsa.pub:/root/.ssh/authorized_keys cgit-in-a-box
```

### Using docker-compose

An example using docker-compose of how to mount a custom
configuration for Nginx:

```yml
version: "3"

services:
  cgit:
    image: cgit-in-a-box
    ports:
      - "2222:22"
      - "9418:9418"
      - "8080:80"
    volumes:
      - /srv/git:/srv/git
      - ./cgitrc:/etc/cgitrc
      - ./id_rsa.pub:/root/.ssh/authorized_keys
```

Thanks to the original authors from which this repository is a derivative from [check them out here](https://github.com/marcopompili/docker-nginx-cgit).
