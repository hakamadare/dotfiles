#!/bin/bash
#
# toggle Boxen between multiple users
if [[ -d $BOXEN_HOME ]]; then
  # fix ownership
  chown -R $USER $BOXEN_HOME 2>/dev/null

  BOXEN_CONFIG_DEFAULTS="${BOXEN_CONFIG_DIR}/boxen/default.json"

  if [[ -f $BOXEN_CONFIG_DEFAULTS ]]; then
    # fix config
    cat >$BOXEN_CONFIG_DEFAULTS 2>/dev/null <<DEFAULTS
{
  "s3bucket": "boxen-downloads",
  "s3host": "s3.amazonaws.com",
  "repotemplate": "https://github.com/%s",
  "user": "$USER",
  "srcdir": "${HOME}/src",
  "ghurl": "https://github.com",
  "email": "shuff@vecna.org",
  "fde": false,
  "homedir": "/opt/boxen",
  "login": "hakamadare",
  "name": "Steve Huff",
  "puppetdir": "/tmp/boxen/puppet",
  "repodir": "${HOME}/git/our-boxen",
  "reponame": "hakamadare/our-boxen"
}
DEFAULTS
  fi
fi
