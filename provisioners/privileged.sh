#!/bin/bash

set -e

DEBIAN_FRONTEND=noninteractive apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install -y \
  augeas-tools \
  firefox \
  icedtea-netx \
  virtualbox-guest-x11 \
  xfce4 \
  xserver-xorg-legacy

VBoxClient --clipboard
VBoxClient --draganddrop
VBoxClient --display
VBoxClient --checkhostversion
VBoxClient --seamless

cp /vagrant/Xwrapper.config /etc/X11/
cp /vagrant/x-session.service /usr/lib/systemd/user/

augtool --noautoload << EOF
  set /augeas/load/Properties/lens Properties.lns
  set /augeas/load/Properties/incl /etc/java-11-openjdk/security/java.security
  load
  rm /files/etc/java-11-openjdk/security/java.security/jdk.certpath.disabledAlgorithms
  rm /files/etc/java-11-openjdk/security/java.security/jdk.jar.disabledAlgorithms
  rm /files/etc/java-11-openjdk/security/java.security/jdk.tls.disabledAlgorithms
  save
  print /augeas/events/saved
  errors
EOF

# For more information about `policies.json` see:
#   https://support.mozilla.org/en-US/kb/customizing-firefox-using-policiesjson
#
# For more information on `SSLVersionMin` see:
#   https://github.com/mozilla/policy-templates/blob/master/docs/index.md#sslversionmin
#
# Setting this policy prevents `security.tls.version.min` from being
#   changed in `about:config`.

mkdir -p /etc/firefox/policies/
cp /vagrant/policies.json /etc/firefox/policies/
