# Yandex.Disk backup tool 
This script was created to automate daily backups of Yandex.Disk. The script is designed to run on a Raspberry Pi Zero with Raspbian OS, but it can also work on Ubuntu or Debian OS.
Scenario of backup:
1. Mount Yandex.Disk via webdav protocol and sync files automatically.
2. Make a copy of a mounted disk using rsync tool.
3. Use git for storing diffs of documents.
4. Collect list of changes using git.
5. Make git commit of changes.
6. Send notification message with changes list.

## To start, you need to configure a connection to Yandex.Disk using the webdav protocol.
Here's a guide on how to configure a connection:
1. Open the Terminal on your Raspberry Pi running Raspbian.

2. Install the necessary packages by entering the following command:
```bash
sudo apt-get install davfs2
```

3. Once the installation is complete, create a directory where you want to mount the Yandex.Disk by entering the following command:
```bash
mkdir ~/yandex-disk
```

4. Edit the davfs2 configuration file by entering the following command:
```bash
sudo nano /etc/davfs2/secrets
```

5. Add the Yandex.Disk credentials in the following format:
```bash
https://webdav.yandex.ru username password
```
Replace username with your Yandex username and password with your Yandex password. Create Yandex.Disk special password for external app in Yandex account admin.

6. Save and exit the file by pressing Ctrl + X, then Y, and finally Enter.

7. Now, edit the davfs2 configuration file by entering the following command:
```bash
sudo nano /etc/davfs2/davfs2.conf
```
Uncomment the use_locks line by removing the # at the beginning of the line. Save and exit the file.

8. To allow non-root users to mount the Yandex.Disk directory, add your user to the davfs2 group by entering the following command:
```bash
sudo usermod -aG davfs2 your_username
```
Replace your_username with your actual username.

9. Next, set the proper permissions for the davfs2 configuration file by entering the following command:
```bash
sudo chmod 640 /etc/davfs2/secrets
```

10. Finally, mount the Yandex.Disk directory by entering the following command:
```bash
sudo mount -t davfs https://webdav.yandex.ru ~/yandex-disk
```

You should now be able to access and use your Yandex.Disk files and folders through the ~/yandex-disk directory.

Remember to replace username and password in step 5 with your actual Yandex.Disk credentials.

## Next step you need to setup new directory and script parameters:
1. Making a new directory for storing a copy of your files:
```bash
mkdir ~/yadisk
mkdir ~/yadisk/files
```

2. Clonew this repo inside root of your new directory:
```bash
cd ~/yadisk
git clone git@github.com:permyakovaa/yandex_disk_backup.git
```

3. Make variables.sh file:
```bash
cp variables.sh.dist variables.sh
```

4. Specify your unique paramaeters:
```bash
nano variables.sh
```

```bash
YANDEX_DISK_SOURCE_DIR=your_yandex_disk_source_dir
RSYNC_DESTINATION_DIR=your_andex_disk_destination_dir
TELEGRAM_BOT_SECRET=your_telegram_bot_secret
TELEGRAM_CHAT_ID=your_telegram_chat_id
```

### Make a crontab job to run rsync.sh script
1. Open crontab
```bash
crontab -e
```
2. Add a new job for cron that will run every morning at 9 AM:
```bash
00 9 * * * $RSYNC_DIRECTORY_DIR/rsync.sh 2>&1 | /usr/bin/logger -t rsync.sh
```
