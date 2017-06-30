#!/bin/bash
# This should generate a list of domains 1-20 wrapped around a root "word"

## variables
REPONAME=anudeeptest
REPODIR=/home/pi/"$REPONAME"/
REPOOWNER=deathbybandaid
GITREPOSITORYURL="github.com/"REPOOWNER"/"REPONAME".git"
DOCTOSPITOUT="$REPODIR"domainlist.txt
ROOTSUBSLIST="$REPODIR"rootsubs.txt

## whiptail required
WHATITIS=whiptail
WHATPACKAGE=whiptail
if
which $WHATITIS >/dev/null;
then
echo "$WHATITIS Already Installed"
else
echo "Installing $WHATITIS"
apt-get install -y $WHATPACKAGE
fi

## Remove old list
rm $DOCTOSPITOUT
touch $DOCTOSPITOUT

for source in `cat $ROOTSUBSLIST`;
do

for i in {1..20}
do
echo "r"$i"---sn-"$source".googlevideo.com" | tee --append $DOCTOSPITOUT &>/dev/null
echo "r"$i"---sn-"$source".googlevideo.com"

## Done with Loops
done
done
echo "Script complete"

Pushlists?
{ if
(whiptail --title "anudeeptest" --yesno "Do you want to push list to github" 10 80) 
then
GITHUBUSERNAME=$(whiptail --inputbox "Github Username?" 10 80 "" 3>&1 1>&2 2>&3)
GITHUBPASSWORD=$(whiptail --inputbox "Github Password?" 10 80 "" 3>&1 1>&2 2>&3)
GITWHERETOPUSH=https://"$GITHUBUSERNAME":"$GITHUBPASSWORD"@"$GITREPOSITORYURL"
git -C $REPODIR remote set-url origin $GITWHERETOPUSH
git -C $REPODIR add .
git -C $REPODIR commit -m "Update lists $timestamp"
git -C $REPODIR push -u origin master
else
:
fi
