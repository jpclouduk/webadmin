#!/usr/bin/env bash
#
##########################################
# Script:  Update existing local repo    #
# Author:  JP                            #
# Date: 08/10/2022                       #
##########################################


# VARS
base=/opt
site=website
user=jpclouduk
pass=`cat /opt/token`

# Check command line
if [[ $1 == promote ]]
then
        echo "!!!!!  Deploy to production selected  !!!!!"
else
        echo "!!!!!  No deployment to production has been selected  !!!!!"
fi

# Update local repo
echo "#### Updating local repo ####"
cd $base/$site
/usr/bin/git fetch origin main
/usr/bin/git diff --summary FETCH_HEAD
/usr/bin/git merge

# Build website
echo "#### Building Website ####"
cd $base/$site
/usr/bin/npm run build

# Check command line
if [[ $1 == promote ]]
then
        bash $base/webadmin/promote.bash
fi
