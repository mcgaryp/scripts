#!/bin/bash

# GENERAL FUNCTIONS
function makeFile() {
    echo $2 > $1
}

function makeDir() {
    mkdir $1
}

# FOLDERS
function projectFolder() {
    # Create Folders
    databaseFolder
    publicFolder
    serverFolder

    # Create Files
    # Create .env and populate
    envFile
    # Create .gitignore and populate
    gitIgnoreFile
    # Create bs-config.js and populate
    bsConfigFile
    # Create package.json and populate
    packageFile
}

function databaseFolder() {
    # Create DB folder
    makeDir database
    cd database

    # Create folders
    scriptsFolder
    
    # Create files
    # Create database.js
    databaseFile

    cd ..
}

function scriptsFolder() {
    # Create scripts folder
    makeDir scripts
    cd scripts

    # Create create.sql
    makeFile 'create.sql'
    # Create seed.sql
    makeFile 'seed.sql'

    cd ..
}

function publicFolder() {
    # Create public folder
    makeDir public
    cd public

    # Create index.css
    makeFile 'index.css'
    # Create index.html
    indexHtmlFile
    # Create index.js
    makeFile 'index.js'

    cd ..
}

function serverFolder() {
    # Create server folder
    mkdir server
    cd server

    # Create folders
    controllerFolder

    # Create files
    # Create server.js
    serverFile

    cd ..
}

function controllerFolder() {
    makeDir controllers
    cd controllers

    makeFile 'exampleController.js'

    cd ..
}

# FILES
function databaseFile() {
    makeFile 'database.js' 'const { Client } = require("pg")\n
    const fs = require("fs")\n
    const client = new Client()\n
    \n
    var db = {\n
    \tconnect: () => {\n
    \t\tclient\n
    \t\t\t.connect()\n
    \t\t\t.then(() => console.log(`Connected to DB`))\n
    \t\t\t.catch(err => console.error("connection error", err.stack))\n
    \t},\n
    \tdisconnect: () => {\n
    \t\tclient\n
    \t\t\t.end()\n
    \t\t\t.then(() => console.log("Client has disconnected from DB"))\n
    \t\t\t.end(err => console.error("Error during Cliend Disconnect", err.stack))\n
    \t},\n
    \ttest: () => {\n
    \t\tclient\n
    \t\t\t.query("SELECT NOW()")\n
    \t\t\t.then((response) => console.log(response.rows))\n
    \t\t\t.catch((exception) => console.error(exception))\n
    \t},\n
    \tseed: (req, res) => {\n
    \t\tconst createBuffer = fs.readFileSync(__dirname + "/scripts/create.sql")\n
    \t\tconst create = createBuffer.toString()\n
    \t\tclient\n
    \t\t\t.query(create)\n
    \t\t\t.then(() => console.log("DB Tables Initialized"))\n
    \t\t\t.catch(err => console.error("Error Creating Tables", err.stack))\n
    \n
    \tconst insertBuffer = fs.readFileSync(__dirname + "./scripts/seed.sql")\n
    \tconst insert = insertBuffer.toString()\n
    \t\tclient\n
    \t\t\t.query(insert)\n
    \t\t\t.then(() => {\n
    \t\t\t\tconsole.log("DB Tables Seeded")\n
    \t\t\t\tres.status(200).send("Success")\n
    \t\t\t})\n
    \t\t\t.catch(err => console.error("Error Seeding Tables", err))\n
    \t}\n
    }\n'
}

function indexHtmlFile() {
    makeFile 'index.html' '<!doctype html>\n
    <html lang="en">\n
    \t<head>\n
    \t\t<!-- Required meta tags -->\n
    \t\t<meta charset="utf-8">\n
    \t\t<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">\n
    \n
    \t\t<!-- Bootstrap CSS -->\n
    \t\t<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">\n
    \n
    \t\t<title>Hello, the world!</title>\n
    \t</head>\n
    \t<body>\n
    \t\t<div class="jumbotron">\n
    \t\t\t<div class="container"><h1>Hello World!</h1></div>\n
    \t</div>\n
    \n
    \t\t<!-- Optional JavaScript -->\n
    \t\t<!-- jQuery first, then Popper.js, then Bootstrap JS -->\n
    \t\t<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>\n
    \t\t<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>\n
    \t\t<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>\n
    \t</body>\n
    </html>\n'
}

function serverFile() {
    makeFile 'server.js' 'require("dotenv").config()\n
    \n
    const express = require("express")\n
    const app = express()\n
    const port = process.env.PORT\n
    \n
    // USE\n
    app.use(express.static("public"))\n
    \n
    // POSTS\n
    \n
    \n
    // GETS\n
    // Send `index.html` file to the browser so the viewer can see the page\n
    app.get("/", (req, res) => {\n
        res.sendFile("index.html")\n
    })\n
    \n
    //Server\n
    app.listen(port, (req, res) => {\n
        console.log(`Listening on port ${port}`)\n
    })\n'
}

function envFile() {
    makeFile '.env' '# For PosgresSQL DB\n
        USER=""\n
        PGPASSWORD=""\n
        PGHOST=""\n
        PGDATABASE=""\n
        PGPORT=""\n
        \n
        # General\n
        PORT="4000""
    '
}

function gitIgnoreFile() {
    makeFile '.gitignore' 'node_modules\n.env'
}

function bsConfigFile() {
    makeFile 'bs-config.js' 'module.exports = {\n
    \tbrowser: "google chrome",\n
    \tfiles: ["**/*.css", "**/*.html", "**/*.js"],\n
    \tignore: ["node_modules"],\n
    \tnotify: false,\n
    \tport: 3000,\n
    \tproxy: "localhost:4000",\n
    \treloadDelay: 10,\n
    \tui: false,\n
    }'
}

function packageFile() {
    makeFile 'package.json' '{\n
    \t"name": "",\n
    \t"author": {\n
    \t\t"name": ""\n
    \t},\n
    \t"version": "0.0.1",\n
    \t"scripts": {\n
    \t\t"dev": "nodemon server/server.js",\n
    \t\t"ui": "browser-sync start --config bs-config.js"\n
    \t},\n
    \t"repository": {\n
    \t\t"type": "git",\n
    \t\t"url": "https://github.com/"\n
    \t},\n
    \t"dependencies": {\n
    \t\t"nodemon": "^2.0.20",\n
    \t\t"express": "^4.18.1",\n
    \t\t"pg": "8.8.0",\n
    \t\t"dotenv": "16.0.2",\n
    \t\t"browser-sync": "2.27.10"\n
    \t}\n
    }'
}

function createProject() {
    # Create project folder
    makeDir $1
    cd ./$1

    projectFolder
}

function main() {
    projectName=$1

    if [ -z "$projectName" ]
    then
        echo "Project does not have a name"
        exit
    fi

    # createProject $projectName

    if [ $2 == "--config-git" ]
    then
        # Create git repo
        git init
    fi

    # Run npm install
    npm install
}

main $1 $2