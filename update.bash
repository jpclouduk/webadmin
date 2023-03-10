#!/usr/bin/env bash
#
##########################################
# Script:  Update existing local repo    #
# Author:  JP                            #
# Date: 08/10/2022                       #
##########################################


# VARS
base=/opt/pi
site=website
admin=webadmin
user=jpclouduk
pass=`cat ${base}/token`
failf=$base/$admin/fail
lina=`arch`


# Setup architecture options
case $lina in
    x86_64)
        binp=/usr/bin
	;;
    armv7l)
        binp=/bin
	;;
    *)
        printf "Unknown machine type\n Not armv7l or x86_64\n Use uname -m to check type.\n"
	;;
esac


# Usage
if (( $# >= 1 )) &&  [ $1 != "promote" ]
then 
	$binp/echo "Usage: $0 promote   [To push to production]"
       	$binp/echo "Usage: $0           [To NOT push to production]"
	exit 0
fi 

# Check command line
if [[ $1 == promote ]]
then
        $binp/echo "!!!!!  Deploy to production selected  !!!!!"
else
        $binp/echo "!!!!!  No deployment to production has been selected  !!!!!"
fi

# Update git config
/usr/bin/git config --global user.name "jpclouduk"
/usr/bin/git config --global user.email "poulsenjx@gmail.com"

# Update local webadmin repo
$binp/echo "#### Syncing webadmin repo ####" 
cd $base/$admin
/usr/bin/git fetch origin main
/usr/bin/git merge

# Check for fail file and fail if exists
$binp/echo "### Checking for fail flag file ###"
if [ -f "$failf" ];
then
    $binp/echo "Fail flag file found. Exiting !!!"
    exit 0
else
    $binp/echo "No fail flag file found."
fi

# Update local website repo
$binp/echo "#### Updating local repo ####"
cd $base/$site
/usr/bin/git remote set-url origin https://$user:$pass@github.com/jpclouduk/website.git
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
$binp/echo "#### Building Website ####"
$binp/echo `date` > $base/$admin/build.log
cd $base/$site
/usr/bin/npm run build 2>&1 | tee $base/$admin/build.log

# Check for build failures
cd $base/$admin
if $binp/grep -Fq "ERROR" build.log
then
    /usr/bin/printf "####  BUILD FAILED \n####  PLEASE CHECK BUILD LOG \n "
    $binp/echo `date` > fail
    $binp/echo "####  BUILD FAILED ####" >> fail
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
