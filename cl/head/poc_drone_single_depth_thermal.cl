CREATE "cameras"
"cameras" SET active false
"cameras" SET Transform position (-6 1 -50) eulerAngles (0 0 0)
CREATE "cameras/cameraRGB"
"cameras/cameraRGB" SET active false
"cameras/cameraRGB" ADD Camera AudioListener
"cameras/cameraRGB" SET Camera near 0.3 far 1000 fieldOfView 60 renderingPath "UsePlayerSettings"
CREATE "EnviroSky" AS "EnviroSky"
"EnviroSky" SET EnviroSky Player "cameras" PlayerCamera "cameras/cameraRGB" GameTime.ProgressTime "None" weatherSettings.cloudTransitionSpeed 100 weatherSettings.effectTransitionSpeed 100 weatherSettings.fogTransitionSpeed 100 
"EnviroSky" EXECUTE EnviroSky AssignAndStart "cameras/cameraRGB" "cameras/cameraRGB"
"EnviroSky" SET active true
[UI.Window] ShowFromCamera "cameras/cameraRGB" AS "cameraRGB" WITH 1024 768 24 "ARGB32" "Default"
"cameras/cameraRGB" SET active true
"cameras" SET active true
"cameras/cameraRGB" ADD UnityEngine.PostProcessing.PostProcessingBehaviour
"cameras/cameraRGB" SET UnityEngine.PostProcessing.PostProcessingBehaviour profile "EnviroFX"
"cameras/cameraRGB" SET UnityEngine.PostProcessing.PostProcessingBehaviour profile.motionBlur.enabled false
CREATE "cameras/depth"
"cameras/depth" SET active false
"cameras/depth" ADD Camera Cameras.RenderDepthBufferSimple
"cameras/depth" SET Camera near 0.3 far 1000 fieldOfView 60 renderingPath "DeferredShading"
"cameras/depth" SET Cameras.RenderDepthBufferSimple outputMode "Linear01Depth" transparencyCutout 0
[UI.Window] ShowFromCamera "cameras/depth" AS "depth" WITH 1024 768 32 "RFloat" "Default"
"cameras/depth" SET active true
"cameras/cameraRGB" ADD LCP
"cameras/cameraRGB" SET LCP enabled false redParam1 0.1 redParam2 0.1 redParam3 -1 enabled true
"Segmentation.Profile.instance" PUSH classes "Void" "drone0" "drone1" "drone2"
CREATE "cameras/segmentation"
"cameras/segmentation" SET active false
"cameras/segmentation" ADD Camera SegmentationCamera Segmentation.Output.BoundingBoxes Segmentation.Output.ClassColors
"cameras/segmentation" SET SegmentationCamera transparencyCutout 0
"cameras/segmentation" SET Camera near 0.3 far 1000 fieldOfView 60 renderingPath "UsePlayerSettings" targetTexture.filterMode "Point" 
"cameras/segmentation" SET Segmentation.Output.BoundingBoxes minimumObjectVisibility 0 extensionAmount 0 minimumPixelsCount 1 
"cameras/segmentation" EXECUTE Segmentation.Output.ClassColors lookUpTable.SetClassColor "Void->black" "drone0->red" "drone1->blue" "drone2->green"
"cameras/segmentation" ADD Segmentation.Output.FilteredBoundingBoxes
"cameras/segmentation" EXECUTE Segmentation.Output.FilteredBoundingBoxes EnableClasses "drone0" "drone1" "drone2"
[UI.Window] ShowFromCamera "cameras/segmentation" AS "segmentation" WITH 1024 768 24 "ARGB32" "Default"
"cameras/segmentation" SET active true
CREATE "cameras/thermal"
"cameras/thermal" SET active false
"cameras/thermal" ADD Camera Thermal.ThermalCamera UnityEngine.PostProcessing.PostProcessingBehaviour CameraFilterPack_Pixelisation_DeepOilPaintHQ CameraFilterPack_Blur_Noise Thermal.GlobalTreeSettings
"cameras/thermal" SET Camera near 0.3 far 1000 fieldOfView 60
"cameras/thermal" SET Thermal.ThermalCamera enabled false
"cameras/thermal" SET CameraFilterPack_Pixelisation_DeepOilPaintHQ enabled false
"cameras/thermal" SET CameraFilterPack_Pixelisation_DeepOilPaintHQ _FixDistance 10.6 _Distance 0.06 _Size 0.481 Intensity 0.6 enabled true
"cameras/thermal" SET CameraFilterPack_Blur_Noise Distance (2 1) enabled true
"cameras/thermal" SET Thermal.GlobalTreeSettings temperature 8 temperatureBandwidth 50 temperatureMedian 0 treeLeafsHeatVariance 10 enabled true 
"cameras/thermal" SET UnityEngine.PostProcessing.PostProcessingBehaviour profile "Thermal"
"cameras/thermal" SET Thermal.ThermalCamera ambientTemperature 15 temperatureRange (9 35) maxDistanceForProbeUpdate 100 useAGC true enabled true 
"cameras/thermal" SET UnityEngine.PostProcessing.PostProcessingBehaviour profile.grain.enabled false
[UI.Window] ShowFromCamera "cameras/thermal" AS "thermal" WITH 1024 768 24 "ARGB32" "Default"
"cameras/thermal" SET active true
CREATE "disk1"
"disk1" SET active false
"disk1" ADD Sensors.Disk
"disk1" SET Sensors.Disk path "/tmp/" counter 1
"disk1" SET active true
"disk1" SET active false
CREATE "disk1/Cameras/camerargb"
"disk1/Cameras/camerargb" ADD Sensors.RenderTextureLink
"disk1/Cameras/camerargb" SET Sensors.RenderTextureLink target "cameraRGB"
"disk1/Cameras/camerargb" SET active true
CREATE "disk1/Cameras/segmentation"
"disk1/Cameras/segmentation" ADD Sensors.RenderTextureLink
"disk1/Cameras/segmentation" SET Sensors.RenderTextureLink target "segmentation"
"disk1/Cameras/segmentation" SET Sensors.RenderTextureLink outputType "LOSSLESS"
"disk1/Cameras/segmentation" SET active true
CREATE "disk1/Cameras/depth"
"disk1/Cameras/depth" ADD Sensors.RenderTextureLink
"disk1/Cameras/depth" SET Sensors.RenderTextureLink target "depth"
"disk1/Cameras/depth" SET Sensors.RenderTextureLink outputType "DEPTH"
"disk1/Cameras/depth" SET active true
CREATE "disk1/Cameras/thermal"
"disk1/Cameras/thermal" ADD Sensors.RenderTextureLink
"disk1/Cameras/thermal" SET Sensors.RenderTextureLink target "thermal"
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
"spawner/city/ground/container" SET RandomProps.Torus radius 150
"spawner/city/ground/container" SET RandomProps.Torus innerRadius 0
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
"spawner/humans_0/container" SET RandomProps.Torus radius 30
"spawner/humans_0/container" SET RandomProps.Torus innerRadius 2
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
"spawner/city/nature/trees/container" SET RandomProps.PropArea async false numberOfProps 559 collisionCheck false stickToGround false 
"spawner/city/nature/trees/container" SET RandomProps.Torus radius 50
"spawner/city/nature/trees/container" SET RandomProps.Torus innerRadius 30
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
"spawner/city/buildings/container" SET RandomProps.PropArea async false numberOfProps 80 collisionCheck false stickToGround false 
"spawner/city/buildings/container" SET RandomProps.Torus radius 400
"spawner/city/buildings/container" SET RandomProps.Torus innerRadius 300
"spawner/city/buildings/container" SET Transform position (0 0 0) eulerAngles (0 0 0) localScale (1 1 1)
"spawner/city/buildings/container" SET active true
"spawner/city/buildings" SET active true
CREATE "spawner/animals/generic/container"
"spawner/animals/generic/container" SET active false
"spawner/animals/generic/container" ADD RandomProps.Torus
"spawner/animals/generic/container" ADD RandomProps.PropArea
"RandomProps.Random.instance" SET seed 666
"spawner/animals/generic/container" SET RandomProps.PropArea tags "animal"
"spawner/animals/generic/container" SET RandomProps.PropArea async false numberOfProps 40 collisionCheck false stickToGround false 
"spawner/animals/generic/container" SET RandomProps.Torus radius 50
"spawner/animals/generic/container" SET RandomProps.Torus innerRadius 5
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
"spawner/animals/birds/container" SET RandomProps.PropArea async false numberOfProps 47 collisionCheck true stickToGround false 
"spawner/animals/birds/container" SET RandomProps.Torus radius 120
"spawner/animals/birds/container" SET RandomProps.Torus innerRadius 0
"spawner/animals/birds/container" SET Transform position (0 33 0) eulerAngles (0 0 0) localScale (1 1 1)
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
"spawner/cars/container" SET RandomProps.Torus radius 50
"spawner/cars/container" SET RandomProps.Torus innerRadius 5
"spawner/cars/container" SET Transform position (0 0 0) eulerAngles (0 0 0) localScale (1 1 1)
"spawner/cars/container" ADD RandomProps.SpawnerRandomizers.RandomColor
"spawner/cars/container" SET RandomProps.SpawnerRandomizers.RandomColor randomMethod "FromList"
"spawner/cars/container" PUSH RandomProps.SpawnerRandomizers.RandomColor availableColors "#FC4368FF" "#BE3892FF" "#2A3A5EFF" "#8C8475FF" "#9EC7A4FF" "#7C8B6EFF" "#BE3981FF" "#916968FF" "#4789FAFF" "#3F81A3FF" "#DC924DFF" "#B543DCFF" "#476352FF" "#CA6C61FF" "#FB916AFF" "#44FB00FF"
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
"spawner/roadsigns/container" SET RandomProps.Torus radius 80
"spawner/roadsigns/container" SET RandomProps.Torus innerRadius 15
"spawner/roadsigns/container" SET Transform position (0 0 0) eulerAngles (0 0 0) localScale (1 1 1)
"spawner/roadsigns/container" SET active true
"spawner/roadsigns" SET active true
CREATE "Drones/DJI_Phantom_4_Pro/DJI_Phantom_4_Pron" FROM "drones" AS "drone/drone0/drone0"
"drone/drone0" ADD Segmentation.Entity Segmentation.Class
"drone/drone0" SET active false
"drone/drone0" ADD Thermal.ThermalObjectBehaviour
"drone/drone0" SET Thermal.ThermalObjectBehaviour profile "DefaultThermalProfile"
"drone/drone0/drone0/bottom" ADD Thermal.ThermalObjectOverride
"drone/drone0/drone0/motors" ADD Thermal.ThermalObjectOverride
"drone/drone0/drone0" ADD Thermal.ThermalObjectOverride
"drone/drone0" SET Segmentation.Class className "drone0"
"drone/drone0/drone0" SET Transform position (0 1 0)
CREATE "Drones/DJI Spreading Wings S1000 Professional Octocopter/Spreading_Wings_S1000" FROM "drones" AS "drone/drone1/drone1"
"drone/drone1" ADD Segmentation.Entity Segmentation.Class
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
"drone/drone1" SET Segmentation.Class className "drone1"
"drone/drone1/drone1" SET Transform position (0 2 0)
CREATE "Drones/Parrot Disco Drone/Parrot_Disco" FROM "drones" AS "drone/drone2/drone2"
"drone/drone2" ADD Segmentation.Entity Segmentation.Class
"drone/drone2" SET active false
"drone/drone2/drone2" ADD Thermal.ThermalObjectBehaviour
"drone/drone2/drone2" SET Thermal.ThermalObjectBehaviour profile "DefaultThermalProfile"
"drone/drone2/drone2/Engine" ADD Thermal.ThermalObjectOverride
"drone/drone2/drone2/Engine_Element" ADD Thermal.ThermalObjectOverride
"drone/drone2/drone2" ADD Thermal.ThermalObjectOverride
"drone/drone2" SET Segmentation.Class className "drone2"
"drone/drone2/drone2" SET Transform position (0 3 0)
"drone/drone0/drone0" ADD RandomProps.RandomColor
"drone/drone0/drone0" SET RandomProps.RandomColor randomMethod "FromList"
"drone/drone0/drone0" PUSH RandomProps.RandomColor availableColors "#A8E56FFF" "#0540AFFF" "#12BB96FF" "#B562ECFF" "#58B1A9FF" "#26312CFF" "#83CAB1FF" "#7EDFE3FF" "#B62F25FF" "#948EE8FF" "#0724C6FF" "#76FF83FF" "#E46601FF" "#4372F7FF" "#A7A917FF" "#2F0AC7FF"
"drone/drone0/drone0" PUSH RandomProps.RandomColor colorsWeights 14
"drone/drone1/drone1" ADD RandomProps.RandomColor
"drone/drone1/drone1" SET RandomProps.RandomColor randomMethod "FromList"
"drone/drone1/drone1" PUSH RandomProps.RandomColor availableColors "#21A91CFF" "#88494FFF" "#5049BFFF" "#EFDB1FFF" "#A9BCEEFF" "#8E460EFF" "#FB5221FF" "#5630D1FF" "#EFE550FF" "#F28383FF" "#A9C979FF" "#80CB4EFF" "#5C2590FF" "#716DDCFF" "#BB83E3FF" "#696EF5FF"
"drone/drone1/drone1" PUSH RandomProps.RandomColor colorsWeights 14
"drone/drone2/drone2" ADD RandomProps.RandomColor
"drone/drone2/drone2" SET RandomProps.RandomColor randomMethod "FromList"
"drone/drone2/drone2" PUSH RandomProps.RandomColor availableColors "#5AEFDDFF" "#7B21A5FF" "#5FE64DFF" "#C094FDFF" "#B5445EFF" "#26F5B2FF" "#FB0D9EFF" "#6EF3F4FF" "#B0B87FFF" "#E8EE7BFF" "#16F015FF" "#74630AFF" "#FDE743FF" "#52AD4BFF" "#362730FF" "#27D121FF"
"drone/drone2/drone2" PUSH RandomProps.RandomColor colorsWeights 14
"drone/drone0" SET active true
"drone/drone0/drone0" SET active true
"drone/drone1" SET active true
"drone/drone1/drone1" SET active true
"drone/drone2" SET active true
"drone/drone2/drone2" SET active true
