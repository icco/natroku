# natroku

"Container management for the unemployed".

*NOTE*: As of 2015-03-29, this does not work and is just a theory. Hit me up if you have questions about development or helping out (or just send a pull request or file issues).

## Design

natroku is actually three pieces of software (router, configd, dbc), each contained in a subdirectory of this repo. The idea is this system could run all on a single host, or spread out across many.

### Router

The router is pretty simple. Given a request on port 80 (or whatever port you want) it looks at its configuration and forwards that on to a Docker container described as the source for the domain the request is for. Currently it only supports HTTP. If user visits raw IP, return 410.

### Configuration Server (configd)

A polling server that uses Git as a database. It looks at all of the containers it knows about and writes out a config that represents the state of the world as it knows it. If the config has changed, it sends a notification to the router and dbc to reread their configuration.

### Database Controller (dbc)

This acts like the router, but instead acts on database requests, specifically postgresql connections.

## Alternatives

This is a heavily evolving area, I pulled a lot of this from [Stack Overflow](http://stackoverflow.com/questions/18285212/how-to-scale-docker-containers-in-production/18287169#18287169) and a [random mindmap](https://www.mindmeister.com/389671722/docker-ecosystem).

So if you look at a lot of the solutions, like [Mesos](https://mesos.apache.org/), [Kubernetes](http://kubernetes.io/), [Decking](http://decking.io/), [Helios](https://github.com/spotify/helios), [Flynn](https://flynn.io/), [Lattice](http://lattice.cf/index.html), [CoreOS](https://coreos.com/) and [Deis](http://deis.io/), they all require a ton of resources.

Below I'm going to try and break down the features and minimum footprint needed for each.
