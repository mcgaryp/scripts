# Create a Template node.js Project
`create-node-template.sh` is a script designed to make quick work of setting up a node.js project with one simple command

## Setup
### Required Software
 - global npm

### Unix
1. Save `create-node-template.sh` into a local location of your choosing
2. Open the folder where `create-node-template.sh` in the terminal
3. Enter in the terminal `chmod +x create-node-template.sh` to turn the `.sh` file into an executable
4. Create an alias in your `.bashrc` or `.zshrc` file that is equal to the absolute path of `create-node-template.sh`
5. Use your alias anywhere in the terminal to create your template

### Windows

## Usage
`create-node-template [projectName] <OptionalParameters>`

### Required Parameters
`projectName`: Name of the parent folder and the name of the project. No spaces are allowed.

### Optional Parameters
`--config-git`: Configures a git repository in the project directory
