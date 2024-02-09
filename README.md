# Save and read file

Save and read file using Pigeon package provided by Google dev community. 
Step 1: Create "pigeons" at root app of project and in "pigeons" create file_message.dart file
Step 2: In file_message.dart define ConfigurePigeon, models and interface
Step 3: run "flutter pub run pigeon --input pigeons/file_message.dart"
Step 4: After native code is generated, first open ios folder in xCode and create under "Runner" new file that is going to extends generated class by Pigeon, in my case it is DeviceFileApiImpl and implement saveFile and readFile.
On Android side open android with Android Studio if you have it, create file with folders like I did: android/app/src/main/kotlin/plugin/handler/DeviceFileApiImpl.kt and implement readFile and saveFile.
Note that parallel with this steps make sure that Flutter follow native side, after you finish everything you run application and enjoy the view :).

<img hight="400" width="200" src=https://github.com/pervanluka/save_and_read_file/assets/57439344/8a719e2a-aa67-4756-b06f-04ebc43af817> 
<img hight="400" width="200" src=https://github.com/pervanluka/save_and_read_file/assets/57439344/a0480069-61c9-4aaf-9869-d978d9859613>
<img hight="400" width="200" src=https://github.com/pervanluka/save_and_read_file/assets/57439344/72bb9e93-44a5-4f82-a267-75a87dcc0ffe>
<img hight="400" width="200" src=https://github.com/pervanluka/save_and_read_file/assets/57439344/7efd53c4-1daf-489e-82aa-80fb7e23757e>
<img hight="400" width="200" src=https://github.com/pervanluka/save_and_read_file/assets/57439344/f6d1015f-0b7c-4fc9-ac76-97e6841c1d56>
