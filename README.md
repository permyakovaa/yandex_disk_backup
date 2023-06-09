# Yandex.Disk backup tool 
This script was created to automate daily backups to Yandex.Disk. The script is designed to run on a Raspberry Pi Zero with Raspbian OS, but it can also work on Ubuntu or Debian OS.
To start, you need to configure a connection to Yandex.Disk using the webdav protocol.

Here's a guide on how to configure a connection to Yandex.Disk using the webdav protocol on Raspbian:

1. Open the Terminal on your Raspberry Pi running Raspbian.

2. Install the necessary packages by entering the following command:
```console
sudo apt-get install davfs2
```

3. Once the installation is complete, create a directory where you want to mount the Yandex.Disk by entering the following command:
```console
mkdir ~/yandex-disk
```

4. Edit the davfs2 configuration file by entering the following command:
```console
sudo nano /etc/davfs2/secrets
```

5. Add the Yandex.Disk credentials in the following format:
```console
https://webdav.yandex.ru username password
```
Replace username with your Yandex username and password with your Yandex password.

6. Save and exit the file by pressing Ctrl + X, then Y, and finally Enter.

7. Now, edit the davfs2 configuration file by entering the following command:
```console
sudo nano /etc/davfs2/davfs2.conf
```
Uncomment the use_locks line by removing the # at the beginning of the line. Save and exit the file.


8. To allow non-root users to mount the Yandex.Disk directory, add your user to the davfs2 group by entering the following command:
```console
sudo usermod -aG davfs2 your_username
```
Replace your_username with your actual username.


9. Next, set the proper permissions for the davfs2 configuration file by entering the following command:
```console
sudo chmod 640 /etc/davfs2/secrets
```

10. Finally, mount the Yandex.Disk directory by entering the following command:
```console
sudo mount -t davfs https://webdav.yandex.ru ~/yandex-disk
```

You should now be able to access and use your Yandex.Disk files and folders through the ~/yandex-disk directory.

Remember to replace username and password in step 5 with your actual Yandex.Disk credentials.

1. rsync.sh is called by crontab
2. Script makes rsync with webdav mounted yandex directory
3. Then script calls git_backup.sh
4. Git backup script collects changes, commits them and sends changes to telegram chat

Need to specify TELEGRAM_BOT_SECRET and TELEGRAM_CHAT_ID 
