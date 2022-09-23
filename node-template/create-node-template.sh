#!/bin/bash

# GENERAL FUNCTIONS
function makeFile() {
    echo "$2" > $1
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
    # Create README.md
    readmeFile
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
    makeDir modules
    cd modules

    makeFile 'exampleModule.js'

    cd ..
}

# FILES
function databaseFile() {
    makeFile 'database.js' 'const { Client } = require("pg")
const fs = require("fs")
const client = new Client()

var db = {
    connect: () => {
        client
            .connect()
            .then(() => console.log(`Connected to DB`))
            .catch(err => console.error("connection error", err.stack))
    },
    disconnect: () => {
        client
            .end()
            .then(() => console.log("Client has disconnected from DB"))
            .end(err => console.error("Error during Cliend Disconnect", err.stack))
    },
    test: () => {
        client
            .query("SELECT NOW()")
            .then((response) => console.log(response.rows))
            .catch((exception) => console.error(exception))
    },
    seed: (req, res) => {
        const createBuffer = fs.readFileSync(__dirname + "/scripts/create.sql")
        const create = createBuffer.toString()
        client
            .query(create)
            .then(() => console.log("DB Tables Initialized"))
            .catch(err => console.error("Error Creating Tables", err.stack))

    const insertBuffer = fs.readFileSync(__dirname + "./scripts/seed.sql")
    const insert = insertBuffer.toString()
    client
        .query(insert)
        .then(() => {
            console.log("DB Tables Seeded")
            res.status(200).send("Success")
        })
        .catch(err => console.error("Error Seeding Tables", err))
    }
}

module.exports = db'
}

function indexHtmlFile() {
    makeFile 'index.html' '<!doctype html>
<html lang="en">
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">

        <title>Hello, the world!</title>
    </head>
    <body>
        <div class="jumbotron">
            <div class="container"><h1>Hello World!</h1></div>
    </div>

        <!-- Optional JavaScript -->
        <!-- jQuery first, then Popper.js, then Bootstrap JS -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
    </body>
</html>'
}

function serverFile() {
    makeFile 'server.js' 'require("dotenv").config()
const express = require("express")
const app = express()
const port = process.env.PORT
    
// USE
app.use(express.static("public"))
    
// POSTS
    
    
// GETS
// Send `index.html` file to the browser so the viewer can see the page
app.get("/", (req, res) => {
    res.sendFile("index.html")
})
    
// Server
app.listen(port, (req, res) => {
    console.log(`Listening on port ${port}`)
})'
}

function envFile() {
    makeFile '.env' '# For PosgresSQL DB
USER=""
PGPASSWORD=""
PGHOST=""
PGDATABASE=""
PGPORT=""

# General
PORT="4000"
'
}

function gitIgnoreFile() {
    makeFile '.gitignore' 'node_modules
.env'
}

function bsConfigFile() {
    makeFile 'bs-config.js' 'module.exports = {
    browser: "google chrome",
    files: ["**/*.css", "**/*.html", "**/*.js"],
    ignore: ["node_modules"],
    notify: false,
    port: 3000,
    proxy: "localhost:4000",
    reloadDelay: 10,
    ui: false,
}'
}

function packageFile() {
    makeFile 'package.json' '{
    "name": "",
    "author": {
        "name": ""
    },
    "version": "0.0.1",
    "scripts": {
        "dev": "nodemon server/server.js",
        "ui": "browser-sync start --config bs-config.js"
    },
    "repository": {
        "type": "git",
        "url": "https://github.com/"
    },
    "dependencies": {
        "nodemon": "^2.0.20",
        "express": "^4.18.1",
        "pg": "8.8.0",
        "dotenv": "16.0.2",
        "browser-sync": "2.27.10"
    }
}'
}

function readmeFile() {
    makeFile 'README.md' 
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

    createProject $projectName
    # databaseFile

    if [ "$2" == "--config-git" ]
    then
        # Create git repo
        git init
    fi

    # Run npm install
    npm install
}

main $1 $2