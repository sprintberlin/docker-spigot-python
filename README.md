## Minecraft server SpigotMC on Alpine and openjdk:8-jre updated 06/2020
[![](https://images.microbadger.com/badges/image/rickwargo/spigot.svg)](https://microbadger.com/images/rickwargo/spigot "Get your own image badge on microbadger.com")

This docker image builds and runs the Spigot version of Minecraft and embeds the RaspberryJuice plugin for programming with Python. 

For details on using this, refer to the PDF Document: Learn-to-Program-in-Python-with-Minecraft-and-Docker.pdf

If the spigot.jar is not found in the minecraft directory the system pulls down BuildTool and build a new spigot.jar from the latest
released minecraft.jar. Due to legal reasons you can build it yourself but you can't redistribute the finished jar file.

## Starting the container

docker-compose up -d

### Accepting the End User License Agreement
Mojang now requires the end user to access their EULA, located at
https://account.mojang.com/documents/minecraft_eula, to be able to start the server.
This is already accepted in the eula.txt file.

## First time run

This will take a couple of minutes depending on computer and network speed. It will pull down
the selected version on BuildTools and build a spigot.jar from the selected minecraft version.
This is done in numerous steps so be patient. 

### Selecting version to compile

If you don't specify it will always compile the latest version but if you want a specific version you can specify it by changing the value in the Dockerfile.

	SPIGOT_VER=<version>

where <version> is the version you would like to use, to build it with version 1.8

	SPIGOT_VER=1.8

#### versions available

Please check the web page for [BuildTools](https://www.spigotmc.org/wiki/buildtools/#versions) to get the latest information. 

### Setup memory to use

There are two environment variables to set maximum and initial memory for spigot.

#### MC_MAXMEM

Sets the maximum memory to use <size>m for Mb or <size>g for Gb, if this parameter is not set 1 Gb is chosen, to set the maximum memory to 1536 Mb

    --MC_MAXMEM=2g

#### MC_MINMEM

sets the initial memory reservation used, use <size>m for Mb or <size>g for Gb, if this parameter is not set, it is set to MC_MAXMEM, to set the initial size t0 512 Mb

    --MC_MINMEM=512m

## Stopping the container

When the container is stopped with the command

	docker-compose down

the spigot server is shutdown nicely with a console stop command to give it time to save everything before
stopping the container. If you look in the output from the server this show

	[13:01:51 INFO]: Stopping the server
	[13:01:51 INFO]: Stopping server
	[13:01:51 INFO]: Saving players
	[13:01:51 INFO]: nimmis lost connection: Server closed
	[13:01:51 INFO]: nimmis left the game.
	[13:01:51 INFO]: Saving worlds
	[13:01:51 INFO]: Saving chunks for level 'world'/Overworld
	[13:01:51 INFO]: Saving chunks for level 'world_nether'/Nether
	[13:01:51 INFO]: Saving chunks for level 'world_the_end'/The End
	
## auto start docker-compose on boot (debian)
Example systemctl-service file: `systemctl-startup.dist`
more here: https://philipp-weissmann.de/docker-compose_mit_systemd/
systemctl start dc@docker-spigot-python

## Having the Minecraft files on the host machine

If you delete the container all your filer in minecraft will be gone. To save them where it's
easier to edit and do a backup of the files you can attach a directory from the host machine
(where you run the docker command) and attach it to the local file system in the container.
The syntax for it is

Change the volume mapping in the docker-compose.yml file.

Note the spigot files are internally kept at /spigot and the plugs are kept on /plugins. These do not need to be mapped to an external folder.