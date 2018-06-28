#!/bin/bash

/usr/bin/tmux new-session -d -c /opt/factorio/factorioClusterio -s factorioClusterio-master -n factorioClusterio-master "node master.js"

/usr/bin/tmux new-session -d -c /opt/factorio/factorioClusterio -s factorioClusterio-01_mall -n factorioClusterio-01_mall "node client.js start 01_mall"

/usr/bin/tmux new-session -d -c /opt/factorio/factorioClusterio -s factorioClusterio-02_mining -n factorioClusterio-02_mining "node client.js start 02_mining"
