import subprocess
import os
import pathlib
import time
from .. import common, helpers, settings_manager
from random import randint

settings = settings_manager.Singleton()

def help():
	return '''\
Jumanji
'''

def args(parser):
	try:
		parser.add_argument('--loop_limit', type=int, default=500, help='Defines a limit of iterations for exporting')
	except: pass

def run():
	loop = 0
	mycams = ['Camera/rgb', 'Camera/Thermal', 'Camera/Segmentation']
	
	common.waitQueue()
	
	# loop changing camera positions with random agc bounduaries
	while loop < settings.loop_limit:
		# "disk1" EXECUTE Sensors.Disk Snapshot
		# "Camera/Segmentation" GET Segmentation.Output.FilteredBoundingBoxes filteredBoundingBoxes
		
		helpers.takeSnapshot(mycams, autoSegment=True)
		
		common.sendData([
			'"Camera" SET Transform localPosition (-10~10 0.5~2 -50~0)',
			'"Camera" SET Transform localEulerAngles (-15~-10 -40~40 -10~10)',
			'"EnviroSky" SET EnviroSky GameTime.Hours 0~24',
			'"EnviroSky" EXECUTE EnviroSky ChangeWeather 0~9',
			'[RandomProps.Spawner] ShuffleAll "Parked Cars W" "Parked Cars E" "Trees W" "Trees E" "Animals" "Cars" "Trees" "Bird" "Signs" "Grounds" "Trafficlights" "Misc" "Humans"'
		])
		loop += 1
		common.output('Loop {} ({}%)'.format(loop, round(100 * (loop / settings.loop_limit),2)))
