Magento backup script
=====================

This script create a tar.gz file containing media folder and a database dump.

Edit the config file to configure the script.

To run, add backup_magento.sh to the crontab file, for example, to execute everyday
at 3am:
```shell
0 3 * * * /path/to/script/backup_magento.sh
```
