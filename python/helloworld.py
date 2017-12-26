from mcpi.minecraft import Minecraft


mc = Minecraft.create('127.0.0.1')
msg = 'Hello World!'
mc.postToChat(msg)
