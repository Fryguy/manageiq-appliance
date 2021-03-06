#!/bin/bash
# chkconfig: 2345 99 15
# description: evmserverd starts the EVM Server daemon
#

PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local:/usr/local/sbin:/usr/local/bin
BASEDIR="/var/www/miq/vmdb"
RETVAL=0
RUNNER="${BASEDIR}/script/rails runner"
RAKE="${RUNNER} ${BASEDIR}/script/rake"
cd $BASEDIR

# Load default environment and variables
[[ -s "/etc/default/evm" ]] && source "/etc/default/evm"

[[ -x "/var/www/miq/system/initialize_appliance.sh" ]] && /var/www/miq/system/initialize_appliance.sh

start() {
  $RAKE evm:start
  RETVAL=$?
  return $RETVAL
}

stop() {
  $RAKE evm:stop
  RETVAL=$?
  return $RETVAL
}

kill() {
  $RAKE evm:kill
  RETVAL=$?
  return $RETVAL
}

restart() {
  $RAKE evm:restart
  RETVAL=$?
  return $RETVAL
}

status() {
  $RAKE evm:status
  RETVAL=$?
  return $RETVAL
}

update_start() {
  $RAKE evm:update_start >> /var/www/miq/vmdb/log/evm.log 2>&1
  RETVAL=$?
  return $RETVAL
}

update_stop() {
  $RAKE evm:update_stop >> /var/www/miq/vmdb/log/evm.log 2>&1
  RETVAL=$?
  return $RETVAL
}

# See how we were called.
case "$1" in
  start)
  start
  ;;
  stop)
  stop
  ;;
  kill)
  kill
  ;;
  status)
  status
  ;;
  restart)
  restart
  ;;
  update_start)
  update_start
  ;;
  update_stop)
  update_stop
  ;;
  *)
  echo $"Usage: $prog {start|stop|restart|status}"
  exit 1
esac

exit $RETVAL
