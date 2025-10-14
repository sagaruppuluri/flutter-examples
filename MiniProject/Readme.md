# MiniProject

## Refer Prerequisites.md for pre-requisites.

## Setup the DB 

* Install MySQL 
* Open MySQL workbench or any other tool such as DBeaver for connecting to your mysql instance 
* Use the Script.sql under the MiniProject folder to setup the database and tables

## Launching Backend App

* Install NodeJS in your laptop 

* Use the npm install to download the node dependencies for your backend project.

```sh
cd MiniProject\Backend
npm install 
```

* Launch the app using any of the followig options. 

### NOTE: If you need to edit the mysql db host and password you can do that in the env file present in the Backend folder.

```sh
node app.js

# Or Alternatively install nodemon and run the app using nodemon.

npm install -g nodemon
nodemon app.js
```


* Ignore the following, you can use it to setup the new project if needed.

```sh
npm init -y
npm install express mysql2 body-parser bcryptjs jsonwebtoken dotenv
```


## Launching Flutter App

* Open the Entire MiniProject or MiniProject\App folder in VSCode.
* Edit the MiniProject\App\assets\env file to point your machine ip address

```txt
BASE_URL=http://<YourIPAddressHere>:3000/api

Replace the above line with proper ip address eg.

BASE_URL=http://10.10.123.25:3000/api
```

* Ctrl + Shift + P  in VSCode and Flutter: select device and choose Chrome

* Open the main.dart file under App\userapp\lib folder and choose the available run option through VSCode.

