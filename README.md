# ExtremeSystem.Example

This is example project for using Extreme.System. It is set of building block usefull for CQRS+ES systems.


## Dependencies

### EventStore


## Running system

### Get the example

    $ git clone https://github.com/exponentially/extreme_system_example.git
    $ cd extreme_system_example
    $ mix deps.get

### Run local event store

First time pull docker image:

    $ docker run --name eventstore4.1 -it -p 2113:2113 -p 1113:1113 -e EVENTSTORE_RUN_PROJECTIONS=all -e EVENTSTORE_START_STANDARD_PROJECTIONS=true eventstore/eventstore

Docker container can be stopped as follows

    $ docker stop eventstore4.1

Next time you want to start it, just start container:

    $ docker start eventstore4.1

### Run beam nodes (api and users)

- From new terminal go to api folder and run it:

    $ cd apps/api
    $ ./run.sh

  You should have opened iex with something like:

```
Erlang/OTP 21 [erts-10.0.5] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:1] [hipe]

2018-09-07 14:24:16.278 [info] pid=<0.295.0> Starting ExtremeSystem.Example.Api in :normal mode
2018-09-07 14:24:16.282 [info] pid=<0.295.0> Trying to connect node :example_api@mystique to: ["ExSysApi", "ExSysUsers"]
2018-09-07 14:24:16.285 [error] pid=<0.58.0>
** Cannot get connection id for node :example_api@mystique

2018-09-07 14:24:16.353 [info] pid=<0.312.0> Running ExtremeSystem.Example.Api.Endpoint with Cowboy using http://0.0.0.0:4000
Interactive Elixir (1.7.3) - press Ctrl+C to exit (type h() ENTER for help)
iex(example_api@mystique)1> 2018-09-07 14:24:17.305 [info] pid=<0.300.0> Connected nodes: []
```

- From the other terminal, go to users folder and run it:

    $ cd apps/users
    $ ./run.sh

Nodes should connect to cluster as you may see in iex:

```
Erlang/OTP 21 [erts-10.0.5] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:1] [hipe]

2018-09-07 14:25:43.259 [info] pid=<0.266.0> Starting ExtremeSystem.Example.Users in :normal mode
2018-09-07 14:25:43.262 [info] pid=<0.266.0> Trying to connect node :es_users@mystique to: ["ExSysApi", "ExSysUsers"]
2018-09-07 14:25:43.282 [error] pid=<0.58.0>
** Cannot get connection id for node :es_users@mystique

2018-09-07 14:25:43.315 [info] pid=<0.286.0> Connecting Extreme to 127.0.0.1:1113
2018-09-07 14:25:43.316 [info] pid=<0.286.0> Successfully connected to EventStore using protocol version 3
Interactive Elixir (1.7.3) - press Ctrl+C to exit (type h() ENTER for help)
iex(es_users@mystique)1> 2018-09-07 14:25:44.283 [info] pid=<0.272.0> Connected nodes: [:example_api@mystique]
```

### Calling API

There is Postman collection in `apps/api/doc/ExtremeSystem.Example.postman_collection.json`

You can try it using curl as well:

- Register new user:

```
curl -X POST \
  http://localhost:4000/users \
  -v \
  -H 'Accept: application/json' \
  -H 'Cache-Control: no-cache' \
  -H 'Content-Type: application/json' \
  -d '{
    "email": "user.1@example.com",
    "name": "Milan"
}'
```

Last line of output should be:

```
{"id":"05c03d0c-b29a-11e8-aff9-acbc32d4fe0b"}
```

If so, that is ID of your new User. You can confirm that in EventStore as well @ http://localhost:2113/web/index.html#/streams/ex_users-05c03d0c-b29a-11e8-aff9-acbc32d4fe0b

- Once you have registered user, you can change it's name:

```
curl -X PUT \
  http://localhost:4000/users/05c03d0c-b29a-11e8-aff9-acbc32d4fe0b \
  -v \
  -H 'Accept: application/json' \
  -H 'Cache-Control: no-cache' \
  -H 'Content-Type: application/json' \
  -d '{
  "version": 2,
    "name": "Milan II"
}'
```

You should get 204 back and new aggregate version in header:

```
< x-aggregate-version: 2
```

You should also notice new event in that users stream.
