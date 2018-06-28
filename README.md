# clusterio_systemd
A bash script and systemd unit file for service based startup/shutdown of clusterio instances.

This is a non-exhaustive list of steps required to set up a systemd service for the Factorio mod Clusterio. It assumes you understand how tmux, systemd, Factorio, and Clusterio work. This list also assumes you're using Ubuntu Server 16.04 and have set up a new user "factorio" with its home directory at /opt/factorio. The clusterio folder in my test environment lives at /opt/factorio/factorioClusterio.

1. Create your systemd unit file in /etc/systemd/system/factorio-clusterio.service
2. ExecStart specifies the startCluster.sh script. We'll set this up in a moment.
3. Create an ExecStop line for each server to warn users of server shutdown, pause, then CTRL-C each clusterio instance and the clusterio master. The systemd file included in this repo is from my test enviornment with the clusterio master and two client instances. You should be able to add more instances as long as you follow the example provided.
4. Create the Clusterio startup script in your Clusterio folder, in my case /opt/factorio/factorioClusterio/startCluster.sh
5. Add the tmux new-session command for the master and each server instance in your cluster. For reference, "-c" specifies the working directory for the command in double-quotes, "-s" specifies the tmux session name, and "-n" specifies the tmux window name. I usually just make the "-s" and "-n" names the same, although you can do fancy things like run all your instances in the same tmux session in separate windows.
6. Use chmod +x to make startCluster.sh executable
7. Run `sudo systemctl start factorio-clusterio.service`
8. As user factorio, run `tmux ls` to see if your instances and master are running. You can attach to tmux sessions using `tmux a -t SESSIONNAME`
9. If everything seems to be running correctly, run `sudo systemctl stop factorio-clusterio.service` to make sure everything shuts down gracefully. If you use the same pause timers I did in the systemd unit file, this will take at least 25 seconds. This tells players on the servers that the server is shutting down, waits 5 seconds, sends CTRL-C to all instances, waits 15 seconds for instances to allow sufficient time for saving big maps, sends CTRL-C to master, waits 5 seconds, done.
10. If everything still seems to be working correctly, you can enable the systemd file to run at startup. This is what I do on my machine. If I run system updates and reboot, all my Factorio servers and Clusterio stuff are shut down automatically and gracefully, then automatically start back up after the reboot.

This was made by me without any collab with Danielv123, so don't expect his support for this. I'm generally availble on Discord, and I'll stick around in the Clusterio Discord server. Feel free to mention @electricOzone there and I'll try to provide assistance as I'm available. No promises though :)
