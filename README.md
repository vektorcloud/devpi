# docker-devpi

![circleci][circleci]

Alpine-based Docker build providing pypi package caching and local index with devpi

## Usage

Bring up the devpi server with:
```bash
docker run -d --name devpi -p 3141:3141 quay.io/vektorcloud/devpi:latest
```

and add the following to your ~/.pip/pip.conf:
```
[global]
Index-url = http://<DEVPI HOST>:3141/root/pypi/+simple/
[global]
Extra-index-url = http://<DEVPI HOST>:3141/root/dev/+simple/
```

That's it! Pypi packages will now be retrieved via the devpi cache

## Uploading a package

To upload a package to your devpi repo, make sure you have a working setup.py script in your code directory and run:
```bash
devpi use <DEVPI_URL>
devpi login root --password=''
devpi use dev && \
devpi upload
```

## Healthcheck

A healthcheck is included in this image -- to disable, start the container with the `--no-healthcheck` option

## Troubleshooting

If you don't have an loadbalancer providing SSL to devpi, you may get an SSL warning when trying to install packages. This can be circumvented during testing by appending `--trusted-host <DEVPI HOST>` to your pip install commands, e.g `pip install --trusted-host localhost pytest`

[circleci]: https://img.shields.io/circleci/build/gh/vektorcloud/devpi?color=1dd6c9&logo=CircleCI&logoColor=1dd6c9&style=for-the-badge "devpi"
