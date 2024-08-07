This app connects github releases with installed apps 

overall idea

github repo url -> get releases -> regex parse releases -> if user has previous app downloaded -> let them connect the app with the repo
                                         |           |
                                         |           |
                                         |           | ---> if user does not have app downloaded store repo url and maintain app info  
|


## Some commands 
puro flutter build apk ;  adb install build\app\outputs\flutter-apk\app-release.apk
