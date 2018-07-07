#!/bin/bash

echo "Install wget"
apt-get install -y wget

echo "Download script of installing ODBC Driver 13"
wget https://gallery.technet.microsoft.com/ODBC-Driver-13-for-Ubuntu-b87369f0/file/154097/2/installodbc.sh
sed -i 's/sudo//g' installodbc.sh

echo "Execute script ..."
sh installodbc.sh

echo "PIP install pyodbc & pymssql"
pip install pyodbc pymssql
