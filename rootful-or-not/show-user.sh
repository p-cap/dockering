#!/bin/bash

echo -e "\nthe current user of the his docker image is:" 
id
echo -e "\nthe owner and group of app-files is:"
ls -alct | grep -i app-files
echo -e "\r"
