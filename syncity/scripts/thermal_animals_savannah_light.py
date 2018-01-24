import random
import subprocess
import os
import pathlib
import time
from .. import common, helpers, settings_manager
from random import randint

settings = settings_manager.Singleton()

def help():
	return '''\
Animals thermal in Savannah scene
	- Creates a RGB camera
	- Creates a Thermal camera
	- Creates a Depth camera
	- Creates a Segmentation camera
	- Spawns animals, people and cars with random distribution at savannah
	- Flys around as a drone, rotating height , distance and azimuth
	- Exports depth maps, rgb images, thermal images, segmentation images and bounding boxes
'''

def run():
	settings.keep = True
	mycams = ['cameras/cameraRGB', 'cameras/thermal', 'cameras/segmentation', 'cameras/depth']
	
	dist = 7000
	azimuth = 0
	elevation = 72
	y_rot = 0
	snapOffset = 60
	
	snapOffset_range = [ 55, 65 ]
	elevation_range = [ 32, 72 ]
	
	incr_e = -.25 # elevation increment
	incr_a = .5 # azimuth increment
	incr_d = -2.5 # distance increment
	incr_s = .5 # snap offset increment
	
	min_agc = 9
	max_agc = 35
	
	terrain_ambient_offset = 0
	terrain_ambient_bandwidth = 50
	terrain_ambient_median = 0
	
	if settings.skip_setup == False:
		# scenario goes first as it's the base for all objects to be placed upon
		common.send_data([
			'CREATE savannah tiles Savannah',
			'savannah ADD WindZone',
			'savannah SET active true'
		])
		
		# camera setup
		helpers.global_camera_setup(
			orbitOffset=[1667.05, 32.37876, 1000],
			orbitSnap=snapOffset,
			orbitGround='savannah/Main Terrain'
		)
		
		helpers.add_camera_seg(
			width=1024, height=768, fov=90, clipping_far=10000,
			segments=['Car', 'Animal', 'Human'], lookupTable=[['Car', 'red'], ['Animal', 'blue'], ['Human', 'green']]
		)
		
		helpers.add_camera_rgb(
			width=1024, height=768, pp='EnviroFX',
			fov=90,
			clipping_far=10000
		)
		
		helpers.add_camera_depth(width=1024, height=768, fov=90)
		
		helpers.add_camera_thermal(
			fov=90,
			clipping_far=10000,
			
			trees=True,
			ambientTemperature=15, minimumTemperature=9, maximumTemperature=35,
			trees_base=8, trees_bandwidth=50, trees_median=0, trees_leafs_variance=10,
		)
		
		helpers.global_disk_setup()
		helpers.add_disk_output(mycams)
		
		# spawn objects in a rectangular shape
		helpers.spawn_rectangle_generic(
			['+animal, +thermal, +savannah', '+carthermal', '+humans' ],
			names=['animals0', 'cars0', 'humans0'],
			segmentation_class=['Animal', 'Car', 'Human'],
			limit=50, a=1000, b=1000, position=[1685, 591, 7894],
			collision_check=True,
			stick_to_ground=True
		)
		
		# fine tune specifics
		common.send_data([
			'"savannah/Main Terrain" SET Thermal.ThermalTerrain ambientOffset {}'.format(terrain_ambient_offset),
			'"savannah/Main Terrain" SET Thermal.ThermalTerrain bandwidth {}'.format(terrain_ambient_bandwidth),
			'"savannah/Main Terrain" SET Thermal.ThermalTerrain median {}'.format(terrain_ambient_median),
			
			# HACK: set profiles heatiness to high values so objects are visible
			'"spawner/cars0/RangeRover(Clone)" SET Thermal.ThermalObjectBehaviour profile.heatiness.value 50',
			
			'"spawner/animals0/Rino(Clone)" SET Thermal.ThermalObjectBehaviour profile.heatiness.value 100',
			'"spawner/animals0/giraffe(Clone)" SET Thermal.ThermalObjectBehaviour profile.heatiness.value 75',
			'"spawner/animals0/Buffalo(Clone)" SET Thermal.ThermalObjectBehaviour profile.heatiness.value 100',
			'"spawner/animals0/Pelican(Clone)" SET Thermal.ThermalObjectBehaviour profile.heatiness.value 100',
			'"spawner/animals0/Flamingo(Clone)" SET Thermal.ThermalObjectBehaviour profile.heatiness.value 100',
			'"spawner/animals0/Vulture_Red(Clone)" SET Thermal.ThermalObjectBehaviour profile.heatiness.value 100',
			'"spawner/animals0/Vulture_White(Clone)" SET Thermal.ThermalObjectBehaviour profile.heatiness.value 100',
			'"spawner/animals0/Elef(Clone)" SET Thermal.ThermalObjectBehaviour profile.heatiness.value 90',
			
			# respawn assets to update thermal profiles properly
			'spawner SET active false',
			
			# add more props
			'spawner/cars0 SET RandomProps.PropArea numberOfProps 50',
			'spawner/animals0 SET RandomProps.PropArea numberOfProps 250',
			'spawner/humans0 SET RandomProps.PropArea numberOfProps 250',
			
			'spawner SET active true'
		], read=False)
	
	# warm up
	helpers.do_render(mycams)
	
	if settings.setup_only == True:
		return
	
	loop = 0
	
	# loop changing camera positions with random agc bounduaries
	while loop < 500:
		common.send_data([
			'cameras/thermal SET Thermal.ThermalCamera temperatureRange ({} {})'.format(min_agc, max_agc),
			'cameras SET Orbit distance {}'.format(dist),
			'cameras SET Orbit elevation {}'.format(elevation),
			'cameras SET Orbit azimuth {}'.format(azimuth),
			'cameras SET Orbit snapOffset {}'.format(snapOffset)
		], read=False)
		
		helpers.take_snapshot(mycams, auto_segment=True, force_noop=True)
		
		# random agc values
		min_agc = randint(-3, 5)
		max_agc = randint(30, 35)
		
		snapOffset = snapOffset + incr_s
		elevation = elevation + incr_e
		azimuth += incr_a
		dist += incr_d
		
		if dist <= 6500 or dist >= 7000:
			incr_d = incr_d * -1
		if elevation >= elevation_range[1] or elevation <= elevation_range[0]:
			incr_e = incr_e * -1
		if snapOffset >= snapOffset_range[1] or snapOffset <= snapOffset_range[0]:
			incr_s = incr_s * -1
		if azimuth >= 360:
			azimuth = 0
		
		loop = loop + 1
		common.output('Loop {}'.format(loop))
