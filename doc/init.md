Sample init scripts and service configuration for rheixd
==========================================================

Sample scripts and configuration files for systemd, Upstart and OpenRC
can be found in the contrib/init folder.

    contrib/init/rheixd.service:    systemd service unit configuration
    contrib/init/rheixd.openrc:     OpenRC compatible SysV style init script
    contrib/init/rheixd.openrcconf: OpenRC conf.d file
    contrib/init/rheixd.conf:       Upstart service configuration file
    contrib/init/rheixd.init:       CentOS compatible SysV style init script

Service User
---------------------------------

All three Linux startup configurations assume the existence of a "rheixcore" user
and group.  They must be created before attempting to use these scripts.
The OS X configuration assumes rheixd will be set up for the current user.

Configuration
---------------------------------

At a bare minimum, rheixd requires that the rpcpassword setting be set
when running as a daemon.  If the configuration file does not exist or this
setting is not set, rheixd will shutdown promptly after startup.

This password does not have to be remembered or typed as it is mostly used
as a fixed token that rheixd and client programs read from the configuration
file, however it is recommended that a strong and secure password be used
as this password is security critical to securing the wallet should the
wallet be enabled.

If rheixd is run with the "-server" flag (set by default), and no rpcpassword is set,
it will use a special cookie file for authentication. The cookie is generated with random
content when the daemon starts, and deleted when it exits. Read access to this file
controls who can access it through RPC.

By default the cookie is stored in the data directory, but it's location can be overridden
with the option '-rpccookiefile'.

This allows for running rheixd without having to do any manual configuration.

`conf`, `pid`, and `wallet` accept relative paths which are interpreted as
relative to the data directory. `wallet` *only* supports relative paths.

For an example configuration file that describes the configuration settings,
see `contrib/debian/examples/rheix.conf`.

Paths
---------------------------------

### Linux

All three configurations assume several paths that might need to be adjusted.

Binary:              `/usr/bin/rheixd`  
Configuration file:  `/etc/rheixcore/rheix.conf`  
Data directory:      `/var/lib/rheixd`  
PID file:            `/var/run/rheixd/rheixd.pid` (OpenRC and Upstart) or `/var/lib/rheixd/rheixd.pid` (systemd)  
Lock file:           `/var/lock/subsys/rheixd` (CentOS)  

The configuration file, PID directory (if applicable) and data directory
should all be owned by the rheixcore user and group.  It is advised for security
reasons to make the configuration file and data directory only readable by the
rheixcore user and group.  Access to rheix-cli and other rheixd rpc clients
can then be controlled by group membership.

### Mac OS X

Binary:              `/usr/local/bin/rheixd`  
Configuration file:  `~/Library/Application Support/RheixCore/rheix.conf`  
Data directory:      `~/Library/Application Support/RheixCore`
Lock file:           `~/Library/Application Support/RheixCore/.lock`

Installing Service Configuration
-----------------------------------

### systemd

Installing this .service file consists of just copying it to
/usr/lib/systemd/system directory, followed by the command
`systemctl daemon-reload` in order to update running systemd configuration.

To test, run `systemctl start rheixd` and to enable for system startup run
`systemctl enable rheixd`

### OpenRC

Rename rheixd.openrc to rheixd and drop it in /etc/init.d.  Double
check ownership and permissions and make it executable.  Test it with
`/etc/init.d/rheixd start` and configure it to run on startup with
`rc-update add rheixd`

### Upstart (for Debian/Ubuntu based distributions)

Drop rheixd.conf in /etc/init.  Test by running `service rheixd start`
it will automatically start on reboot.

NOTE: This script is incompatible with CentOS 5 and Amazon Linux 2014 as they
use old versions of Upstart and do not supply the start-stop-daemon utility.

### CentOS

Copy rheixd.init to /etc/init.d/rheixd. Test by running `service rheixd start`.

Using this script, you can adjust the path and flags to the rheixd program by
setting the RHEIXD and FLAGS environment variables in the file
/etc/sysconfig/rheixd. You can also use the DAEMONOPTS environment variable here.

### Mac OS X

Copy org.rheix.rheixd.plist into ~/Library/LaunchAgents. Load the launch agent by
running `launchctl load ~/Library/LaunchAgents/org.rheix.rheixd.plist`.

This Launch Agent will cause rheixd to start whenever the user logs in.

NOTE: This approach is intended for those wanting to run rheixd as the current user.
You will need to modify org.rheix.rheixd.plist if you intend to use it as a
Launch Daemon with a dedicated rheixcore user.

Auto-respawn
-----------------------------------

Auto respawning is currently only configured for Upstart and systemd.
Reasonable defaults have been chosen but YMMV.
