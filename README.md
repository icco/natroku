# natroku

"Container management for the unemployed".

## Design

natroku is actually three pieces of software (router, configd, dbc), each contained in a subdirectory of this repo. The idea is this system could run all on a single host, or spread out across many.

### Router

The router is pretty simple. Given a request on port 80 (or whatever port you want) it looks at its configuration and forwards that on to a Docker container described as the source for the domain the request is for. Currently it only supports HTTP. If user visits raw IP, return 410.

### Configuration Server (configd)

A polling server that uses Git as a database. It looks at all of the containers it knows about and writes out a config that represents the state of the world as it knows it. If the config has changed, it sends a notification to the router and dbc to reread their configuration.

### Database Controller (dbc)

This acts like the router, but instead acts on database requests, specifically postgresql connections.
