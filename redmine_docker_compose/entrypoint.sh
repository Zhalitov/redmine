#!/usr/bin/env bash
source /etc/profile.d/rvm.sh
RAILS_ENV=production bundle exec rake db:migrate
RAILS_ENV=production REDMINE_LANG=ru bundle exec rake redmine:load_default_data
bundle exec puma -p 3000 -e production
