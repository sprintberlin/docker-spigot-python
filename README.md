## Minecraft server SpigotMC on Alpine and openjdk:8-jre
[![](https://images.microbadger.com/badges/image/rickwargo/spigot.svg)](https://microbadger.com/images/rickwargo/spigot "Get your own image badge on microbadger.com")

This docker image builds and runs the Spigot version of Minecraft and embeds the RaspberryJuice plugin for programming with Python. 

If the spigot.jar is not found in the minecraft directory the system pulls down BuildTool and build a new spigot.jar from the latest
released minecraft.jar. Due to legal reasons you can build it yourself but you can't redistribute the finished jar file.

## Starting the container

To run the latest stable version of this docker image run

	docker run -p 25565:25565 -p 4711:4711 rickwargo/docker-spigot-python

The parameter

	-p 25565:25565

tells on which external port the internal tcp port 25565 should be connected, in this case the same, if
you only type -p 25565 it will connect to a random port on the machine.

The parameter

	-p 4711:4711

tells on which external port the internal tcp port 4711 should be connected. This is for the RaspberryJuice Plug-in.

### Giving the container a name

To make it easier to handle you container you can give it a name instead of the long
number thats normally give to it, add a

	--name spigot

to the run command to give it the name minecraft, then you can start it easier with

	docker start spigot
	docker stop spigot

### Accepting the End User License Agreement
Mojang now requires the end user to access their EULA, located at
https://account.mojang.com/documents/minecraft_eula, to be able to start the server.
This is already accepted in the eula.txt file.

## First time run

This will take a couple of minutes depending on computer and network speed. It will pull down
the selected version on BuildTools and build a spigot.jar from the selected minecraft version.
This is done in numerous steps so be patient. 

    docker build -t rickwargo/docker-spigot-python .

### Selecting version to compile

If you don't specify it will always compile the latest version but if you want a specific version you can specify it by adding

	--build-arg SPIGOT_VER=<version>

where <version> is the version you would like to use, to build it with version 1.8 add

	--build-arg SPIGOT_VER=1.8

to the docker run line.

#### versions available

Please check the web page for [BuildTools](https://www.spigotmc.org/wiki/buildtools/#versions) to get the latest information. 

### Setup memory to use

There are two environment variables to set maximum and initial memory for spigot.

#### MC_MAXMEM

Sets the maximum memory to use <size>m for Mb or <size>g for Gb, if this parameter is not set 1 Gb is chosen, to set the maximum memory to 1536 Mb

    --build-arg MC_MAXMEM=2g

#### MC_MINMEM

sets the initial memory reservation used, use <size>m for Mb or <size>g for Gb, if this parameter is not set, it is set to MC_MAXMEM, to set the initial size t0 512 Mb

    --build-arg MC_MINMEM=512m

## Stopping the container

When the container is stopped with the command

	docker stop spigot

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

## Having the Minecraft files on the host machine

If you delete the container all your filer in minecraft will be gone. To save them where it's
easier to edit and do a backup of the files you can attach a directory from the host machine
(where you run the docker command) and attach it to the local file system in the container.
The syntax for it is

	-v /host/path/to/dir:/container/path/to/dir

To attach the minecraft directory in the container to directory ~/docker-spigot-python/minecraft you add

	-v ~/docker-spigot-python/minecraft:/minecraft

Note the spigot files are internally kept at /spigot and the plugs are kept on /plugins. These do not need to be mapped to an external folder.

## Issues

If you have any problems with or questions about this image, please contact us by submitting a ticket through a [GitHub issue](https://github.com/rickwargo/docker-spigot-python/issues "GitHub issue")

1. Look to see if someone already filled the bug, if not add a new one.
2. Add a good title and description with the following information.
 - any logs relevant for the problem
 - how the container was started (flags, environment variables, mounted volumes etc)
 - any other information that can be helpful

## Contributing

You are invited to contribute new features, fixes, or updates, large or small; we are always thrilled to receive pull requests, and do our best to process them as fast as we can.