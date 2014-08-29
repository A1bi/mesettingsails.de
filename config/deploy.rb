require "bundler/capistrano"
require "rvm/capistrano"

load "config/recipes/base"
load "config/recipes/nginx"
load "config/recipes/unicorn"
load "config/recipes/memcached"

server "213.239.219.83", :web, :app, :db, :resque_worker, :resque_scheduler, primary: true

set :user, "deployer"
set :application, "MSS"
set :github_user, "A1bi"
set :domain_name, "mesettingsails.de"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
set :repository, "git@github.com:#{github_user}/#{domain_name}.git"
set :branch, "master"
set :git_enable_submodules, 1

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup" # keep only the last 5 releases