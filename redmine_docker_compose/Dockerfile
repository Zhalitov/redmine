FROM ubuntu:focal

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
    && apt-get install gnupg2 curl imagemagick libmysqlclient-dev libmagickwand-dev -y
# Установка rvm
RUN curl -sSL https://rvm.io/mpapis.asc | gpg --import - \
    && curl -sSL https://rvm.io/pkuczynski.asc | gpg --import - \	
    && curl -sSL https://get.rvm.io | bash -s stable \
    && usermod -a -G rvm root 
# Установка ruby
SHELL [ "/usr/bin/bash", "-l", "-c" ]
RUN source /etc/profile.d/rvm.sh \
    && rvm autolibs enable \
    && rvm install ruby-2.7.2 \
    && rvm --default use ruby-2.7.2
 
WORKDIR  /opt/redmine-4.2.1

# Установка Redmine
RUN curl --output redmine-4.2.1.tar.gz https://www.redmine.org/releases/redmine-4.2.1.tar.gz \
    && tar -C /opt -zxvf redmine-4.2.1.tar.gz \
    && rm -f redmine-4.2.1.tar.gz 

ADD database.yml /opt/redmine-4.2.1/config/

RUN echo "gem 'puma'" > Gemfile.local 
 
RUN bundle install --without development test \
    && bundle exec rake generate_secret_token \
    && mkdir -p tmp tmp/pdf public/plugin_assets 

EXPOSE 3000

ADD entrypoint.sh .
ENTRYPOINT [ "./entrypoint.sh" ]
