CREATE "cameras"
"cameras" SET active false
"cameras" SET Transform position (-6 1 -50) eulerAngles (0 0 0)
CREATE "cameras/cameraRGB"
"cameras/cameraRGB" SET active false
"cameras/cameraRGB" ADD Camera Sensors.RenderCamera AudioListener
"cameras/cameraRGB" SET Camera near 0.3 far 1000 fieldOfView 60 renderingPath "UsePlayerSettings"
"cameras/cameraRGB" SET Sensors.RenderCamera format "ARGB32" resolution (1024 768)
CREATE "EnviroSky" AS "EnviroSky"
"EnviroSky" SET EnviroSky Player "cameras" PlayerCamera "cameras/cameraRGB" GameTime.ProgressTime "None" weatherSettings.cloudTransitionSpeed 100 weatherSettings.effectTransitionSpeed 100 weatherSettings.fogTransitionSpeed 100 
"EnviroSky" EXECUTE EnviroSky AssignAndStart "cameras/cameraRGB" "cameras/cameraRGB"
"EnviroSky" SET active true
"cameras/cameraRGB" SET active true
"cameras" SET active true
"cameras/cameraRGB" ADD UnityEngine.PostProcessing.PostProcessingBehaviour
"cameras/cameraRGB" SET UnityEngine.PostProcessing.PostProcessingBehaviour profile "EnviroFX"
"cameras/cameraRGB" SET UnityEngine.PostProcessing.PostProcessingBehaviour profile.motionBlur.enabled false
CREATE "cameras/depth"
"cameras/depth" SET active false
"cameras/depth" ADD Camera Sensors.RenderCamera Cameras.RenderDepthBufferSimple
"cameras/depth" SET Camera near 0.3 far 1000 fieldOfView 60 renderingPath "DeferredShading"
"cameras/depth" SET Sensors.RenderCamera format "RFloat" resolution (1024 768)
"cameras/depth" SET Cameras.RenderDepthBufferSimple outputMode "Linear01Depth" transparencyCutout 0
"cameras/depth" SET active true
"cameras/cameraRGB" ADD LCP
"cameras/cameraRGB" SET LCP enabled false redParam1 0.1 redParam2 0.1 redParam3 -1 enabled true
CREATE "cameras/segmentation"
"cameras/segmentation" SET active false
"cameras/segmentation" ADD Camera SegmentationCamera Segmentation.Output.ClassColors Sensors.RenderCamera
"cameras/segmentation" SET SegmentationCamera transparencyCutout 0
"cameras/segmentation" SET Camera near 0.3 far 1000 fieldOfView 60 renderingPath "UsePlayerSettings" targetTexture.filterMode "Point" 
"cameras/segmentation" SET Sensors.RenderCamera format "ARGB32" resolution (1024 768)
"cameras/segmentation" SET Segmentation.BoundingBoxes minimumObjectVisibility 0 boundingBoxesExtensionAmount 0 minimumPixelsCount 1 
"cameras/segmentation" ADD Segmentation.Output.FilteredBoundingBoxes
"cameras/segmentation" EXECUTE Segmentation.Output.FilteredBoundingBoxes EnableClasses "drone0" "drone1" "drone2"
"cameras/segmentation" EXECUTE Segmentation.Output.ClassColors lookUpTable.SetClassColor "drone0->red" "drone1->blue" "drone2->green"
"cameras/segmentation" SET active true
CREATE "cameras/thermal"
"cameras/thermal" SET active false
"cameras/thermal" ADD Camera Thermal.ThermalCamera UnityEngine.PostProcessing.PostProcessingBehaviour Sensors.RenderCamera CameraFilterPack_Pixelisation_DeepOilPaintHQ CameraFilterPack_Blur_Noise Thermal.GlobalTreeSettings
"cameras/thermal" SET Camera near 0.3 far 1000 fieldOfView 60
"cameras/thermal" SET Sensors.RenderCamera format "ARGB32" resolution (1024 768)
"cameras/thermal" SET Camera renderingPath "UsePlayerSettings"
"cameras/thermal" SET Thermal.ThermalCamera enabled false
"cameras/thermal" SET CameraFilterPack_Pixelisation_DeepOilPaintHQ enabled false
"cameras/thermal" SET CameraFilterPack_Pixelisation_DeepOilPaintHQ _FixDistance 10.6 _Distance 0.06 _Size 0.481 Intensity 0.6 enabled true
"cameras/thermal" SET CameraFilterPack_Blur_Noise Distance (2 1) enabled true
"cameras/thermal" SET Thermal.GlobalTreeSettings temperature 8 temperatureBandwidth 50 temperatureMedian 0 treeLeafsHeatVariance 10 enabled true 
"cameras/thermal" SET UnityEngine.PostProcessing.PostProcessingBehaviour profile "Thermal"
"cameras/thermal" SET Thermal.ThermalCamera ambientTemperature 15 temperatureRange (9 35) maxDistanceForProbeUpdate 100 useAGC true enabled true 
"cameras/thermal" SET UnityEngine.PostProcessing.PostProcessingBehaviour profile.grain.enabled false
"cameras/thermal" SET active true
CREATE "disk1"
"disk1" SET active false
"disk1" ADD Sensors.Disk
"disk1" SET Sensors.Disk path "/tmp/"
"disk1" SET active true
"disk1" SET active false
CREATE "disk1/Cameras/camerargb"
"disk1/Cameras/camerargb" ADD Sensors.RenderCameraLink
"disk1/Cameras/camerargb" SET Sensors.RenderCameraLink target "cameras/cameraRGB"
"disk1/Cameras/camerargb" SET active true
CREATE "disk1/Cameras/segmentation"
"disk1/Cameras/segmentation" ADD Sensors.RenderCameraLink
"disk1/Cameras/segmentation" SET Sensors.RenderCameraLink target "cameras/segmentation"
"disk1/Cameras/segmentation" SET active true
CREATE "disk1/Cameras/depth"
"disk1/Cameras/depth" ADD Sensors.RenderCameraLink
"disk1/Cameras/depth" SET Sensors.RenderCameraLink target "cameras/depth"
"disk1/Cameras/depth" SET Sensors.RenderCameraLink outputType "DEPTH"
"disk1/Cameras/depth" SET active true
CREATE "disk1/Cameras/thermal"
"disk1/Cameras/thermal" ADD Sensors.RenderCameraLink
"disk1/Cameras/thermal" SET Sensors.RenderCameraLink target "cameras/thermal"
"disk1/Cameras/thermal" SET active true
"disk1" SET active true
CREATE "spawner/city/ground/container"
"spawner/city/ground/container" SET active false
"spawner/city/ground/container" ADD RandomProps.Torus
"spawner/city/ground/container" ADD RandomProps.PropArea
"spawner/city/ground" ADD Thermal.ThermalObjectBehaviour
"spawner/city/ground" SET Thermal.ThermalObjectBehaviour profile "DefaultThermalProfile"
"spawner/city/ground/container" ADD Thermal.ThermalObjectOverride
"RandomProps.Random.instance" SET seed 666
"spawner/city/ground/container" SET RandomProps.PropArea tags "ground"
"spawner/city/ground/container" SET RandomProps.PropArea async false numberOfProps 300 collisionCheck false stickToGround false 
"spawner/city/ground/container" SET RandomProps.Torus innerRadius 0
"spawner/city/ground/container" SET RandomProps.Torus radius 150
"spawner/city/ground/container" SET Transform position (0 0 0) eulerAngles (0 0 0) localScale (3 3 3)
"spawner/city/ground/container" SET active true
"spawner/city/ground" SET active true
CREATE "spawner/humans_0/container"
"spawner/humans_0/container" SET active false
"spawner/humans_0/container" ADD RandomProps.Torus
"spawner/humans_0/container" ADD RandomProps.PropArea
"spawner/humans_0" ADD Thermal.ThermalObjectBehaviour
"spawner/humans_0" SET Thermal.ThermalObjectBehaviour profile "DefaultThermalProfile"
"spawner/humans_0/container" ADD Thermal.ThermalObjectOverride
"RandomProps.Random.instance" SET seed 666
"spawner/humans_0/container" SET RandomProps.PropArea tags "human, +random"
"spawner/humans_0/container" SET RandomProps.PropArea async false numberOfProps 40 collisionCheck false stickToGround false 
"spawner/humans_0/container" SET RandomProps.Torus innerRadius 2
"spawner/humans_0/container" SET RandomProps.Torus radius 30
"spawner/humans_0/container" SET Transform position (0 0 0) eulerAngles (0 0 0) localScale (1 1 1)
"spawner/humans_0/container" SET active true
"spawner/humans_0" SET active true
CREATE "spawner/city/nature/trees/container"
"spawner/city/nature/trees/container" SET active false
"spawner/city/nature/trees/container" ADD RandomProps.Torus
"spawner/city/nature/trees/container" ADD RandomProps.PropArea
"spawner/city/nature/trees" ADD Thermal.ThermalObjectBehaviour
"spawner/city/nature/trees" SET Thermal.ThermalObjectBehaviour profile "DefaultThermalProfile"
"spawner/city/nature/trees/container" ADD Thermal.ThermalObjectOverride
"RandomProps.Random.instance" SET seed 666
"spawner/city/nature/trees/container" SET RandomProps.PropArea tags "tree"
"spawner/city/nature/trees/container" SET RandomProps.PropArea async false numberOfProps 574 collisionCheck false stickToGround false 
"spawner/city/nature/trees/container" SET RandomProps.Torus innerRadius 30
"spawner/city/nature/trees/container" SET RandomProps.Torus radius 50
"spawner/city/nature/trees/container" SET Transform position (0 0 0) eulerAngles (0 0 0) localScale (1 1 1)
"spawner/city/nature/trees/container" SET active true
"spawner/city/nature/trees" SET active true
CREATE "spawner/city/buildings/container"
"spawner/city/buildings/container" SET active false
"spawner/city/buildings/container" ADD RandomProps.Torus
"spawner/city/buildings/container" ADD RandomProps.PropArea
"spawner/city/buildings" ADD Thermal.ThermalObjectBehaviour
"spawner/city/buildings" SET Thermal.ThermalObjectBehaviour profile "DefaultThermalProfile"
"spawner/city/buildings/container" ADD Thermal.ThermalObjectOverride
"RandomProps.Random.instance" SET seed 666
"spawner/city/buildings/container" SET RandomProps.PropArea tags "building"
"spawner/city/buildings/container" SET RandomProps.PropArea async false numberOfProps 65 collisionCheck false stickToGround false 
"spawner/city/buildings/container" SET RandomProps.Torus innerRadius 300
"spawner/city/buildings/container" SET RandomProps.Torus radius 400
"spawner/city/buildings/container" SET Transform position (0 0 0) eulerAngles (0 0 0) localScale (1 1 1)
"spawner/city/buildings/container" SET active true
"spawner/city/buildings" SET active true
CREATE "spawner/animals/generic/container"
"spawner/animals/generic/container" SET active false
"spawner/animals/generic/container" ADD RandomProps.Torus
"spawner/animals/generic/container" ADD RandomProps.PropArea
"RandomProps.Random.instance" SET seed 666
"spawner/animals/generic/container" SET RandomProps.PropArea tags "animal"
"spawner/animals/generic/container" SET RandomProps.PropArea async false numberOfProps 35 collisionCheck false stickToGround false 
"spawner/animals/generic/container" SET RandomProps.Torus innerRadius 5
"spawner/animals/generic/container" SET RandomProps.Torus radius 50
"spawner/animals/generic/container" SET Transform position (0 0 0) eulerAngles (0 0 0) localScale (1 1 1)
"spawner/animals/generic/container" SET active true
"spawner/animals/generic" SET active true
CREATE "spawner/animals/birds/container"
"spawner/animals/birds/container" SET active false
"spawner/animals/birds/container" ADD RandomProps.Torus
"spawner/animals/birds/container" ADD RandomProps.PropArea
"spawner/animals/birds" ADD Thermal.ThermalObjectBehaviour
"spawner/animals/birds" SET Thermal.ThermalObjectBehaviour profile "DefaultThermalProfile"
"spawner/animals/birds/container" ADD Thermal.ThermalObjectOverride
"RandomProps.Random.instance" SET seed 666
"spawner/animals/birds/container" SET RandomProps.PropArea tags "bird"
"spawner/animals/birds/container" SET RandomProps.PropArea async false numberOfProps 97 collisionCheck true stickToGround false 
"spawner/animals/birds/container" SET RandomProps.Torus innerRadius 0
"spawner/animals/birds/container" SET RandomProps.Torus radius 120
"spawner/animals/birds/container" SET Transform position (0 54 0) eulerAngles (0 0 0) localScale (1 1 1)
"spawner/animals/birds/container" SET active true
"spawner/animals/birds" SET active true
CREATE "spawner/cars/container"
"spawner/cars/container" SET active false
"spawner/cars/container" ADD RandomProps.Torus
"spawner/cars/container" ADD RandomProps.PropArea
"spawner/cars" ADD Thermal.ThermalObjectBehaviour
"spawner/cars" SET Thermal.ThermalObjectBehaviour profile "DefaultThermalProfile"
"RandomProps.Random.instance" SET seed 666
"spawner/cars/container" SET RandomProps.PropArea tags "car, +thermal"
"spawner/cars/container" SET RandomProps.PropArea async false numberOfProps 75 collisionCheck false stickToGround false 
"spawner/cars/container" SET RandomProps.Torus innerRadius 5
"spawner/cars/container" SET RandomProps.Torus radius 50
"spawner/cars/container" SET Transform position (0 0 0) eulerAngles (0 0 0) localScale (1 1 1)
"spawner/cars/container" ADD RandomProps.SpawnerRandomizers.RandomColor
"spawner/cars/container" SET RandomProps.SpawnerRandomizers.RandomColor randomMethod "FromList"
"spawner/cars/container" PUSH RandomProps.SpawnerRandomizers.RandomColor availableColors "#D6EEA5FF" "#7D8665FF" "#5E3C42FF" "#E2CA02FF" "#983231FF" "#5B6E36FF" "#0E2C02FF" "#B497F8FF" "#0D3FB6FF" "#A54DFAFF" "#DD2144FF" "#2C8AD0FF" "#4D696BFF" "#78636FFF" "#9EF72BFF" "#C670BCFF"
"spawner/cars/container" PUSH RandomProps.SpawnerRandomizers.RandomColor colorsWeights 14
"spawner/cars/container" SET active true
"spawner/cars" SET active true
CREATE "spawner/roadsigns/container"
"spawner/roadsigns/container" SET active false
"spawner/roadsigns/container" ADD RandomProps.Torus
"spawner/roadsigns/container" ADD RandomProps.PropArea
"spawner/roadsigns" ADD Thermal.ThermalObjectBehaviour
"spawner/roadsigns" SET Thermal.ThermalObjectBehaviour profile "DefaultThermalProfile"
"spawner/roadsigns/container" ADD Thermal.ThermalObjectOverride
"RandomProps.Random.instance" SET seed 666
"spawner/roadsigns/container" SET RandomProps.PropArea tags "roadsign"
"spawner/roadsigns/container" SET RandomProps.PropArea async false numberOfProps 250 collisionCheck false stickToGround false 
"spawner/roadsigns/container" SET RandomProps.Torus innerRadius 15
"spawner/roadsigns/container" SET RandomProps.Torus radius 80
"spawner/roadsigns/container" SET Transform position (0 0 0) eulerAngles (0 0 0) localScale (1 1 1)
"spawner/roadsigns/container" SET active true
"spawner/roadsigns" SET active true
CREATE "Drones/DJI_Phantom_4_Pro/DJI_Phantom_4_Pron" FROM "drones" AS "drone/drone0/drone0"
"drone/drone0" ADD Segmentation.ClassGroup
"drone/drone0" SET active false
"drone/drone0" ADD Thermal.ThermalObjectBehaviour
"drone/drone0" SET Thermal.ThermalObjectBehaviour profile "DefaultThermalProfile"
"drone/drone0/drone0/bottom" ADD Thermal.ThermalObjectOverride
"drone/drone0/drone0/motors" ADD Thermal.ThermalObjectOverride
"drone/drone0/drone0" ADD Thermal.ThermalObjectOverride
"drone/drone0" SET Segmentation.ClassGroup itemsClassName "drone0"
"drone/drone0/drone0" SET Transform position (0 1 0)
CREATE "Drones/DJI Spreading Wings S1000 Professional Octocopter/Spreading_Wings_S1000" FROM "drones" AS "drone/drone1/drone1"
"drone/drone1" ADD Segmentation.ClassGroup
"drone/drone1" SET active false
"drone/drone1" ADD Thermal.ThermalObjectBehaviour
"drone/drone1" SET Thermal.ThermalObjectBehaviour profile "DefaultThermalProfile"
"drone/drone1/drone1/Motor_01" ADD Thermal.ThermalObjectOverride
"drone/drone1/drone1/Motor_02" ADD Thermal.ThermalObjectOverride
"drone/drone1/drone1/Motor_03" ADD Thermal.ThermalObjectOverride
"drone/drone1/drone1/Motor_04" ADD Thermal.ThermalObjectOverride
"drone/drone1/drone1/Motor_05" ADD Thermal.ThermalObjectOverride
"drone/drone1/drone1/Motor_06" ADD Thermal.ThermalObjectOverride
"drone/drone1/drone1/Motor_07" ADD Thermal.ThermalObjectOverride
"drone/drone1/drone1/Motor_08" ADD Thermal.ThermalObjectOverride
"drone/drone1/drone1" ADD Thermal.ThermalObjectOverride
"drone/drone1" SET Segmentation.ClassGroup itemsClassName "drone1"
"drone/drone1/drone1" SET Transform position (0 2 0)
CREATE "Drones/Parrot Disco Drone/Parrot_Disco" FROM "drones" AS "drone/drone2/drone2"
"drone/drone2" ADD Segmentation.ClassGroup
"drone/drone2" SET active false
"drone/drone2/drone2" ADD Thermal.ThermalObjectBehaviour
"drone/drone2/drone2" SET Thermal.ThermalObjectBehaviour profile "DefaultThermalProfile"
"drone/drone2/drone2/Engine" ADD Thermal.ThermalObjectOverride
"drone/drone2/drone2/Engine_Element" ADD Thermal.ThermalObjectOverride
"drone/drone2/drone2" ADD Thermal.ThermalObjectOverride
"drone/drone2" SET Segmentation.ClassGroup itemsClassName "drone2"
"drone/drone2/drone2" SET Transform position (0 3 0)
"drone/drone0/drone0" ADD RandomProps.RandomColor
"drone/drone0/drone0" SET RandomProps.RandomColor randomMethod "FromList"
"drone/drone0/drone0" PUSH RandomProps.RandomColor availableColors "#A6403DFF" "#705426FF" "#66D5D0FF" "#5AE3F9FF" "#5B019EFF" "#9259D9FF" "#9032E8FF" "#42CC81FF" "#49E872FF" "#AB9F26FF" "#5DF1E7FF" "#990894FF" "#CDE6A6FF" "#4D4145FF" "#76A942FF" "#DD3F61FF"
"drone/drone0/drone0" PUSH RandomProps.RandomColor colorsWeights 14
"drone/drone1/drone1" ADD RandomProps.RandomColor
"drone/drone1/drone1" SET RandomProps.RandomColor randomMethod "FromList"
"drone/drone1/drone1" PUSH RandomProps.RandomColor availableColors "#3E9157FF" "#6168B4FF" "#3475D5FF" "#49BD43FF" "#144BB4FF" "#C4676EFF" "#E53626FF" "#811E99FF" "#94296FFF" "#EA3C7CFF" "#B4544DFF" "#9D9711FF" "#D84D9EFF" "#1E9F17FF" "#30ED28FF" "#17BB6AFF"
"drone/drone1/drone1" PUSH RandomProps.RandomColor colorsWeights 14
"drone/drone2/drone2" ADD RandomProps.RandomColor
"drone/drone2/drone2" SET RandomProps.RandomColor randomMethod "FromList"
"drone/drone2/drone2" PUSH RandomProps.RandomColor availableColors "#11774BFF" "#614580FF" "#8126DEFF" "#25E001FF" "#551867FF" "#E2A79DFF" "#89F0B5FF" "#4ACC80FF" "#AA384FFF" "#E0B4E1FF" "#EE4515FF" "#EA928FFF" "#410CF5FF" "#3477C5FF" "#4AA6B4FF" "#8D0B2CFF"
"drone/drone2/drone2" PUSH RandomProps.RandomColor colorsWeights 14
"drone/drone0" SET active true
"drone/drone0/drone0" SET active true
"drone/drone1" SET active true
"drone/drone1/drone1" SET active true
"drone/drone2" SET active true
"drone/drone2/drone2" SET active true
