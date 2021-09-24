#!/bin/bash

LIST=()

for username in $(dscl . list /Users UniqueID | awk '$2 > 500 { print $1 }'); do
    
    ONEDRIVE_BUSINESS_ACCOUNT_NAMESPACE=($(find /Users/"$username"/Library/Application\ Support/OneDrive/settings -type directory -mindepth 1 -name "Business*" -print0 | xargs -0 -I{} find {} -type f -name "ClientPolicy*" -print0 | xargs -0 -I{} grep DavUrlNamespace {} | awk '{print $3}'))
    ONEDRIVE_BUSINESS_ACCOUNT_LAST_SYNCED=($(find /Users/"$username"/Library/Application\ Support/OneDrive/settings -type directory -mindepth 1 -name "Business*" -print0 | xargs -0 -I{} find {} -type f -name "ClientPolicy*" -print0 | xargs -0 -I{} grep LastRefresh {} | awk '{print $3}'))
    
    if [[ -n $ONEDRIVE_BUSINESS_ACCOUNT_NAMESPACE ]]; then
        
        LIST+=("Configured OneDrive Accounts for $username:")
        for ((i = 0; i < ${#ONEDRIVE_BUSINESS_ACCOUNT_NAMESPACE[@]}; i++)); do
            
            LIST+=("${ONEDRIVE_BUSINESS_ACCOUNT_NAMESPACE[$i]} last synced at $(date -r ${ONEDRIVE_BUSINESS_ACCOUNT_LAST_SYNCED[$i]} +"%Y-%m-%d %H:%M:%S")")
            
        done
        
    else
        
        LIST+=("No OneDrive Account Configured")
        
    fi
    
done

for ((i = 0; i < ${#LIST[@]}; i++)); do
    
    if [[ $i = 0 ]]; then
        
        echo "<result>${LIST[$i]}"
        
    else
        
        echo "${LIST[$i]}"
        
    fi
    
done

echo "</result>"