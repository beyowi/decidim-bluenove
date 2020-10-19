# decidim_bluenove

Free Open-Source participatory democracy, citizen participation and open government for cities and organizations

This is the open-source repository for decidim_bluenove, based on [Decidim](https://github.com/decidim/decidim).

## Installation

1. Follow the installation guides for installation on production/staging servers: [official](https://github.com/decidim/decidim/blob/master/docs/getting_started.md) or [Platoniq](https://platoniq.github.io/decidim-install/). If using the Platoniq script, activate the Capistrano mode at installation using `./install-decidim.sh -c my-folder`.

2. Edit `config/application.yml` file and define configuration ENV variables:

In your Development environment with:
```ruby
# DB
DATABASE_HOST, DATABASE_USERNAME, DATABASE_PASSWORD

# Staging server info if application
STAGING_SERVER_ADDRESS, STAGING_SERVER_USER

# Frontend server info for each node
PROD_SERVER_ADDRESS_FRONT_X, PROD_SERVER_USER
```

In each staging/production server with:
```ruby
# DB
DATABASE_URL

# Bucket configuration for DO or S3
DO_KEY, DO_SECRET, DO_REGION, DO_BUCKET, DO_HOST, DO_ENDPOINT

# Recipients for daily data report
DB_DUMP_EMAILS
```

3. Define server deployment for all frontend servers in `config/deploy/production.rb`.

4. If you don't want to use a bucket for file storage, modify `config/initializers/carrierwave.rb` and set default values.

5. Setup your Nginx SSL configuration in production (mandatory).

6. For daily report, create a cronjob on production server:
```
crontab -e
00 02 * * * export PATH=$HOME/.rbenv/shims:$HOME/.rbenv/bin:/usr/bin:$PATH; eval "$(rbenv init -)"; cd [PROJECT_PATH]/current && bin/rake dataexport:full_db RAILS_ENV=production
```

## Deployment

1. Use Capistrano for deployment on each environment (staging or production) with command `cap [ENVIRONMENT] deploy`. Production targets branch `master`, Staging targets `develop`.

## Setting up the application

You will need to do some steps before having the app working properly once you've deployed it:

1. Open a Rails console in the server: `bundle exec rails console`
2. Create a System Admin user:
```ruby
user = Decidim::System::Admin.new(email: <email>, password: <password>, password_confirmation: <password>)
user.save!
```
3. Visit `<your app url>/system` and login with your system admin credentials
4. Create a new organization. Check the locales you want to use for that organization, and select a default locale.
5. Set the correct default host for the organization, otherwise the app will not work properly. Note that you need to include any subdomain you might be using.
6. Fill the rest of the form and submit it.

You're good to go!
