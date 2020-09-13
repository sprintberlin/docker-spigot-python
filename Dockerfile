FROM openjdk:8-jre-alpine

LABEL maintainer="Rick Wargo <github@epicminds.com>"

# Versions of libraries to use
ARG SPIGOT_VER=latest
ARG RASPBERRYJUICE_VER=1.12.1
ARG MC_MINMEM=2536M
ARG MC_MAXMEM=2536M

ENV SPIGOT_VER ${SPIGOT_VER}
ENV RASPBERRYJUICE_VER ${RASPBERRYJUICE_VER}
ENV MC_MINMEM ${MC_MINMEM}
ENV MC_MAXMEM ${MC_MAXMEM}

# Add git to image for building Spigot
RUN apk --update add git && \
    rm -rf /var/lib/apt/lists/* && \
    rm /var/cache/apk/*

WORKDIR /spigot

# Build Spigot
RUN wget https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar
RUN java -Xms${MC_MINMEM} -Xmx${MC_MAXMEM} -jar BuildTools.jar --rev $SPIGOT_VER
RUN rm -rf /root/.m2
RUN find * -maxdepth 0 ! -name '*.jar' -exec rm -rf {} \;
RUN mv spigot-*.jar spigot.jar;

WORKDIR /minecraft

# Download RaspberryJuice plugin
RUN mkdir /plugins
RUN wget -P /plugins https://github.com/zhuowei/RaspberryJuice/raw/master/jars/raspberryjuice-${RASPBERRYJUICE_VER}.jar

# expose minecraft port
EXPOSE 25565

# for mcpi
EXPOSE 4711

# CMD ["java", "-Xms$(MC_MINMEM)M", "-Xmx$(MC_MAXMEM)M", "-jar", "/spigot/spigot.jar", "--plugins", "/plugins", "--noconsole"]
CMD java -Xms${MC_MINMEM} -Xmx${MC_MAXMEM} -jar /spigot/spigot.jar --plugins /plugins