#!/bin/bash
CLUSTER_ROOT="$HOME/.klei/DoNotStarveTogether/DSTWhalesCluster"

# Check for game updates before each start. If the game client updates and your server is out of date, you won't be
# able to see it on the server list. If that happens just restart the containers and you should get the latest version
if [ "${checkupdate:'false'}" == "true" ]; then
  /home/dst/steamcmd.sh +@ShutdownOnFailedCommand 1 +@NoPromptForPassword 1 +force_install_dir $HOME/server_dst/bin +login anonymous +app_update 343050 validate +quit
fi

if [ -n "$cluster_token" ]; then
  echo "Setting cluster token from environment"
  echo "$cluster_token" > $CLUSTER_ROOT/cluster_token.txt
fi

if [ -n "$adminlist" ]; then
  cat ConfigTemplates/adminlist.txt | envsubst > "$CLUSTER_ROOT/adminlist.txt"
fi

if [ -n "$blocklist" ]; then
  cat ConfigTemplates/blocklist.txt | envsubst > "$CLUSTER_ROOT/blocklist.txt"
fi

# Template config from environment variables
cat ConfigTemplates/cluster.ini | envsubst > "$CLUSTER_ROOT/cluster.ini"

# Copy ClusterConfig into cluster's root directory
if [ -d "$HOME/ClusterConfig" ]; then
  cp -r $HOME/ClusterConfig/* $CLUSTER_ROOT/
fi

cd $HOME/server_dst/bin
./dontstarve_dedicated_server_nullrenderer -cluster DSTWhalesCluster -shard "$SHARD_NAME"
