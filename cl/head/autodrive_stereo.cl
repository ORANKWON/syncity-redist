CREATE "autodrive/autodrive_tile" FROM "autodrive" AS "autodrive"
CREATE "autodrive/SyncityJPickup" FROM "autodrive" AS "SyncityJPickup"
"autodrive" ADD WindZone
"autodrive" SET WindZone mode "Directional" radius 0 windMain 1 windTurbulence 1 windPulseMagnitude 0.5 windPulseFrequency 0.01 
CREATE "SyncityJPickup/rgb1"
"SyncityJPickup/rgb1" SET active false
"SyncityJPickup/rgb1" ADD Camera
"SyncityJPickup/rgb1" SET Camera near 0.3 far 1000 fieldOfView 60 renderingPath "UsePlayerSettings"
CREATE "EnviroSky" AS "EnviroSky"
"EnviroSky" SET EnviroSky Player "SyncityJPickup" PlayerCamera "SyncityJPickup/rgb1" GameTime.ProgressTime "None" weatherSettings.cloudTransitionSpeed 100 weatherSettings.effectTransitionSpeed 100 weatherSettings.fogTransitionSpeed 100 
"EnviroSky" EXECUTE EnviroSky AssignAndStart "SyncityJPickup/rgb1" "SyncityJPickup/rgb1"
"EnviroSky" SET active true
[UI.Window] ShowFromCamera "SyncityJPickup/rgb1" AS "rgb1" WITH 1024 768 24 "ARGB32" "Default"
"SyncityJPickup/rgb1" SET active true
"SyncityJPickup" SET active true
"SyncityJPickup/rgb1" ADD UnityEngine.PostProcessing.PostProcessingBehaviour
"SyncityJPickup/rgb1" SET UnityEngine.PostProcessing.PostProcessingBehaviour profile "EnviroFX"
"SyncityJPickup/rgb1" SET UnityEngine.PostProcessing.PostProcessingBehaviour profile.motionBlur.enabled false
CREATE "SyncityJPickup/rgb2"
"SyncityJPickup/rgb2" SET active false
"SyncityJPickup/rgb2" ADD Camera
"SyncityJPickup/rgb2" SET Camera near 0.3 far 1000 fieldOfView 60 renderingPath "UsePlayerSettings"
CREATE "EnviroSky" AS "EnviroSky"
"EnviroSky" SET EnviroSky Player "SyncityJPickup" PlayerCamera "SyncityJPickup/rgb2" GameTime.ProgressTime "None" weatherSettings.cloudTransitionSpeed 100 weatherSettings.effectTransitionSpeed 100 weatherSettings.fogTransitionSpeed 100 
"EnviroSky" EXECUTE EnviroSky AssignAndStart "SyncityJPickup/rgb2" "SyncityJPickup/rgb2"
"EnviroSky" SET active true
[UI.Window] ShowFromCamera "SyncityJPickup/rgb2" AS "rgb2" WITH 1024 768 24 "ARGB32" "Default"
"SyncityJPickup/rgb2" SET active true
"SyncityJPickup" SET active true
"SyncityJPickup/rgb2" ADD UnityEngine.PostProcessing.PostProcessingBehaviour
"SyncityJPickup/rgb2" SET UnityEngine.PostProcessing.PostProcessingBehaviour profile "EnviroFX"
"SyncityJPickup/rgb2" SET UnityEngine.PostProcessing.PostProcessingBehaviour profile.motionBlur.enabled false
CREATE "SyncityJPickup/bumper"
"SyncityJPickup/bumper" SET active false
"SyncityJPickup/bumper" ADD Camera
"SyncityJPickup/bumper" SET Camera near 0.3 far 1000 fieldOfView 60 renderingPath "UsePlayerSettings"
CREATE "EnviroSky" AS "EnviroSky"
"EnviroSky" SET EnviroSky Player "SyncityJPickup" PlayerCamera "SyncityJPickup/bumper" GameTime.ProgressTime "None" weatherSettings.cloudTransitionSpeed 100 weatherSettings.effectTransitionSpeed 100 weatherSettings.fogTransitionSpeed 100 
"EnviroSky" EXECUTE EnviroSky AssignAndStart "SyncityJPickup/bumper" "SyncityJPickup/bumper"
"EnviroSky" SET active true
[UI.Window] ShowFromCamera "SyncityJPickup/bumper" AS "bumper" WITH 1024 768 24 "ARGB32" "Default"
"SyncityJPickup/bumper" SET active true
"SyncityJPickup" SET active true
"SyncityJPickup/bumper" ADD UnityEngine.PostProcessing.PostProcessingBehaviour
"SyncityJPickup/bumper" SET UnityEngine.PostProcessing.PostProcessingBehaviour profile "EnviroFX"
"SyncityJPickup/bumper" SET UnityEngine.PostProcessing.PostProcessingBehaviour profile.motionBlur.enabled false
CREATE "SyncityJPickup/depth1"
"SyncityJPickup/depth1" SET active false
"SyncityJPickup/depth1" ADD Camera Cameras.RenderDepthBufferSimple
"SyncityJPickup/depth1" SET Camera near 0.3 far 300 fieldOfView 60 renderingPath "DeferredShading"
"SyncityJPickup/depth1" SET Cameras.RenderDepthBufferSimple outputMode "Linear01Depth" transparencyCutout 0
[UI.Window] ShowFromCamera "SyncityJPickup/depth1" AS "depth1" WITH 1024 768 32 "RFloat" "Default"
"SyncityJPickup/depth1" SET active true
CREATE "SyncityJPickup/depth2"
"SyncityJPickup/depth2" SET active false
"SyncityJPickup/depth2" ADD Camera Cameras.RenderDepthBufferSimple
"SyncityJPickup/depth2" SET Camera near 0.3 far 300 fieldOfView 60 renderingPath "DeferredShading"
"SyncityJPickup/depth2" SET Cameras.RenderDepthBufferSimple outputMode "Linear01Depth" transparencyCutout 0
[UI.Window] ShowFromCamera "SyncityJPickup/depth2" AS "depth2" WITH 1024 768 32 "RFloat" "Default"
"SyncityJPickup/depth2" SET active true
CREATE "SyncityJPickup/bumper_depth"
"SyncityJPickup/bumper_depth" SET active false
"SyncityJPickup/bumper_depth" ADD Camera Cameras.RenderDepthBufferSimple
"SyncityJPickup/bumper_depth" SET Camera near 0.3 far 300 fieldOfView 60 renderingPath "DeferredShading"
"SyncityJPickup/bumper_depth" SET Cameras.RenderDepthBufferSimple outputMode "Linear01Depth" transparencyCutout 0
[UI.Window] ShowFromCamera "SyncityJPickup/bumper_depth" AS "bumper_depth" WITH 1024 768 32 "RFloat" "Default"
"SyncityJPickup/bumper_depth" SET active true
CREATE "disk1"
"disk1" SET active false
"disk1" ADD Sensors.Disk
"disk1" SET Sensors.Disk path "/tmp/" counter 1
"disk1" SET active true
"disk1" SET active false
CREATE "disk1/Syncityjpickup/rgb1"
"disk1/Syncityjpickup/rgb1" ADD Sensors.RenderTextureLink
"disk1/Syncityjpickup/rgb1" SET Sensors.RenderTextureLink target "rgb1"
"disk1/Syncityjpickup/rgb1" SET active true
CREATE "disk1/Syncityjpickup/rgb2"
"disk1/Syncityjpickup/rgb2" ADD Sensors.RenderTextureLink
"disk1/Syncityjpickup/rgb2" SET Sensors.RenderTextureLink target "rgb2"
"disk1/Syncityjpickup/rgb2" SET active true
CREATE "disk1/Syncityjpickup/depth1"
"disk1/Syncityjpickup/depth1" ADD Sensors.RenderTextureLink
"disk1/Syncityjpickup/depth1" SET Sensors.RenderTextureLink target "depth1"
"disk1/Syncityjpickup/depth1" SET Sensors.RenderTextureLink outputType "DEPTH"
"disk1/Syncityjpickup/depth1" SET active true
CREATE "disk1/Syncityjpickup/depth2"
"disk1/Syncityjpickup/depth2" ADD Sensors.RenderTextureLink
"disk1/Syncityjpickup/depth2" SET Sensors.RenderTextureLink target "depth2"
"disk1/Syncityjpickup/depth2" SET Sensors.RenderTextureLink outputType "DEPTH"
"disk1/Syncityjpickup/depth2" SET active true
CREATE "disk1/Syncityjpickup/bumper"
"disk1/Syncityjpickup/bumper" ADD Sensors.RenderTextureLink
"disk1/Syncityjpickup/bumper" SET Sensors.RenderTextureLink target "bumper"
"disk1/Syncityjpickup/bumper" SET active true
CREATE "disk1/Syncityjpickup/bumper_depth"
"disk1/Syncityjpickup/bumper_depth" ADD Sensors.RenderTextureLink
"disk1/Syncityjpickup/bumper_depth" SET Sensors.RenderTextureLink target "bumper_depth"
"disk1/Syncityjpickup/bumper_depth" SET Sensors.RenderTextureLink outputType "DEPTH"
"disk1/Syncityjpickup/bumper_depth" SET active true
"disk1" SET active true
"SyncityJPickup" SET Transform position (-100.76 2.25 -415.57)
"SyncityJPickup" SET Transform eulerAngles (0.274 37.499 0)
"SyncityJPickup" SET VPCustomInput enabled false
"autodrive/Road/Autodrive Road" SET UnityEngine.MeshCollider enabled true
"SyncityJPickup/Front" ADD UnityEngine.PostProcessing.PostProcessingBehaviour
"SyncityJPickup/Front" SET UnityEngine.PostProcessing.PostProcessingBehaviour profile EnviroFX
"SyncityJPickup/Front" SET UnityEngine.PostProcessing.PostProcessingBehaviour profile.eyeAdaptation.enabled true
"SyncityJPickup/Front" SET UnityEngine.PostProcessing.PostProcessingBehaviour profile.colorGrading.settings.tonemapping.tonemapper "1"
"autodrive" SET active true
"SyncityJPickup" SET active true
"SyncityJPickup/rgb1" SET Transform localPosition (-0.3 1 -8)
"SyncityJPickup/rgb2" SET Transform localPosition (0.3 1 -8)
"SyncityJPickup/depth1" SET Transform localPosition (-0.3 1 -8)
"SyncityJPickup/depth2" SET Transform localPosition (0.3 1 -8)
"SyncityJPickup/bumper" SET Transform localPosition (0 1 2.2)
"SyncityJPickup/bumper_depth" SET Transform localPosition (0 1 2.2)
"SyncityJPickup/Front" SET Sensors.RenderCamera alwaysOn true
"SyncityJPickup/rgb1" SET Sensors.RenderCamera alwaysOn true
"SyncityJPickup/rgb2" SET Sensors.RenderCamera alwaysOn true
"SyncityJPickup/depth1" SET Sensors.RenderCamera alwaysOn true
"SyncityJPickup/depth2" SET Sensors.RenderCamera alwaysOn true
"SyncityJPickup/bumper" SET Sensors.RenderCamera alwaysOn true
"SyncityJPickup/bumper_depth" SET Sensors.RenderCamera alwaysOn true
"SyncityJPickup/Front" SET Camera enabled true
"SyncityJPickup/rgb1" SET Camera enabled true
"SyncityJPickup/rgb2" SET Camera enabled true
"SyncityJPickup/depth1" SET Camera enabled true
"SyncityJPickup/depth2" SET Camera enabled true
"SyncityJPickup/bumper" SET Camera enabled true
"SyncityJPickup/bumper_depth" SET Camera enabled true
"SyncityJPickup" SET active true
"EnviroSky" EXECUTE EnviroSky ChangeWeather "Cloudy 1"
