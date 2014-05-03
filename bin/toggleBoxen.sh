#!/bin/bash
#
# toggle Boxen between multiple users
source /opt/boxen/env.sh

# who is the real user?
if [[ -z $REAL_USER ]]; then
  exit 1
elif [[ -d $BOXEN_HOME ]]; then
  # fix ownership
  chown -R $REAL_USER $BOXEN_HOME 2>/dev/null
  chown -R $REAL_USER /Library/Caches/Homebrew 2>/dev/null

  BOXEN_CONFIG_DEFAULTS="${BOXEN_CONFIG_DIR}/boxen/defaults.json"
  if [[ -w $BOXEN_CONFIG_DEFAULTS ]]; then
    # fix config
    cat >$BOXEN_CONFIG_DEFAULTS 2>/dev/null <<DEFAULTS
{
  "s3bucket": "boxen-downloads",
  "s3host": "s3.amazonaws.com",
  "repotemplate": "https://github.com/%s",
  "user": "$REAL_USER",
  "srcdir": "/Users/${REAL_USER}/src",
  "ghurl": "https://github.com",
  "email": "shuff@vecna.org",
  "fde": false,
  "homedir": "/opt/boxen",
  "login": "hakamadare",
  "name": "Steve Huff",
  "puppetdir": "/tmp/boxen/puppet",
  "repodir": "/Users/${REAL_USER}/git/our-boxen",
  "reponame": "hakamadare/our-boxen"
}
DEFAULTS
  fi
fi
