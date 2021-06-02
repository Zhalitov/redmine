#!/usr/bin/env bash
source /etc/profile.d/rvm.sh
bundle exec puma -p 3000 -e production
