require "capistrano/ext/multistage"
require "bundler/capistrano"
require "capistrano-rbenv"

set :rbenv_ruby_version, 'jruby-1.7.5'

set :stages, %w(integration production)
set :default_stage, "integration"

set :application, "lvb-fahrplan-api"
set :deploy_to, "/var/www/vhosts/#{application}"

set :scm, "git"
#set :repository, "gitolite@git.it.ewerk.com:lvb-fahrplan-api"
set :repository, "."

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

namespace :deploy do
  %w[start stop restart reload].each do |command|
    desc "#{command} unicorn server"
    task command, roles: :app, except: {no_release: true} do
      p "running"
      #run "/etc/init.d/unicorn_lvb-traffic-check #{command}"
    end
  end
end
