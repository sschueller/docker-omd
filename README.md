omd-docker
==========

[Dockerfile](https://www.docker.com) for [Open Monitoring Distribution (OMD)](http://omdistro.org).

Run from Docker Hub
-------------------

A pre-built image is available on [Docker Hub](https://registry.hub.docker.com/u/lichti/omd-docker) and can be run as follows:

    docker run -d -t -p 80:80 --name 'omd-docker' --hostname 'omd-docker' lichti/omd-docker

This will leave a shell open to access the container.

OMD will become available on [http://172.X.X.X/default](http://172.X.X.X/default).
The default login is `omdadmin` with password `omd`.
To find out the IP address, run `ip addr` in the container shell.


