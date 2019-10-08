#!/bin/bash
cd /usr/share/grafana
source /etc/sysconfig/grafana-server
/usr/sbin/grafana-server \
--config=${CONF_FILE}                                   \
--packaging=rpm                                         \
cfg:default.paths.data=${DATA_DIR}                      \
cfg:default.paths.plugins=${PLUGINS_DIR}                \
cfg:default.paths.provisioning=${PROVISIONING_CFG_DIR}
