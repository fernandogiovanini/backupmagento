#!/bin/bash

# Configuration file
CONFIG_FILE=$(cd "$(dirname "$0")/"; pwd)/config

# Includes config file
if [[ -f "${CONFIG_FILE}" ]]; then
  source "${CONFIG_FILE}"
else
  echo "Configuration file ${CONFIG_FILE} not found!"
fi

# Backup filename
if [ -z "${BACKUP_FILE_PREFIX}" ]; then
  echo "Backup file prefix cannot be empty"
  exit 1
fi;
BACKUP_FILE=${BACKUP_FILE_PREFIX}_$(date +"%Y_%m_%d_%H_%M").tar

# Make backup folder
if [[ ! -d "${BACKUP_DIR}" ]]; then
  echo "${BACKUP_DIR} directory do not exists but will be created..."
  mkdir "${BACKUP_DIR}"
  if [[ ! -d "${BACKUP_DIR}" ]]; then
    echo "Unable do create ${BACKUP_DIR}"
    exit 1
  fi
  echo "${BACKUP_DIR} created"
fi

# System files backup
tar -C "${MAGENTO_DIR}" \
    -cf "${BACKUP_DIR}"/"${BACKUP_FILE}" media

# MySQL backup
mysqldump --login-path=${MYSQL_LOGIN_PATH} ${MYSQL_DATABASE} > ${BACKUP_DIR}/backup_mysql.sql
tar -C "${BACKUP_DIR}" -rf "${BACKUP_DIR}"/"${BACKUP_FILE}" backup_mysql.sql
rm -f "${BACKUP_DIR}"/backup_mysql.sql

# Compress tar file
gzip "${BACKUP_DIR}"/"${BACKUP_FILE}"

# Delete tar file
rm -f "${BACKUP_DIR}"/"${BACKUP_FILE}"
