CREATE "cameras"
"cameras" SET active false
"cameras" SET Transform position (-6 1 -50)
"cameras" SET Transform eulerAngles (0 0 0)
"cameras" ADD Orbit
"Canvas/Cameras/Viewport/Content" SET UI.GridLayoutGroup cellSize (1024 768)
"Canvas" SET active true
CREATE "cameras/cameraRGB"
"cameras/cameraRGB" SET active false
"cameras/cameraRGB" ADD Camera
"cameras/cameraRGB" SET Camera near 0.3 far 1000 fieldOfView 60
"cameras/cameraRGB" ADD Sensors.RenderCamera
"cameras/cameraRGB" SET Sensors.RenderCamera format "ARGB32" resolution (1024 768)
"cameras/cameraRGB" SET Camera renderingPath "UsePlayerSettings"
"cameras/cameraRGB" ADD AudioListener
CREATE "EnviroSky" AS "EnviroSky"
"EnviroSky" SET EnviroSky Player "cameras" PlayerCamera "cameras/cameraRGB" GameTime.ProgressTime "None" weatherSettings.cloudTransitionSpeed 100 weatherSettings.effectTransitionSpeed 100 weatherSettings.fogTransitionSpeed 100 
"EnviroSky" EXECUTE EnviroSky AssignAndStart "cameras/cameraRGB" "cameras/cameraRGB"
"EnviroSky" SET active true
"cameras/cameraRGB" SET active true
"cameras" SET active true
"cameras/cameraRGB" ADD UnityEngine.PostProcessing.PostProcessingBehaviour
"cameras/cameraRGB" SET UnityEngine.PostProcessing.PostProcessingBehaviour profile "EnviroFX"
"cameras/cameraRGB" SET UnityEngine.PostProcessing.PostProcessingBehaviour profile.motionBlur.enabled false
CREATE "cameras/segmentation"
"cameras/segmentation" SET active false
"cameras/segmentation" ADD Camera
"cameras/segmentation" SET Camera near 0.3 far 1000 fieldOfView 60
"cameras/segmentation" ADD Sensors.RenderCamera
"cameras/segmentation" SET Sensors.RenderCamera format "ARGB32" resolution (1024 768)
"cameras/segmentation" SET Camera renderingPath "UsePlayerSettings" targetTexture.filterMode "Point"
"cameras/segmentation" ADD Segmentation.Segmentation
"cameras/segmentation" SET Segmentation.Segmentation minimumObjectVisibility 0 outputType "Auto" boundingBoxesExtensionAmount 0 transparencyCutout 0 
"cameras/segmentation" EXECUTE Segmentation.Segmentation DefineClass "Void"
"cameras/segmentation" PUSH Segmentation.Segmentation boundingBoxesFilter "Car"
"cameras/segmentation" PUSH Segmentation.Segmentation boundingBoxesFilter "Drone"
"cameras/segmentation" ADD Segmentation.LookUpTable
"cameras/segmentation" PUSH Segmentation.LookUpTable classes "Void"
"cameras/segmentation" PUSH Segmentation.LookUpTable colors "black"
"cameras/segmentation" EXECUTE Segmentation.Segmentation DefineClass "Car"
"cameras/segmentation" PUSH Segmentation.LookUpTable classes "Car"
"cameras/segmentation" PUSH Segmentation.LookUpTable colors "red"
"cameras/segmentation" EXECUTE Segmentation.Segmentation DefineClass "Drone"
"cameras/segmentation" PUSH Segmentation.LookUpTable classes "Drone"
"cameras/segmentation" PUSH Segmentation.LookUpTable colors "blue"
"cameras/segmentation" EXECUTE Segmentation.LookUpTable MarkTextureDirty
"cameras/segmentation" SET active true
CREATE "cameras/depth"
"cameras/depth" SET active false
"cameras/depth" ADD Camera
"cameras/depth" SET Camera near 0.3 far 1000 fieldOfView 60 renderingPath "DeferredShading"
"cameras/depth" ADD Sensors.RenderCamera
"cameras/depth" SET Sensors.RenderCamera format "RFloat" resolution (1024 768)
"cameras/depth" ADD Cameras.RenderDepthBufferSimple
"cameras/depth" SET Cameras.RenderDepthBufferSimple outputMode "Linear01Depth" transparencyCutout 0
"cameras/depth" SET active true
CREATE "cameras/depth"
"cameras/depth" SET active false
"cameras/depth" ADD Camera
"cameras/depth" SET Camera near 0.3 far 1000 fieldOfView 60 renderingPath "DeferredShading"
"cameras/depth" ADD Sensors.RenderCamera
"cameras/depth" SET Sensors.RenderCamera format "RFloat" resolution (1024 768)
"cameras/depth" ADD Cameras.RenderDepthBufferSimple
"cameras/depth" SET Cameras.RenderDepthBufferSimple outputMode "Linear01Depth" transparencyCutout 0
"cameras/depth" SET active true
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
"disk1" SET active true
"disk1/Cameras/depth" SET Sensors.RenderCameraLink outputType "DEPTH"
CREATE "Cars/VW_Golf_V/VW_Golf_V" FROM "cars" AS "obj/subject0"
"obj" SET active false
"obj/subject0" SET Transform position (0 0 0) eulerAngles (0 0 0)
"obj/subject0" ADD Segmentation.ClassInfo
"obj/subject0" SET Segmentation.ClassInfo itemClass "Car"
CREATE "Drones/DJI_Phantom_4_Pro/DJI_Phantom_4_Pron" FROM "drones" AS "obj/subject1"
"obj" SET active false
"obj/subject1" SET Transform position (0 2 0) eulerAngles (0 0 0)
"obj/subject1" ADD Segmentation.ClassInfo
"obj/subject1" SET Segmentation.ClassInfo itemClass "Drone"
"obj" SET Transform position (-6 0 -9) eulerAngles (0 0 0)
"obj" SET active true
"obj/subject0" SET active true
"obj/subject1" SET active true
"cameras/cameraRGB" SET Camera enabled true
"cameras/segmentation" SET Camera enabled true
"cameras" SET Transform position (0 1 -16)
"cameras" SET Transform eulerAngles (0 -40 0)
"EnviroSky" SET EnviroSky cloudsMode "Volume"
"EnviroSky" SET EnviroSky cloudsSettings.globalCloudCoverage -0.04
"EnviroSky" EXECUTE EnviroSky ChangeWeather "Cloudy 1"
