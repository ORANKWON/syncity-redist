CREATE "cameras"
"cameras" SET active false
"cameras" SET Transform position (-6 1 -50) eulerAngles (0 0 0)
"Canvas/Cameras/Viewport/Content" SET UI.GridLayoutGroup cellSize (1024 768)
"Canvas" SET active true
CREATE "cameras/cameraRGB"
"cameras/cameraRGB" SET active false
"cameras/cameraRGB" ADD Camera Sensors.RenderCamera AudioListener
"cameras/cameraRGB" SET Camera near 0.3 far 1000 fieldOfView 60 renderingPath "UsePlayerSettings"
"cameras/cameraRGB" SET Sensors.RenderCamera format "ARGB32" resolution (2048 1536)
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
"cameras/segmentation" ADD Camera Segmentation.Segmentation Segmentation.LookUpTable Sensors.RenderCamera
"cameras/segmentation" SET Camera near 0.3 far 1000 fieldOfView 60 renderingPath "UsePlayerSettings" targetTexture.filterMode "Point" 
"cameras/segmentation" SET Sensors.RenderCamera format "ARGB32" resolution (1024 768)
"cameras/segmentation" SET Segmentation.Segmentation minimumObjectVisibility 0 outputType "Auto" boundingBoxesExtensionAmount 0 transparencyCutout 0 
"cameras/segmentation" EXECUTE Segmentation.Segmentation DefineClass "Void"
"cameras/segmentation" PUSH Segmentation.Segmentation boundingBoxesFilter "Car"
"cameras/segmentation" EXECUTE Segmentation.Segmentation DefineClass "Car"
"cameras/segmentation" PUSH Segmentation.LookUpTable classes "Void" "Car"
"cameras/segmentation" PUSH Segmentation.LookUpTable colors "black" "blue"
"cameras/segmentation" EXECUTE Segmentation.LookUpTable MarkTextureDirty
"cameras/segmentation" SET active true
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
"disk1" SET active true
"cameras/cameraRGB" EXECUTE Sensors.RenderCamera RenderFrame
"cameras/segmentation" EXECUTE Sensors.RenderCamera RenderFrame
"cameras" SET Orbit target "cars/car_0"
