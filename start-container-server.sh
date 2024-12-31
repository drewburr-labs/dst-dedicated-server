#!/bin/bash
CLUSTER_ROOT="$HOME/.klei/DoNotStarveTogether/DSTWhalesCluster"

# Check for game updates before each start. If the game client updates and your server is out of date, you won't be
# able to see it on the server list. If that happens just restart the containers and you should get the latest version
if [ "${checkupdate:'false'}" == "true" ]
then
  /home/dst/steamcmd.sh +@ShutdownOnFailedCommand 1 +@NoPromptForPassword 1 +force_install_dir /home/dst/server_dst +login anonymous +app_update 343050 validate +quit
fi

# Copy dedicated_server_mods_setup.lua
ds_mods_setup="$CLUSTER_ROOT/mods/dedicated_server_mods_setup.lua"
if [ -f "$ds_mods_setup" ]
then
  cp $ds_mods_setup "$HOME/server_dst/mods/"
fi

# Copy modoverrides.lua
modoverrides="$CLUSTER_ROOT/mods/modoverrides.lua"
if [ -f "$modoverrides" ]
then
  cp $modoverrides "$CLUSTER_ROOT/Master/"
  cp $modoverrides "$CLUSTER_ROOT/Caves/"
fi

if [ -n "$cluster_token" ]
then
  echo "Setting cluster token from environment"
  echo "$cluster_token" > $CLUSTER_ROOT/cluster_token.txt
fi

if [ -n "$adminlist" ]
then
  cat DSTConfigTemplates/adminlist.txt | envsubst > "$CLUSTER_ROOT/adminlist.txt"
fi

if [ -n "$blocklist" ]
then
  cat DSTConfigTemplates/blocklist.txt | envsubst > "$CLUSTER_ROOT/blocklist.txt"
fi
# Template config from environment variables
cat DSTConfigTemplates/cluster.ini | envsubst > "$CLUSTER_ROOT/cluster.ini"

exit
cd $HOME/server_dst/bin
./dontstarve_dedicated_server_nullrenderer -cluster DSTWhalesCluster -shard "$SHARD_NAME"
