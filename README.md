## Scripts to update docusauarus and promote to internet facing ##

### rebuild.bash ###
This will pull site code and merge with docusaurus npm.  
1. Update VARS section with required values
2. Add command line parameter "promote" to update live site

### update.bash ###
This will update only local site code.  
1. Update VARS section with required values
2. Add command line parameter "promote" to update live site

### promote.bash ###
This simply pushes site files from .../build directory to the apache document root location.
