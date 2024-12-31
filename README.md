# Don't Starve Together - Dedicated Server

[![Automated Docker Builds](https://img.shields.io/docker/automated/mathielo/dst-dedicated-server.svg)](https://cloud.docker.com/repository/docker/mathielo/dst-dedicated-server)
[![Docker Build State](https://img.shields.io/docker/build/mathielo/dst-dedicated-server.svg)](https://cloud.docker.com/repository/docker/mathielo/dst-dedicated-server)
[![Docker Image Pulls](https://img.shields.io/docker/pulls/mathielo/dst-dedicated-server.svg)](https://cloud.docker.com/repository/docker/mathielo/dst-dedicated-server)
[![License: MIT](https://img.shields.io/github/license/mathielo/dst-dedicated-server.svg)](https://github.com/mathielo/dst-dedicated-server/blob/master/LICENSE.md)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-round)](http://makeapullrequest.com)

DST Dedicated Server Guide for all platforms (Linux, Mac, Windows) with Docker.

The purpose of this project is to have DST servers up and running with the **bare minimum** necessary setup.

## Installation

Any OS that [supports Docker](https://docs.docker.com/engine/installation/#supported-platforms) can run the dedicated server.

### Essentials

These are the minimum required steps to have a server running:

- [Setup the host](#setup-the-host)
- [Setup the DST server](#setup-the-dst-server)
  - [Generate `cluster_token.txt`](#generate-a-cluster_token)
  - [Customize the server](#customize-the-server) (server name, password, etc.)

Here are additional docs that will help you maintain and manage your sever:

- [Manage the server](docs/ManagingTheServer.md) (how to start, save, and stop)
- How to optimize your [DST Server Performance](docs/ServerPerformance.md)
- [Set Admins, Bans and Whitelisted Players](docs/AdminBanWhitelist.md)

---

## Setup the Host

Read about [server performance](./docs/ServerPerformance.md) for useful tips to make the best use of your resources! That might also help you to [pick a host](./ServerPerformance.md#picking-a-host) machine if you're unsure about it.

Docker must be installed on the host OS

## Setup the DST server

### Generate a cluster_token

:warning: The cluster token is basically a password that links your server to your user account. Without it **your server won't run**!

Check the [detailed instructions to generate a cluster token](./docs/ClusterToken.md). After you get it, make sure to use it when setting the `cluster_token` envioronment variable when starting your sever.

> Note: Never share your cluster token!

## Manage the Server

You should now have everything you need to start playing! See the full docs on how to [manage your server](./docs/ManagingTheServer.md) to learn how to **start**, **save** the game and **stop** the server.

Keep on reading to learn how to :point_down: customize the server and world and [install mods](#mods) to your liking!

---

## Customize The Server

The following environment variables can be used to configure your sever:

| Variable            | Default     | Options                                   | Description                                                                                       |
| ------------------- | ----------- | ----------------------------------------- | ------------------------------------------------------------------------------------------------- |
| cluster_name        | ""          | **Required!** Name of the server          | Server name to be shown in the server list. Searchable in the game's server list                  |
| cluster_description | ""          | Description of the server                 | Server description to be shown in the server list                                                 |
| cluster_intention   | cooperative | cooperative, competitive, social, madness | Sever intention, shown in the server list. Searchable in the game's server list                   |
| cluster_password    | ""          | A random string                           | Optional. Set a password players must use when connecting to the server                           |
| game_mode           | survival    | survival, endless, wilderness             | Sets the server game mode                                                                         |
| max_players         | 16          | 1-64                                      | Limits the max number of players                                                                  |
| adminlist           | ""          |                                           | Comma-separated player IDs to grant admin access to                                               |
| blocklist           | ""          |                                           | Comma-separated player IDs to block from accessing the server                                     |
| pvp                 | false       | true, false                               | Enables PVP combat                                                                                |
| pause_when_empty    | true        | true,false                                | Pauses the server when no players are connected                                                   |
| vote_enabled        | true        | true, false                               | Enables voting features                                                                           |
| autosaver_enabled   | true        | true, false                               | Enables autosaving the server. Saves once per game day                                            |
| max_snapshots       | 6           | A non-negative number                     | Number of snapshots (saves) to retain. Available in the “Rollback” tab on the “Host Game” screen  |
| enable_vote_kick    | false       | true, false                               | Permits players to vote kick other players                                                        |
| tick_rate           | 15          | A number divisible into 60 (15, 20, 30)   | The number of updates/second that the server sends to clients. High values can reduce performance |
| connection_timeout  | 8000        | A non-negative number                     |                                                                                                   |
| console_enabled     | true        | true, false                               | Enables cross-platform play                                                                       |
| steam_group_id      | ""          | A quoted number                           | Your Steam Group ID                                                                               |
| steam_group_only    | true        | true, false                               | If this is set to true, GROUP MEMBERS ONLY will be allowed to join the server                     |
| cluster_key         |             | A random string                           | Optimally a randomly generated key. Should never change                                           |
| master_ip           | 127.0.0.1   |                                           | IP of the master shard. When using Docker compose, this is the network name                       |

> Note: For tips on how to identify user IDs, see [Setting Admins, Bans and Whitelisted Players](./docs/AdminBanWhitelist.md)

## Customize The World

Determines the settings for world generation for each shard, respectively:

- [ClusterConfig-example/Master/leveldataoverride.lua](./ClusterConfig-example/Master/leveldataoverride.lua)
- [ClusterConfig-example/Caves/leveldataoverride.lua](./ClusterConfig-example/Caves/leveldataoverride.lua)

You may tweak them as much as you like, granted that **Caves** will always have these defined:

```text
id="DST_CAVE"
location="Cave"
```

### Mods

Check the [cluster config instructions](./docs/ClusterConfig.md) on how to install, configure and enable mods.

---

## References

- [How to setup dedicated server with cave on Linux](http://steamcommunity.com/sharedfiles/filedetails/?id=590565473)
- [Dedicated Server Settings Guide](https://forums.kleientertainment.com/topic/64552-dedicated-server-settings-guide/)
- [Dedicated Server Command Line Options Guide](https://forums.kleientertainment.com/topic/64743-dedicated-server-command-line-options-guide/)

### Other links

- [Thread in Klei forums](https://forums.kleientertainment.com/topic/84574-dedicated-server-setup-guide-on-any-platform-windowsmaclinux-with-docker/)
- [Steam Guide](http://steamcommunity.com/sharedfiles/filedetails/?id=1206742951)

## Contributing

Contributions and feedback are always welcome! Feel free to open an [issue](/../../issues) or a [pull request](/../../pulls) to suggest improvements!

### Local testing

The server can be built and tested locally using the following commands:

```sh
# Build the Dockerfile
docker build . -t 'localhost/dst:local'

# Run the built contianer, being sure to replace 'cluster_token'
docker run -p 10999:10999/udp \
-v ./volumes/DSTWhalesCluster:/home/dst/.klei/DoNotStarveTogether/DSTWhalesCluster \
-v ./volumes/mods:/home/dst/server_dst/mods \
-v ./volumes/ClusterConfig:/home/dst/ClusterConfig \
-e SHARD_NAME=Master \
-e cluster_name='DST Dedicated Server running on Docker' \
-e cluster_description='Dedicated Server running on Docker' \
-e cluster_password='YouShallNotPass!!!' \
-e cluster_key='randomstring' \
-e cluster_token='REPLACEME' \
docker.io/library/dst:local

# If testing clustering, also run the Caves shard
docker run -p 10998:10998/udp \
-v ./volumes/DSTWhalesCluster:/home/dst/.klei/DoNotStarveTogether/DSTWhalesCluster \
-v ./volumes/mods:/home/dst/server_dst/mods \
-v ./volumes/ClusterConfig:/home/dst/ClusterConfig \
-e SHARD_NAME=Caves \
-e cluster_name='DST Dedicated Server running on Docker' \
-e cluster_description='Dedicated Server running on Docker' \
-e cluster_password='YouShallNotPass!!!' \
-e cluster_key='randomstring' \
-e cluster_token='REPLACEME' \
docker.io/library/dst:local
```
