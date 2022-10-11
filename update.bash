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
admin=webadmin
user=jpclouduk
pass=`cat /opt/token`
failf=$base/$admin/fail

# Usage
if (( $# >= 1 )) &&  [ $1 != "promote" ]
then 
	echo "Usage: $0 promote   [To push to production]"
       	echo "Usage: $0           [To NOT push to production]"
	exit 0
fi 

# Check command line
if [[ $1 == promote ]]
then
        echo "!!!!!  Deploy to production selected  !!!!!"
else
        echo "!!!!!  No deployment to production has been selected  !!!!!"
fi

# Update local webadmin repo
echo "#### Syncing webadmin repo ####" 
cd $base/$admin
/usr/bin/git fetch origin main
/usr/bin/git merge

# Check for fail file and fail if exists
echo "### Checking for fail flag file ###"
if [ -f "$failf" ];
then
    echo "Fail flag file found. Exiting !!!"
    exit 0
else
    echo "No fail flag file found."
fi

# Update local website repo
echo "#### Updating local repo ####"
cd $base/$site
/usr/bin/git fetch origin main
difg=`/usr/bin/git diff main origin/main --name-only`

if [[ -z $difg ]]
then
	/usr/bin/printf "The remote and local branch are the same.\n !! Exiting !! \n"
	exit 0
else
	/usr/bin/printf "The following files will be merged to local \n $difg \n"
	/usr/bin/git merge
fi

# Build website
echo "#### Building Website ####"
echo `date` > $base/$admin/build.log
cd $base/$site
/usr/bin/npm run build 2>&1 | tee $base/$admin/build.log

# Check for build failures
cd $base/$admin
if /usr/bin/grep -Fq "ERROR" build.log
then
    /usr/bin/printf "####  BUILD FAILED \n####  PLEASE CHECK BUILD LOG \n "
    echo `date` > fail
    echo "####  BUILD FAILED ####" >> fail
    /usr/bin/git add .
    /usr/bin/git commit -m "build failure"
    /usr/bin/git push https://$user:$pass@github.com/jpclouduk/webadmin.git main
    exit 0
else
    /usr/bin/git add .
    /usr/bin/git commit -m "build success"
    /usr/bin/git push https://$user:$pass@github.com/jpclouduk/webadmin.git main
fi


# Check command line
if [[ $1 == promote ]]
then
        bash $base/webadmin/promote.bash
fi
