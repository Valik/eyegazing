# RVM
require "rvm/capistrano"
set :rvm_ruby_string, '2.1.2'

# Server
set :application, 'gazingdates'
set :repository,  "git@bitbucket.org:longway/gazingdates.git"
set :user, 'longway'
set :use_sudo, false
set :deploy_to, "/home/#{user}/sites/#{application}"
server '78.47.106.99', :web, :app, :db, :primary => true
_cset :thin_config, File.join(current_path,'config','thin.yml')

# SCM
set :scm, :git
set :branch, "deploy"
set :deploy_via, :remote_cache
set :keep_releases, 5

# Bundler
require 'bundler/capistrano'
_cset(:bundle_exec) { "cd #{latest_release}; RAILS_ENV=production bundle exec" }

# Assets
load "deploy/assets"

namespace :app do
  task :symlink_configs do
    shared_configs = File.join(shared_path,'config')
    release_configs = File.join(release_path,'config')
    run("ln -nfs #{shared_configs}/database.yml #{release_configs}/database.yml")
    run("ln -nfs #{shared_configs}/thin.yml #{release_configs}/thin.yml")
    # isn't in gitingore in this project
    # run("ln -nfs #{shared_configs}/secrets.yml #{release_configs}/secrets.yml")
  end
end

namespace :db do
  # Don't forget to grant privileges to user:
  # mysql -u root -p -e "grant all privileges on $APP_NAME.* to deployer@localhost identified by 'mydeployer'"
  task :setup do
    run "#{bundle_exec} rake db:create"
    run "#{bundle_exec} rake db:migrate"
  end
end

# Start/stop
namespace :deploy do

  task :start do
    run "#{bundle_exec} thin start -C #{thin_config}"
  end
  task :stop do
    run "#{bundle_exec} thin stop -C #{thin_config}"
  end
  task :restart, roles: :app, except: { no_release: true } do
    run "#{bundle_exec} thin restart -O -C #{thin_config}"
  end
end

after 'deploy:finalize_update', 'app:symlink_configs'
after "deploy:restart", "deploy:cleanup"