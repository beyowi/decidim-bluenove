FROM decidim/decidim:0.22.0

RUN gem install bundler:2.1.4
RUN bundle install
