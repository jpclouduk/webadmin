## Scripts to update docusauarus and promote to internet facing ##

### rebuild.bash ###
This will pull site code and merge with docusaurus npm.  
1. Update VARS section with required values
2. Add command line parameter "promote" to update live site  
    $ bash rebuild.bash promote

### update.bash ###
This will update only local site code.  
1. Update VARS section with required values
2. Add command line parameter "promote" to update live site  
    $ bash update.bash promote

### promote.bash ###
This simply pushes site files from .../build directory to the apache document root location.


### OS Requirement ###
-Install curl and git  
apt install curl git  

-Install Nodejs  
curl -fsSL https://deb.nodesource.com/setup_18.x | bash -  
apt-get install -y nodejs  

### Running Docusaurus ###

| Process | Command |
|---------|---------|
| Create clean env | npx create-docusaurus@latest mysite classic | 
| Start dev server | npm run start -- --host=0.0.0.0 |  
| Build site | npm run build |
| Update docusaurus | npm install |
