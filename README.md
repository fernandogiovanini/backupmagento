Magento backup script
=====================

This script create a tar.gz file containing media folder and a database dump.

Edit the config file to configure the script.

As I'm usign MySQL 5.6, see http://dev.mysql.com/doc/refman/5.6/en/mysql-config-editor.html to configure a login path and setup `MYSQL_LOGIN_PATH` in the config file. To configure your login path, run:
```shell
mysql_config_editor set --login-path=your_login_path_name \
                        --host=your_host \
                        --user=your_user
                        --password
```

To run, add backup_magento.sh to the crontab file, for example, to execute everyday
at 3am:
```shell
0 3 * * * /path/to/script/backup_magento.sh
```
