rm -r /home/server/backup/*
mkdir /home/server/backup/database
sudo  mysqldump -u DBUSERNAME -pDBPASSWORD DBNAME > /home/server/backup/database/server_db_$(date +"%Y_%m_%d_%I_%M_%p").sql

HOST='FTPip'
USER='FTPusername'
PASS='FTPpassword'
TARGETFOLDER='/Backups/Server/Database/'
SOURCEFOLDER='/home/server/backup/database/'

lftp -f "
open $HOST
user $USER $PASS
lcd $SOURCEFOLDER
mirror --reverse  --verbose $SOURCEFOLDER $TARGETFOLDER
bye
"
curl -X POST -H 'Content-Type: application/json' --data '{"text":"Message Title","attachments":[{"title":"Server Notification","text":"Backup successfully finish.","color":"#764FA5"}]}' https://RocketChatAdress.com/hooks/rocketchatToken


