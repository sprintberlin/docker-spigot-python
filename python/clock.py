from mcpi.minecraft import Minecraft
from time import sleep
import datetime


mc = Minecraft.create('127.0.0.1')

# x, y, z = mc.player.getTilePos()

x, y, z = (-74, 67, 259)

# x += 20

mc.setBlocks(x+3,y,z-4,x+3,y+10,z+5,42)

while True:
    second = datetime.datetime.now().second
    s1 = int(second/10)
    s2 = second - 10*s1
    minute = datetime.datetime.now().minute
    m1 = int(minute/10)
    m2 = minute - 10*m1
    hour = datetime.datetime.now().hour
    h1 = int(hour/10)
    h2 = hour - 10*h1

    mc.setBlocks(x+2,y,z,x+2,y+9,z+4,0)

    mc.setBlocks(x+2,y,z-3,x+2,y+h1,z-3,4)
    mc.setBlocks(x+2,y,z-2,x+2,y+h2,z-2,4)

    mc.setBlocks(x+2,y,z,x+2,y+m1,z,4)
    mc.setBlocks(x+2,y,z+1,x+2,y+m2,z+1,4)
    
    mc.setBlocks(x+2,y,z+3,x+2,y+s1,z+3,4)
    mc.setBlocks(x+2,y,z+4,x+2,y+s2,z+4,4)

    mc.setBlocks(x+2,y,z-3,x+2,y,z+4,0)

    sleep(1)