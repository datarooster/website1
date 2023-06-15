FROM ubuntu:latest

RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y git && apt-get install -y software-properties-common
RUN apt-get install -y python-pip python3 ruby-full build-essential
RUN apt-get install -y vim

# build ruby configuration
RUN mkdir gems \
    && echo '# Install Ruby Gems to /gems' >> /gems/.bashrc \
    && echo 'export GEM_HOME=/gems' >> /gems/.bashrc \
    && echo 'export PATH=/gems/bin:$PATH' >> /gems/.bashrc \
    && /bin/bash -c "source /gems/.bashrc"

# install jekyll
RUN gem install jekyll bundler

RUN apt-get install -y libvips42 imagemagick libjpeg8
RUN apt-get install -y g++ musl-dev make zlib1g build-essential
RUN apt-get install -y libpng-dev libwebp-dev
RUN apt-get install -y libvips libvips-dev libvips-tools
EXPOSE 4000

WORKDIR /site

# on every container start, check if Gemfile exists and warn if it's missing
ENTRYPOINT [ "/site/docker-entrypoint.sh" ]
CMD [ "bundle", "exec", "jekyll", "serve", "--force_polling", "-H", "0.0.0.0", "-P", "4000" ]